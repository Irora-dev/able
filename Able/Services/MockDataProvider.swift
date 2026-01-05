import Foundation

// MARK: - Mock Data Provider

/// Provides realistic mock data for development and demos
actor MockDataProvider {

    static func fetch<T: Decodable>(from table: String, query: QueryBuilder) async throws -> [T] {
        // Simulate network delay
        try await Task.sleep(nanoseconds: 300_000_000)

        switch table {
        case "brands":
            return MockData.brands as! [T]
        case "products":
            return MockData.products as! [T]
        case "adaptive_features":
            return MockData.adaptiveFeatures as! [T]
        case "categories":
            return MockData.categories as! [T]
        default:
            return []
        }
    }
}

// MARK: - Mock Data

enum MockData {

    // MARK: - Brands

    static let brands: [Brand] = [
        Brand(
            id: UUID(uuidString: "11111111-1111-1111-1111-111111111111")!,
            name: "Tommy Adaptive",
            slug: "tommy-adaptive",
            description: "Tommy Hilfiger's adaptive clothing line featuring magnetic closures and seated fits",
            logoUrl: nil,
            websiteUrl: "https://usa.tommy.com/en/tommy-adaptive",
            isAdaptiveOnly: false,
            hasMainstreamLine: true,
            affiliateNetwork: "CJ Affiliate",
            affiliateProgramId: nil,
            commissionRate: 8.0,
            priceTier: .mid,
            isActive: true,
            createdAt: Date(),
            updatedAt: Date()
        ),
        Brand(
            id: UUID(uuidString: "22222222-2222-2222-2222-222222222222")!,
            name: "Zappos Adaptive",
            slug: "zappos-adaptive",
            description: "Curated adaptive clothing and footwear from multiple brands",
            logoUrl: nil,
            websiteUrl: "https://www.zappos.com/e/adaptive",
            isAdaptiveOnly: true,
            hasMainstreamLine: false,
            affiliateNetwork: "Amazon Associates",
            affiliateProgramId: nil,
            commissionRate: 7.0,
            priceTier: .mid,
            isActive: true,
            createdAt: Date(),
            updatedAt: Date()
        ),
        Brand(
            id: UUID(uuidString: "33333333-3333-3333-3333-333333333333")!,
            name: "Nike FlyEase",
            slug: "nike-flyease",
            description: "Easy on/off footwear with hands-free technology",
            logoUrl: nil,
            websiteUrl: "https://www.nike.com/flyease",
            isAdaptiveOnly: false,
            hasMainstreamLine: true,
            affiliateNetwork: "Awin",
            affiliateProgramId: nil,
            commissionRate: 5.0,
            priceTier: .premium,
            isActive: true,
            createdAt: Date(),
            updatedAt: Date()
        ),
        Brand(
            id: UUID(uuidString: "44444444-4444-4444-4444-444444444444")!,
            name: "Target Cat & Jack Adaptive",
            slug: "target-adaptive",
            description: "Affordable adaptive kids clothing with sensory-friendly options",
            logoUrl: nil,
            websiteUrl: "https://www.target.com/c/adaptive-clothing",
            isAdaptiveOnly: false,
            hasMainstreamLine: true,
            affiliateNetwork: "Impact",
            affiliateProgramId: nil,
            commissionRate: 4.0,
            priceTier: .budget,
            isActive: true,
            createdAt: Date(),
            updatedAt: Date()
        ),
        Brand(
            id: UUID(uuidString: "55555555-5555-5555-5555-555555555555")!,
            name: "IZ Adaptive",
            slug: "iz-adaptive",
            description: "Premium adaptive fashion designed by and for people with disabilities",
            logoUrl: nil,
            websiteUrl: "https://izadaptive.com",
            isAdaptiveOnly: true,
            hasMainstreamLine: false,
            affiliateNetwork: nil,
            affiliateProgramId: nil,
            commissionRate: 10.0,
            priceTier: .premium,
            isActive: true,
            createdAt: Date(),
            updatedAt: Date()
        ),
        Brand(
            id: UUID(uuidString: "66666666-6666-6666-6666-666666666666")!,
            name: "Slick Chicks",
            slug: "slick-chicks",
            description: "Side-opening underwear for easy dressing",
            logoUrl: nil,
            websiteUrl: "https://slickchicksonline.com",
            isAdaptiveOnly: true,
            hasMainstreamLine: false,
            affiliateNetwork: nil,
            affiliateProgramId: nil,
            commissionRate: 12.0,
            priceTier: .mid,
            isActive: true,
            createdAt: Date(),
            updatedAt: Date()
        )
    ]

