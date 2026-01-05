import Foundation

// MARK: - Review Model

struct Review: Identifiable, Codable {
    let id: UUID
    let productId: UUID
    let userId: UUID
    let rating: Int
    var title: String?
    let body: String
    var reviewerChallenges: [String]?
    var isCaregiverReview: Bool
    var easeOfDressingRating: Int?
    var qualityRating: Int?
    var styleRating: Int?
    var valueRating: Int?
    var sizePurchased: String?
    var fitFeedback: FitFeedback?
    var isVerifiedPurchase: Bool
    var isApproved: Bool
    var isFlagged: Bool
    var helpfulCount: Int
    let createdAt: Date
    var updatedAt: Date

    // MARK: - Relationships

    var product: Product?
    var userProfile: UserProfile?

    // MARK: - Computed Properties

    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: createdAt)
    }

    var relativeDate: String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .abbreviated
        return formatter.localizedString(for: createdAt, relativeTo: Date())
    }

    var hasDetailedRatings: Bool {
        easeOfDressingRating != nil ||
        qualityRating != nil ||
        styleRating != nil ||
        valueRating != nil
    }

    var averageDetailedRating: Double? {
        let ratings = [easeOfDressingRating, qualityRating, styleRating, valueRating].compactMap { $0 }
        guard !ratings.isEmpty else { return nil }
        return Double(ratings.reduce(0, +)) / Double(ratings.count)
    }
}

// MARK: - Fit Feedback

enum FitFeedback: String, Codable, CaseIterable {
    case runsSmall = "runs_small"
    case trueToSize = "true_to_size"
    case runsLarge = "runs_large"

    var displayName: String {
        switch self {
        case .runsSmall: return "Runs Small"
        case .trueToSize: return "True to Size"
        case .runsLarge: return "Runs Large"
        }
    }

    var recommendation: String {
        switch self {
        case .runsSmall: return "Consider sizing up"
        case .trueToSize: return "Order your usual size"
        case .runsLarge: return "Consider sizing down"
        }
    }
}

// MARK: - Review Helpful Vote

struct ReviewHelpful: Identifiable, Codable {
    let id: UUID
    let reviewId: UUID
    let userId: UUID
    let vote: VoteType
    let createdAt: Date
}

enum VoteType: String, Codable {
    case helpful
    case notHelpful = "not_helpful"
}

// MARK: - Review Summary

struct ReviewSummary {
    let totalCount: Int
    let averageRating: Double
    let ratingDistribution: [Int: Int] // rating -> count
    let topChallenges: [String]
    let fitConsensus: FitFeedback?

    var fiveStarPercentage: Double {
        guard totalCount > 0 else { return 0 }
        return Double(ratingDistribution[5] ?? 0) / Double(totalCount) * 100
    }

    var recommendationPercentage: Double {
        guard totalCount > 0 else { return 0 }
        let positiveCount = (ratingDistribution[4] ?? 0) + (ratingDistribution[5] ?? 0)
        return Double(positiveCount) / Double(totalCount) * 100
    }
}
