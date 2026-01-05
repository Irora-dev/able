import Foundation

// MARK: - Product Service

@MainActor
final class ProductService: ObservableObject {
    static let shared = ProductService()

    @Published private(set) var allProducts: [Product] = []
    @Published private(set) var featuredProducts: [Product] = []
    @Published private(set) var newArrivals: [Product] = []
    @Published private(set) var onSale: [Product] = []
    @Published private(set) var isLoading = false
    @Published private(set) var error: Error?

    private var cachedProducts: [Product] = []
    private var lastFetchTime: Date?
    private let cacheTimeout: TimeInterval = 300 // 5 minutes

    private init() {}

    // MARK: - Fetch All Products

    func fetchAllProducts(forceRefresh: Bool = false) async {
        // Check cache
        if !forceRefresh,
           let lastFetch = lastFetchTime,
           Date().timeIntervalSince(lastFetch) < cacheTimeout,
           !cachedProducts.isEmpty {
            return
        }

        isLoading = true
        error = nil

        do {
            let products: [Product] = try await SupabaseClient.shared.fetch(
                from: "products",
                query: QueryBuilder()
                    .eq("is_available", "true")
                    .order("created_at", ascending: false)
            )

            cachedProducts = products
            allProducts = products
            lastFetchTime = Date()

            // Compute derived lists
            computeDerivedLists()

        } catch {
            self.error = error
            print("Error fetching products: \(error)")
        }

        isLoading = false
    }

    // MARK: - Filtered Queries

    func fetchProducts(
        matching preferences: UserPreferences,
        category: UUID? = nil,
        searchQuery: String? = nil,
        limit: Int = 50
    ) async -> [Product] {
        // Ensure we have data
        if cachedProducts.isEmpty {
            await fetchAllProducts()
        }

        var filtered = cachedProducts

        // Filter by gender preference
        if let gender = preferences.preferredGender {
            filtered = filtered.filter { product in
                product.gender == gender ||
                product.gender == .unisex ||
                (gender.isKids && product.gender.isKids)
            }
        }

        // Filter by category
        if let categoryId = category {
            filtered = filtered.filter { $0.categoryId == categoryId }
        }

        // Filter by search query
        if let query = searchQuery?.lowercased(), !query.isEmpty {
            filtered = filtered.filter { product in
                product.name.lowercased().contains(query) ||
                (product.brandName?.lowercased().contains(query) ?? false)
            }
        }

        // Filter by price tier
        if let priceTier = preferences.preferredPriceTier {
            filtered = filtered.filter { product in
                switch priceTier {
                case .budget: return product.price < 50
                case .mid: return product.price >= 50 && product.price < 150
                case .premium: return product.price >= 150
                }
            }
        }

        // Filter by selected features
        if !preferences.selectedFeatureIds.isEmpty {
            // Products that have at least one matching feature
            // In real implementation, would join with product_features table
            filtered = filtered.filter { product in
                // For mock data, we use closureType as a proxy for features
                guard let closureType = product.closureType else { return true }
                return matchesFeaturePreferences(closureType: closureType, preferences: preferences)
            }
        }

        // Sort by relevance (products with more matching features first)
        filtered = sortByRelevance(products: filtered, preferences: preferences)

        return Array(filtered.prefix(limit))
    }

    // MARK: - Category Queries

    func fetchProducts(forCategory categoryId: UUID, limit: Int = 50) async -> [Product] {
        if cachedProducts.isEmpty {
            await fetchAllProducts()
        }

        return cachedProducts
            .filter { $0.categoryId == categoryId }
            .prefix(limit)
            .map { $0 }
    }

    // MARK: - Brand Queries

    func fetchProducts(forBrand brandId: UUID, limit: Int = 50) async -> [Product] {
        if cachedProducts.isEmpty {
            await fetchAllProducts()
        }

        return cachedProducts
            .filter { $0.brandId == brandId }
            .prefix(limit)
            .map { $0 }
    }

    // MARK: - Search

    func search(query: String, limit: Int = 50) async -> [Product] {
        if cachedProducts.isEmpty {
            await fetchAllProducts()
        }

        let lowercased = query.lowercased()

        return cachedProducts
            .filter { product in
                product.name.lowercased().contains(lowercased) ||
                (product.brandName?.lowercased().contains(lowercased) ?? false) ||
                (product.description?.lowercased().contains(lowercased) ?? false)
            }
            .prefix(limit)
            .map { $0 }
    }

    // MARK: - Private Helpers

    private func computeDerivedLists() {
        // Featured: High-rated products
        featuredProducts = cachedProducts
            .filter { ($0.averageRating ?? 0) >= 4.5 }
            .sorted { ($0.averageRating ?? 0) > ($1.averageRating ?? 0) }
            .prefix(10)
            .map { $0 }

        // New arrivals: Most recent
        newArrivals = cachedProducts
            .sorted { $0.createdAt > $1.createdAt }
            .prefix(10)
            .map { $0 }

        // On sale
        onSale = cachedProducts
            .filter { $0.isOnSale }
            .sorted { ($0.discountPercentage ?? 0) > ($1.discountPercentage ?? 0) }
            .prefix(10)
            .map { $0 }
    }

    private func matchesFeaturePreferences(closureType: ClosureType, preferences: UserPreferences) -> Bool {
        let featureMapping: [ClosureType: String] = [
            .magnetic: "aaaa1111-1111-1111-1111-111111111111",
            .velcro: "aaaa2222-2222-2222-2222-222222222222",
            .hookAndLoop: "aaaa2222-2222-2222-2222-222222222222",
            .sideZip: "aaaa5555-5555-5555-5555-555555555555",
            .pullOn: "aaaa8888-8888-8888-8888-888888888888"
        ]

        guard let featureId = featureMapping[closureType] else { return true }
        return preferences.selectedFeatureIds.contains(featureId)
    }

    private func sortByRelevance(products: [Product], preferences: UserPreferences) -> [Product] {
        products.sorted { p1, p2 in
            let score1 = relevanceScore(for: p1, preferences: preferences)
            let score2 = relevanceScore(for: p2, preferences: preferences)
            return score1 > score2
        }
    }

    private func relevanceScore(for product: Product, preferences: UserPreferences) -> Int {
        var score = 0

        // Boost for matching gender
        if product.gender == preferences.preferredGender {
            score += 10
        }

        // Boost for high rating
        if let rating = product.averageRating, rating >= 4.5 {
            score += 5
        }

        // Boost for many reviews
        if product.reviewCount > 50 {
            score += 3
        }

        // Boost for sale items
        if product.isOnSale {
            score += 2
        }

        return score
    }
}

// MARK: - User Preferences

struct UserPreferences {
    var preferredGender: GenderCategory?
    var preferredPriceTier: PriceTier?
    var selectedFeatureIds: Set<String> = []
    var selectedChallengeIds: Set<String> = []

    static let `default` = UserPreferences()
}
