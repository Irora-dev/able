import Foundation

// MARK: - Category Service

@MainActor
final class CategoryService: ObservableObject {
    static let shared = CategoryService()

    @Published private(set) var allCategories: [Category] = []
    @Published private(set) var rootCategories: [Category] = []
    @Published private(set) var isLoading = false
    @Published private(set) var error: Error?

    private var lastFetchTime: Date?
    private let cacheTimeout: TimeInterval = 600 // 10 minutes

    private init() {}

    // MARK: - Fetch Categories

    func fetchAllCategories(forceRefresh: Bool = false) async {
        // Check cache
        if !forceRefresh,
           let lastFetch = lastFetchTime,
           Date().timeIntervalSince(lastFetch) < cacheTimeout,
           !allCategories.isEmpty {
            return
        }

        isLoading = true
        error = nil

        do {
            let categories: [Category] = try await SupabaseClient.shared.fetch(
                from: "categories",
                query: QueryBuilder()
                    .eq("is_active", "true")
                    .order("sort_order", ascending: true)
            )

            allCategories = categories
            rootCategories = Category.rootCategories(from: categories)
            lastFetchTime = Date()

        } catch {
            self.error = error
            print("Error fetching categories: \(error)")
        }

        isLoading = false
    }

    // MARK: - Get Category

    func category(withId id: UUID) -> Category? {
        allCategories.first { $0.id == id }
    }

    func category(withSlug slug: String) -> Category? {
        allCategories.first { $0.slug == slug }
    }

    // MARK: - Children

    func children(of categoryId: UUID) -> [Category] {
        Category.children(of: categoryId, from: allCategories)
    }
}
