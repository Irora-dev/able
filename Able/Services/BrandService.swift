import Foundation

// MARK: - Brand Service

@MainActor
final class BrandService: ObservableObject {
    static let shared = BrandService()

    @Published private(set) var allBrands: [Brand] = []
    @Published private(set) var adaptiveOnlyBrands: [Brand] = []
    @Published private(set) var mainstreamBrands: [Brand] = []
    @Published private(set) var isLoading = false
    @Published private(set) var error: Error?

    private var lastFetchTime: Date?
    private let cacheTimeout: TimeInterval = 600 // 10 minutes

    private init() {}

    // MARK: - Fetch Brands

    func fetchAllBrands(forceRefresh: Bool = false) async {
        // Check cache
        if !forceRefresh,
           let lastFetch = lastFetchTime,
           Date().timeIntervalSince(lastFetch) < cacheTimeout,
           !allBrands.isEmpty {
            return
        }

        isLoading = true
        error = nil

        do {
            let brands: [Brand] = try await SupabaseClient.shared.fetch(
                from: "brands",
                query: QueryBuilder()
                    .eq("is_active", "true")
                    .order("name", ascending: true)
            )

            allBrands = brands
            lastFetchTime = Date()

            // Compute derived lists
            adaptiveOnlyBrands = brands.filter { $0.isAdaptiveOnly }
            mainstreamBrands = brands.filter { $0.hasMainstreamLine }

        } catch {
            self.error = error
            print("Error fetching brands: \(error)")
        }

        isLoading = false
    }

    // MARK: - Get Brand

    func brand(withId id: UUID) -> Brand? {
        allBrands.first { $0.id == id }
    }

    func brand(withSlug slug: String) -> Brand? {
        allBrands.first { $0.slug == slug }
    }

    // MARK: - Filter by Price Tier

    func brands(forPriceTier tier: PriceTier) -> [Brand] {
        allBrands.filter { $0.priceTier == tier }
    }
}

// MARK: - Brand Extensions

extension Brand {
    var productCountText: String {
        // Would be computed from actual product count
        "View products"
    }
}