    // MARK: - Adaptive Features

    static let adaptiveFeatures: [AdaptiveFeature] = [
        AdaptiveFeature(
            id: UUID(uuidString: "aaaa1111-1111-1111-1111-111111111111")!,
            name: "Magnetic Closures",
            slug: "magnetic-closures",
            description: "Hidden magnets behind buttons for easy one-hand fastening",
            category: .closure,
            iconName: "button.programmable",
            searchTerms: ["magnetic", "magnet", "easy button"],
            displayName: "Magnetic Closures",
            badgeText: "Easy Fasten",
            isActive: true,
            sortOrder: 1,
            createdAt: Date(),
            updatedAt: Date()
        ),
        AdaptiveFeature(
            id: UUID(uuidString: "aaaa2222-2222-2222-2222-222222222222")!,
            name: "Velcro Closures",
            slug: "velcro-closures",
            description: "Hook and loop closures for quick dressing",
            category: .closure,
            iconName: "rectangle.connected.to.line.below",
            searchTerms: ["velcro", "hook and loop", "hook-and-loop"],
            displayName: "Velcro",
            badgeText: nil,
            isActive: true,
            sortOrder: 2,
            createdAt: Date(),
            updatedAt: Date()
        ),
        AdaptiveFeature(
            id: UUID(uuidString: "aaaa3333-3333-3333-3333-333333333333")!,
            name: "Seated Cut",
            slug: "seated-cut",
            description: "Designed for wheelchair users with higher back rise and roomier seat",
            category: .fit,
            iconName: "figure.roll",
            searchTerms: ["seated", "wheelchair", "sitting"],
            displayName: "Seated Cut",
            badgeText: "Wheelchair Fit",
            isActive: true,
            sortOrder: 3,
            createdAt: Date(),
            updatedAt: Date()
        ),
        AdaptiveFeature(
            id: UUID(uuidString: "aaaa4444-4444-4444-4444-444444444444")!,
            name: "Sensory-Friendly",
            slug: "sensory-friendly",
            description: "Tagless, flat seams, and soft fabrics for sensory sensitivities",
            category: .sensory,
            iconName: "hand.raised",
            searchTerms: ["sensory", "tagless", "soft", "autism"],
            displayName: "Sensory-Friendly",
            badgeText: "Sensory Safe",
            isActive: true,
            sortOrder: 4,
            createdAt: Date(),
            updatedAt: Date()
        ),
        AdaptiveFeature(
            id: UUID(uuidString: "aaaa5555-5555-5555-5555-555555555555")!,
            name: "Side Opening",
            slug: "side-opening",
            description: "Side zippers or snaps for easier dressing while seated or lying down",
            category: .easeOfDressing,
            iconName: "arrow.left.and.right",
            searchTerms: ["side", "opening", "zipper"],
            displayName: "Side Opening",
            badgeText: nil,
            isActive: true,
            sortOrder: 5,
            createdAt: Date(),
            updatedAt: Date()
        ),
        AdaptiveFeature(
            id: UUID(uuidString: "aaaa6666-6666-6666-6666-666666666666")!,
            name: "Easy-On Footwear",
            slug: "easy-on-footwear",
            description: "Hands-free entry shoes with collapsible heels or zip entry",
            category: .easeOfDressing,
            iconName: "shoe",
            searchTerms: ["easy", "hands-free", "slip-on"],
            displayName: "Easy-On",
            badgeText: "Hands-Free",
            isActive: true,
            sortOrder: 6,
            createdAt: Date(),
            updatedAt: Date()
        ),
        AdaptiveFeature(
            id: UUID(uuidString: "aaaa7777-7777-7777-7777-777777777777")!,
            name: "One-Hand Friendly",
            slug: "one-hand-friendly",
            description: "Designed to be put on and fastened with one hand",
            category: .easeOfDressing,
            iconName: "hand.point.up.left",
            searchTerms: ["one hand", "single hand", "hemiplegia"],
            displayName: "One-Hand Friendly",
            badgeText: nil,
            isActive: true,
            sortOrder: 7,
            createdAt: Date(),
            updatedAt: Date()
        ),
        AdaptiveFeature(
            id: UUID(uuidString: "aaaa8888-8888-8888-8888-888888888888")!,
            name: "Pull-On Style",
            slug: "pull-on",
            description: "No buttons, zippers, or fasteners needed",
            category: .closure,
            iconName: "arrow.down.to.line",
            searchTerms: ["pull-on", "pull on", "elastic waist"],
            displayName: "Pull-On",
            badgeText: nil,
            isActive: true,
            sortOrder: 8,
            createdAt: Date(),
            updatedAt: Date()
        )
    ]

