import Foundation

// MARK: - User Profile Model

struct UserProfile: Identifiable, Codable {
    let id: UUID
    var displayName: String?
    var avatarUrl: String?
    var currentMode: UserMode
    var preferredGender: GenderCategory?
    var preferredSizes: [String]?
    var preferredPriceTier: PriceTier?
    var onboardingCompleted: Bool
    var onboardingStep: Int
    var notificationsEnabled: Bool
    var emailNewArrivals: Bool
    var emailSavedItemSales: Bool
    let createdAt: Date
    var updatedAt: Date
    var lastActiveAt: Date?

    // MARK: - Relationships

    var userNeeds: [UserNeed]?
    var careRecipients: [CareRecipient]?
    var savedItems: [SavedItem]?

    // MARK: - Computed Properties

    var isCaregiver: Bool {
        currentMode == .caregiver
    }

    var hasCompletedOnboarding: Bool {
        onboardingCompleted
    }

    var activeCareRecipient: CareRecipient? {
        careRecipients?.first { $0.isActive }
    }
}

// MARK: - User Mode

enum UserMode: String, Codable, CaseIterable {
    case individual
    case caregiver

    var displayName: String {
        switch self {
        case .individual: return "Myself"
        case .caregiver: return "Someone else"
        }
    }

    var description: String {
        switch self {
        case .individual: return "I'm looking for clothes that fit my needs"
        case .caregiver: return "I'm a caregiver, parent, or shopping for another person"
        }
    }
}

// MARK: - User Need

struct UserNeed: Identifiable, Codable {
    let id: UUID
    let userId: UUID
    let challengeId: UUID
    var careRecipientId: UUID?
    var priority: Int
    let createdAt: Date

    // MARK: - Relationship

    var challenge: UserChallenge?
}

// MARK: - Care Recipient

struct CareRecipient: Identifiable, Codable {
    let id: UUID
    let userId: UUID
    var name: String
    var relationship: String?
    var gender: GenderCategory?
    var sizes: [String]?
    var pricePreference: PriceTier?
    var notes: String?
    var isActive: Bool
    let createdAt: Date
    var updatedAt: Date

    // MARK: - Relationships

    var needs: [UserNeed]?
}

// MARK: - Saved Item

struct SavedItem: Identifiable, Codable {
    let id: UUID
    let userId: UUID
    let productId: UUID
    var careRecipientId: UUID?
    var collectionName: String?
    var notes: String?
    var priceWhenSaved: Decimal?
    let createdAt: Date

    // MARK: - Relationships

    var product: Product?

    // MARK: - Computed Properties

    var hasPriceDropped: Bool {
        guard let savedPrice = priceWhenSaved,
              let currentPrice = product?.price else {
            return false
        }
        return currentPrice < savedPrice
    }

    var priceDrop: Decimal? {
        guard let savedPrice = priceWhenSaved,
              let currentPrice = product?.price,
              currentPrice < savedPrice else {
            return nil
        }
        return savedPrice - currentPrice
    }
}

// MARK: - Default Sizes

extension UserProfile {

    static let standardSizes = [
        "XS", "S", "M", "L", "XL", "XXL", "3XL", "4XL"
    ]

    static let numericSizes = [
        "0", "2", "4", "6", "8", "10", "12", "14", "16", "18", "20", "22", "24"
    ]

    static let kidsSizes = [
        "2T", "3T", "4T", "5", "6", "7", "8", "10", "12", "14", "16"
    ]

    static let shoeSizes = [
        "5", "5.5", "6", "6.5", "7", "7.5", "8", "8.5", "9", "9.5",
        "10", "10.5", "11", "11.5", "12", "13", "14", "15"
    ]
}
