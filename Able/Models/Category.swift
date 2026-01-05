import Foundation

// MARK: - Category Model

struct Category: Identifiable, Codable, Hashable {
    let id: UUID
    let name: String
    let slug: String
    let description: String?
    let parentId: UUID?
    let categoryType: ProductCategory
    let iconName: String?
    let imageUrl: String?
    let sortOrder: Int
    let isActive: Bool
    let createdAt: Date
    let updatedAt: Date

    // MARK: - Additional Properties

    var productCount: Int?

    // MARK: - Computed Properties

    var isTopLevel: Bool {
        parentId == nil
    }

    var hasChildren: Bool {
        false // Computed from external data
    }

    var systemIconName: String {
        iconName ?? categoryType.iconName
    }
}

// MARK: - Category Helpers

extension Category {

    /// Get root categories from a list
    static func rootCategories(from categories: [Category]) -> [Category] {
        categories
            .filter { $0.parentId == nil }
            .sorted { $0.sortOrder < $1.sortOrder }
    }

    /// Get children of a category from a list
    static func children(of categoryId: UUID, from categories: [Category]) -> [Category] {
        categories
            .filter { $0.parentId == categoryId }
            .sorted { $0.sortOrder < $1.sortOrder }
    }
}