    // MARK: - Categories

    static let categories: [Category] = [
        Category(
            id: UUID(uuidString: "cccc1111-1111-1111-1111-111111111111")!,
            name: "Tops",
            slug: "tops",
            description: "Shirts, blouses, and tops with adaptive features",
            parentId: nil,
            categoryType: .tops,
            iconName: "tshirt",
            imageUrl: nil,
            sortOrder: 1,
            isActive: true,
            createdAt: Date(),
            updatedAt: Date()
        ),
        Category(
            id: UUID(uuidString: "cccc2222-2222-2222-2222-222222222222")!,
            name: "Bottoms",
            slug: "bottoms",
            description: "Pants, jeans, and shorts with adaptive features",
            parentId: nil,
            categoryType: .bottoms,
            iconName: "figure.stand",
            imageUrl: nil,
            sortOrder: 2,
            isActive: true,
            createdAt: Date(),
            updatedAt: Date()
        ),
        Category(
            id: UUID(uuidString: "cccc3333-3333-3333-3333-333333333333")!,
            name: "Footwear",
            slug: "footwear",
            description: "Easy-on shoes and adaptive footwear",
            parentId: nil,
            categoryType: .footwear,
            iconName: "shoe",
            imageUrl: nil,
            sortOrder: 3,
            isActive: true,
            createdAt: Date(),
            updatedAt: Date()
        ),
        Category(
            id: UUID(uuidString: "cccc4444-4444-4444-4444-444444444444")!,
            name: "Dresses",
            slug: "dresses",
            description: "Adaptive dresses and jumpsuits",
            parentId: nil,
            categoryType: .dresses,
            iconName: "figure.dress.line.vertical.figure",
            imageUrl: nil,
            sortOrder: 4,
            isActive: true,
            createdAt: Date(),
            updatedAt: Date()
        ),
        Category(
            id: UUID(uuidString: "cccc5555-5555-5555-5555-555555555555")!,
            name: "Underwear",
            slug: "underwear",
            description: "Adaptive underwear and intimates",
            parentId: nil,
            categoryType: .underwear,
            iconName: "heart",
            imageUrl: nil,
            sortOrder: 5,
            isActive: true,
            createdAt: Date(),
            updatedAt: Date()
        ),
        Category(
            id: UUID(uuidString: "cccc6666-6666-6666-6666-666666666666")!,
            name: "Kids",
            slug: "kids",
            description: "Adaptive clothing for children",
            parentId: nil,
            categoryType: .kidsTops,
            iconName: "person.2",
            imageUrl: nil,
            sortOrder: 6,
            isActive: true,
            createdAt: Date(),
            updatedAt: Date()
        )
    ]

