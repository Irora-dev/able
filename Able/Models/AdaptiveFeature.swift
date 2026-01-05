import Foundation

// MARK: - Adaptive Feature Model

struct AdaptiveFeature: Identifiable, Codable, Hashable {
    let id: UUID
    let name: String
    let slug: String
    let description: String?
    let category: FeatureCategory
    let iconName: String?
    let searchTerms: [String]?
    let displayName: String
    let badgeText: String?
    let isActive: Bool
    let sortOrder: Int
    let createdAt: Date
    let updatedAt: Date

    // MARK: - Computed Properties

    var systemIconName: String {
        iconName ?? category.defaultIconName
    }
}

// MARK: - Feature Category

enum FeatureCategory: String, Codable, CaseIterable {
    case closure
    case fit
    case sensory
    case specialized
    case easeOfDressing = "ease_of_dressing"

    var displayName: String {
        switch self {
        case .closure: return "Closures"
        case .fit: return "Fit & Cut"
        case .sensory: return "Sensory"
        case .specialized: return "Specialized"
        case .easeOfDressing: return "Ease of Dressing"
        }
    }

    var defaultIconName: String {
        switch self {
        case .closure: return "button.programmable"
        case .fit: return "ruler"
        case .sensory: return "hand.raised"
        case .specialized: return "star"
        case .easeOfDressing: return "figure.dress.line.vertical.figure"
        }
    }

    var sortOrder: Int {
        switch self {
        case .closure: return 0
        case .easeOfDressing: return 1
        case .fit: return 2
        case .sensory: return 3
        case .specialized: return 4
        }
    }
}

// MARK: - User Challenge Model

struct UserChallenge: Identifiable, Codable, Hashable {
    let id: UUID
    let name: String
    let slug: String
    let displayText: String
    let description: String?
    let iconName: String?
    let sortOrder: Int
    let isActive: Bool
    let createdAt: Date
    let updatedAt: Date

    // MARK: - Mapped Features

    var mappedFeatures: [AdaptiveFeature]?
}

// MARK: - Predefined Challenges

extension UserChallenge {

    /// Challenge categories for onboarding
    static let challengeCategories = [
        "Limited hand mobility",
        "Limited arm mobility",
        "Use a wheelchair",
        "Sensory sensitivities",
        "One-hand dressing",
        "Balance difficulties",
        "Require caregiver assistance",
        "Post-surgery recovery",
        "Arthritis/joint pain",
        "Visual impairment"
    ]
}

// MARK: - Challenge to Feature Mapping

struct ChallengeFeatureMapping: Identifiable, Codable {
    let id: UUID
    let challengeId: UUID
    let featureId: UUID
    let relevanceScore: Int
    let createdAt: Date
}
