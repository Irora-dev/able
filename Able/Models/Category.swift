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

    // MARK: - Relationships

    var parent: Category?
    var children: [Category]?
    var productCount: Int?

    // MARK: - Computed Properties

    var isTopLevel: Bool {
        parentId == nil
    }

    var hasChildren: Bool {
        guard let children = children else { return false }
        return !children.isEmpty
    }

    var systemIconName: String {
        iconName ?? categoryType.iconName
    }
}

// MARK: - Category Hierarchy

extension Category {

    /// Build category tree from flat list
    static func buildTree(from categories: [Category]) -> [Category] {
        let lookup = Dictionary(uniqueKeysWithValues: categories.map { ($0.id, $0) })
        var roots: [Category] = []

        for var category in categories {
            if category.parentId == nil {
                category.children = categories
                    .filter { $0.parentId == category.id }
                    .sorted { $0.sortOrder < $1.sortOrder }
                roots.append(category)
            }
        }

        return roots.sorted { $0.sortOrder < $1.sortOrder }
    }
}