    // MARK: - Products

    static let products: [Product] = [
        // Tommy Adaptive Products
        createProduct(
            id: "p0000001",
            brandId: "11111111-1111-1111-1111-111111111111",
            brandName: "Tommy Adaptive",
            categoryId: "cccc1111-1111-1111-1111-111111111111",
            name: "Magnetic Button Oxford Shirt",
            price: 69.50,
            originalPrice: nil,
            gender: .mens,
            closureType: .magnetic,
            imageUrl: "https://images.unsplash.com/photo-1596755094514-f87e34085b2c?w=400",
            featureIds: ["aaaa1111-1111-1111-1111-111111111111", "aaaa7777-7777-7777-7777-777777777777"],
            reviewCount: 47,
            rating: 4.6
        ),
        createProduct(
            id: "p0000002",
            brandId: "11111111-1111-1111-1111-111111111111",
            brandName: "Tommy Adaptive",
            categoryId: "cccc2222-2222-2222-2222-222222222222",
            name: "Seated Fit Jeans",
            price: 89.50,
            originalPrice: 119.00,
            gender: .mens,
            closureType: .magnetic,
            imageUrl: "https://images.unsplash.com/photo-1542272604-787c3835535d?w=400",
            featureIds: ["aaaa1111-1111-1111-1111-111111111111", "aaaa3333-3333-3333-3333-333333333333"],
            reviewCount: 82,
            rating: 4.8
        ),
        createProduct(
            id: "p0000003",
            brandId: "11111111-1111-1111-1111-111111111111",
            brandName: "Tommy Adaptive",
            categoryId: "cccc1111-1111-1111-1111-111111111111",
            name: "Magnetic Polo Shirt",
            price: 49.50,
            originalPrice: nil,
            gender: .womens,
            closureType: .magnetic,
            imageUrl: "https://images.unsplash.com/photo-1618354691373-d851c5c3a990?w=400",
            featureIds: ["aaaa1111-1111-1111-1111-111111111111"],
            reviewCount: 29,
            rating: 4.5
        ),

        // Nike FlyEase Products
        createProduct(
            id: "p0000004",
            brandId: "33333333-3333-3333-3333-333333333333",
            brandName: "Nike FlyEase",
            categoryId: "cccc3333-3333-3333-3333-333333333333",
            name: "Air Zoom Pegasus FlyEase",
            price: 130.00,
            originalPrice: nil,
            gender: .unisex,
            closureType: .none,
            imageUrl: "https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=400",
            featureIds: ["aaaa6666-6666-6666-6666-666666666666"],
            reviewCount: 156,
            rating: 4.7
        ),
        createProduct(
            id: "p0000005",
            brandId: "33333333-3333-3333-3333-333333333333",
            brandName: "Nike FlyEase",
            categoryId: "cccc3333-3333-3333-3333-333333333333",
            name: "Go FlyEase Hands-Free Shoe",
            price: 125.00,
            originalPrice: nil,
            gender: .unisex,
            closureType: .none,
            imageUrl: "https://images.unsplash.com/photo-1606107557195-0e29a4b5b4aa?w=400",
            featureIds: ["aaaa6666-6666-6666-6666-666666666666", "aaaa7777-7777-7777-7777-777777777777"],
            reviewCount: 203,
            rating: 4.9
        ),

        // Target Adaptive Products
        createProduct(
            id: "p0000006",
            brandId: "44444444-4444-4444-4444-444444444444",
            brandName: "Target Cat & Jack Adaptive",
            categoryId: "cccc6666-6666-6666-6666-666666666666",
            name: "Kids Sensory-Friendly T-Shirt",
            price: 12.00,
            originalPrice: nil,
            gender: .kidsUnisex,
            closureType: .none,
            imageUrl: "https://images.unsplash.com/photo-1519238263530-99bdd11df2ea?w=400",
            featureIds: ["aaaa4444-4444-4444-4444-444444444444"],
            reviewCount: 89,
            rating: 4.4
        ),
        createProduct(
            id: "p0000007",
            brandId: "44444444-4444-4444-4444-444444444444",
            brandName: "Target Cat & Jack Adaptive",
            categoryId: "cccc6666-6666-6666-6666-666666666666",
            name: "Kids Side-Opening Pants",
            price: 18.00,
            originalPrice: 24.00,
            gender: .kidsUnisex,
            closureType: .sideZip,
            imageUrl: "https://images.unsplash.com/photo-1503944583220-79d8926ad5e2?w=400",
            featureIds: ["aaaa5555-5555-5555-5555-555555555555", "aaaa4444-4444-4444-4444-444444444444"],
            reviewCount: 64,
            rating: 4.3
        ),

        // Slick Chicks Products
        createProduct(
            id: "p0000008",
            brandId: "66666666-6666-6666-6666-666666666666",
            brandName: "Slick Chicks",
            categoryId: "cccc5555-5555-5555-5555-555555555555",
            name: "Side-Opening Brief",
            price: 32.00,
            originalPrice: nil,
            gender: .womens,
            closureType: .velcro,
            imageUrl: "https://images.unsplash.com/photo-1617331721458-bd3bd3f9c7f8?w=400",
            featureIds: ["aaaa2222-2222-2222-2222-222222222222", "aaaa5555-5555-5555-5555-555555555555"],
            reviewCount: 112,
            rating: 4.6
        ),
        createProduct(
            id: "p0000009",
            brandId: "66666666-6666-6666-6666-666666666666",
            brandName: "Slick Chicks",
            categoryId: "cccc5555-5555-5555-5555-555555555555",
            name: "Adaptive Sports Bra",
            price: 48.00,
            originalPrice: nil,
            gender: .womens,
            closureType: .velcro,
            imageUrl: "https://images.unsplash.com/photo-1586736927469-0d7e5cbe2c62?w=400",
            featureIds: ["aaaa2222-2222-2222-2222-222222222222", "aaaa7777-7777-7777-7777-777777777777"],
            reviewCount: 78,
            rating: 4.5
        ),

        // IZ Adaptive Products
        createProduct(
            id: "p0000010",
            brandId: "55555555-5555-5555-5555-555555555555",
            brandName: "IZ Adaptive",
            categoryId: "cccc4444-4444-4444-4444-444444444444",
            name: "Seated Wrap Dress",
            price: 168.00,
            originalPrice: nil,
            gender: .womens,
            closureType: .magnetic,
            imageUrl: "https://images.unsplash.com/photo-1595777457583-95e059d581b8?w=400",
            featureIds: ["aaaa1111-1111-1111-1111-111111111111", "aaaa3333-3333-3333-3333-333333333333"],
            reviewCount: 34,
            rating: 4.8
        ),
        createProduct(
            id: "p0000011",
            brandId: "55555555-5555-5555-5555-555555555555",
            brandName: "IZ Adaptive",
            categoryId: "cccc1111-1111-1111-1111-111111111111",
            name: "Seated Fit Blazer",
            price: 245.00,
            originalPrice: 295.00,
            gender: .mens,
            closureType: .magnetic,
            imageUrl: "https://images.unsplash.com/photo-1507679799987-c73779587ccf?w=400",
            featureIds: ["aaaa1111-1111-1111-1111-111111111111", "aaaa3333-3333-3333-3333-333333333333"],
            reviewCount: 19,
            rating: 4.9
        ),

        // Zappos Adaptive Products
        createProduct(
            id: "p0000012",
            brandId: "22222222-2222-2222-2222-222222222222",
            brandName: "Zappos Adaptive",
            categoryId: "cccc3333-3333-3333-3333-333333333333",
            name: "Billy Footwear Classic High Top",
            price: 79.95,
            originalPrice: nil,
            gender: .unisex,
            closureType: .sideZip,
            imageUrl: "https://images.unsplash.com/photo-1525966222134-fcfa99b8ae77?w=400",
            featureIds: ["aaaa5555-5555-5555-5555-555555555555", "aaaa6666-6666-6666-6666-666666666666"],
            reviewCount: 241,
            rating: 4.7
        ),
        createProduct(
            id: "p0000013",
            brandId: "22222222-2222-2222-2222-222222222222",
            brandName: "Zappos Adaptive",
            categoryId: "cccc2222-2222-2222-2222-222222222222",
            name: "Pull-On Adaptive Joggers",
            price: 45.00,
            originalPrice: nil,
            gender: .unisex,
            closureType: .pullOn,
            imageUrl: "https://images.unsplash.com/photo-1552902865-b72c031ac5ea?w=400",
            featureIds: ["aaaa8888-8888-8888-8888-888888888888"],
            reviewCount: 67,
            rating: 4.4
        ),
        createProduct(
            id: "p0000014",
            brandId: "11111111-1111-1111-1111-111111111111",
            brandName: "Tommy Adaptive",
            categoryId: "cccc4444-4444-4444-4444-444444444444",
            name: "Velcro Wrap Skirt",
            price: 59.50,
            originalPrice: 79.50,
            gender: .womens,
            closureType: .velcro,
            imageUrl: "https://images.unsplash.com/photo-1583496661160-fb5886a0aaaa?w=400",
            featureIds: ["aaaa2222-2222-2222-2222-222222222222", "aaaa3333-3333-3333-3333-333333333333"],
            reviewCount: 38,
            rating: 4.5
        ),
        createProduct(
            id: "p0000015",
            brandId: "44444444-4444-4444-4444-444444444444",
            brandName: "Target Cat & Jack Adaptive",
            categoryId: "cccc6666-6666-6666-6666-666666666666",
            name: "Tagless Sensory Leggings",
            price: 15.00,
            originalPrice: nil,
            gender: .girls,
            closureType: .pullOn,
            imageUrl: "https://images.unsplash.com/photo-1506629082955-511b1aa562c8?w=400",
            featureIds: ["aaaa4444-4444-4444-4444-444444444444", "aaaa8888-8888-8888-8888-888888888888"],
            reviewCount: 124,
            rating: 4.6
        )
    ]

