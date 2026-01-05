import Foundation

// MARK: - Product Model

struct Product: Identifiable, Codable, Hashable {
    let id: UUID
    let brandId: UUID
    let categoryId: UUID
    let name: String
    let slug: String
    let description: String?
    let price: Decimal
    let originalPrice: Decimal?
    let currency: String
    let gender: GenderCategory
    let closureType: ClosureType?
    let imageUrl: String?
    let imageUrls: [String]?
    let productUrl: String
    let affiliateUrl: String?
    let isAvailable: Bool
    let availableSizes: [String]?
    let safetyNotes: String?
    let pacemakerSafe: Bool?
    let reviewCount: Int
    let averageRating: Decimal?
    let saveCount: Int
    let createdAt: Date
    let updatedAt: Date

    // MARK: - Display Properties (populated from joins)

    var brandName: String?

    // MARK: - Computed Properties

    var isOnSale: Bool {
        guard let original = originalPrice else { return false }
        return price < original
    }

    var discountPercentage: Int? {
        guard let original = originalPrice, original > 0 else { return nil }
        let discount = ((original - price) / original) * 100
        return Int(truncating: discount as NSNumber)
    }

    var formattedPrice: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = currency
        return formatter.string(from: price as NSNumber) ?? "$\(price)"
    }

    var formattedOriginalPrice: String? {
        guard let original = originalPrice else { return nil }
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = currency
        return formatter.string(from: original as NSNumber)
    }

    var ratingText: String? {
        guard let rating = averageRating else { return nil }
        return String(format: "%.1f", Double(truncating: rating as NSNumber))
    }
}

// MARK: - Closure Types

enum ClosureType: String, Codable, CaseIterable {
    case magnetic
    case velcro
    case snap
    case sideZip = "side_zip"
    case backOpening = "back_opening"
    case pullOn = "pull_on"
    case frontOpening = "front_opening"
    case easyGripZipper = "easy_grip_zipper"
    case hookAndLoop = "hook_and_loop"
    case elastic
    case wrapTie = "wrap_tie"
    case none

    var displayName: String {
        switch self {
        case .magnetic: return "Magnetic"
        case .velcro: return "Velcro"
        case .snap: return "Snap"
        case .sideZip: return "Side Zip"
        case .backOpening: return "Back Opening"
        case .pullOn: return "Pull-On"
        case .frontOpening: return "Front Opening"
        case .easyGripZipper: return "Easy-Grip Zipper"
        case .hookAndLoop: return "Hook & Loop"
        case .elastic: return "Elastic"
        case .wrapTie: return "Wrap & Tie"
        case .none: return "None"
        }
    }
}

// MARK: - Gender Categories

enum GenderCategory: String, Codable, CaseIterable {
    case mens
    case womens
    case unisex
    case boys
    case girls
    case kidsUnisex = "kids_unisex"

    var displayName: String {
        switch self {
        case .mens: return "Men's"
        case .womens: return "Women's"
        case .unisex: return "Unisex"
        case .boys: return "Boys"
        case .girls: return "Girls"
        case .kidsUnisex: return "Kids"
        }
    }

    var isKids: Bool {
        switch self {
        case .boys, .girls, .kidsUnisex: return true
        default: return false
        }
    }
}

// MARK: - Product Category

enum ProductCategory: String, Codable, CaseIterable {
    case tops
    case bottoms
    case dresses
    case outerwear
    case sleepwear
    case underwear
    case footwear
    case accessories
    case kidsTops = "kids_tops"
    case kidsBottoms = "kids_bottoms"
    case kidsDresses = "kids_dresses"
    case kidsFootwear = "kids_footwear"
    case kidsAccessories = "kids_accessories"

    var displayName: String {
        switch self {
        case .tops: return "Tops"
        case .bottoms: return "Bottoms"
        case .dresses: return "Dresses"
        case .outerwear: return "Outerwear"
        case .sleepwear: return "Sleepwear"
        case .underwear: return "Underwear"
        case .footwear: return "Footwear"
        case .accessories: return "Accessories"
        case .kidsTops: return "Kids Tops"
        case .kidsBottoms: return "Kids Bottoms"
        case .kidsDresses: return "Kids Dresses"
        case .kidsFootwear: return "Kids Footwear"
        case .kidsAccessories: return "Kids Accessories"
        }
    }

    var iconName: String {
        switch self {
        case .tops, .kidsTops: return "tshirt"
        case .bottoms, .kidsBottoms: return "figure.stand"
        case .dresses, .kidsDresses: return "figure.dress.line.vertical.figure"
        case .outerwear: return "cloud.rain"
        case .sleepwear: return "moon.stars"
        case .underwear: return "heart"
        case .footwear, .kidsFootwear: return "shoe"
        case .accessories, .kidsAccessories: return "bag"
        }
    }
}
