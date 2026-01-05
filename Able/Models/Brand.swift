import Foundation

// MARK: - Brand Model

struct Brand: Identifiable, Codable, Hashable {
    let id: UUID
    let name: String
    let slug: String
    let description: String?
    let logoUrl: String?
    let websiteUrl: String
    let isAdaptiveOnly: Bool
    let hasMainstreamLine: Bool
    let affiliateNetwork: String?
    let affiliateProgramId: String?
    let commissionRate: Decimal?
    let priceTier: PriceTier
    let isActive: Bool
    let createdAt: Date
    let updatedAt: Date

    // MARK: - Computed Properties

    var displayDescription: String {
        if isAdaptiveOnly {
            return "Adaptive-focused brand"
        } else if hasMainstreamLine {
            return "Mainstream brand with adaptive line"
        } else {
            return "Adaptive-friendly options"
        }
    }

    var priceTierLabel: String {
        priceTier.displayName
    }
}

// MARK: - Price Tier

enum PriceTier: String, Codable, CaseIterable {
    case budget
    case mid
    case premium

    var displayName: String {
        switch self {
        case .budget: return "Budget-Friendly"
        case .mid: return "Mid-Range"
        case .premium: return "Premium"
        }
    }

    var priceIndicator: String {
        switch self {
        case .budget: return "$"
        case .mid: return "$$"
        case .premium: return "$$$"
        }
    }
}

// MARK: - Known Brands (for reference)

extension Brand {

    /// Known adaptive-focused brands
    static let adaptiveBrands = [
        "Tommy Adaptive",
        "Zappos Adaptive",
        "Target Cat & Jack Adaptive",
        "Kohl's Adaptive",
        "JCPenney Adaptive",
        "IZ Adaptive",
        "ABL Denim",
        "Slick Chicks",
        "Juniper",
        "No Limbits"
    ]

    /// Known mainstream brands with adaptive lines
    static let mainstreamWithAdaptive = [
        "Nike FlyEase",
        "UGG",
        "Lands' End",
        "ASOS",
        "M&S Easy Dressing"
    ]
}