    // MARK: - Helper

    private static func createProduct(
        id: String,
        brandId: String,
        brandName: String,
        categoryId: String,
        name: String,
        price: Decimal,
        originalPrice: Decimal?,
        gender: GenderCategory,
        closureType: ClosureType?,
        imageUrl: String,
        featureIds: [String],
        reviewCount: Int,
        rating: Decimal
    ) -> Product {
        Product(
            id: UUID(),
            brandId: UUID(uuidString: brandId)!,
            categoryId: UUID(uuidString: categoryId)!,
            name: name,
            slug: name.lowercased().replacingOccurrences(of: " ", with: "-"),
            description: nil,
            price: price,
            originalPrice: originalPrice,
            currency: "USD",
            gender: gender,
            closureType: closureType,
            imageUrl: imageUrl,
            imageUrls: nil,
            productUrl: "https://example.com/product",
            affiliateUrl: nil,
            isAvailable: true,
            availableSizes: ["XS", "S", "M", "L", "XL"],
            safetyNotes: nil,
            pacemakerSafe: closureType == .magnetic ? false : nil,
            reviewCount: reviewCount,
            averageRating: rating,
            saveCount: Int.random(in: 10...200),
            createdAt: Date().addingTimeInterval(-Double.random(in: 0...2592000)),
            updatedAt: Date(),
            brandName: brandName
        )
    }
}
