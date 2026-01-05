import SwiftUI

struct HomeScreen: View {
    @EnvironmentObject private var appState: AppState
    @Environment(\.colorScheme) private var colorScheme

    @StateObject private var productService = ProductService.shared
    @StateObject private var preferenceService = PreferenceService.shared
    @StateObject private var categoryService = CategoryService.shared

    @State private var searchText = ""
    @State private var forYouProducts: [Product] = []

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: AbleSpacing.space6) {
                    // Search bar
                    SearchBar(text: $searchText, placeholder: "Search adaptive clothing")
                        .ableScreenPadding()

                    if productService.isLoading && productService.allProducts.isEmpty {
                        LoadingStateView(message: "Loading your feed...")
                            .frame(height: 300)
                    } else {
                        // For You section (personalized)
                        if !forYouProducts.isEmpty {
                            ProductSection(
                                title: "For You",
                                subtitle: "Based on your preferences",
                                products: forYouProducts
                            )
                        }

                        // Featured section
                        if !productService.featuredProducts.isEmpty {
                            ProductSection(
                                title: "Featured",
                                subtitle: "Top-rated adaptive clothing",
                                products: productService.featuredProducts
                            )
                        }

                        // New Arrivals section
                        if !productService.newArrivals.isEmpty {
                            ProductSection(
                                title: "New Arrivals",
                                subtitle: "Just added",
                                products: productService.newArrivals
                            )
                        }

                        // On Sale section
                        if !productService.onSale.isEmpty {
                            ProductSection(
                                title: "On Sale",
                                subtitle: "Price drops",
                                products: productService.onSale,
                                showSaleBadge: true
                            )
                        }

                        // Categories section
                        CategoriesSection(categories: categoryService.rootCategories)

                        // Shop by Brand section
                        BrandsSection()
                    }
                }
                .padding(.vertical, AbleSpacing.space4)
            }
            .background(Color.ableBackground(for: colorScheme))
            .navigationTitle("Home")
            .navigationBarTitleDisplayMode(.large)
            .refreshable {
                await loadData(forceRefresh: true)
            }
        }
        .task {
            await loadData()
        }
    }

    private func loadData(forceRefresh: Bool = false) async {
        async let productsTask: () = productService.fetchAllProducts(forceRefresh: forceRefresh)
        async let categoriesTask: () = categoryService.fetchAllCategories(forceRefresh: forceRefresh)

        _ = await (productsTask, categoriesTask)

        // Fetch personalized "For You" products
        forYouProducts = await productService.fetchProducts(
            matching: preferenceService.userPreferences,
            limit: 10
        )
    }
}

// MARK: - Product Section

struct ProductSection: View {
    let title: String
    var subtitle: String?
    let products: [Product]
    var showSaleBadge: Bool = false
    var seeAllAction: (() -> Void)?

    var body: some View {
        VStack(alignment: .leading, spacing: AbleSpacing.space3) {
            HStack {
                VStack(alignment: .leading, spacing: 2) {
                    Text(title)
                        .font(AbleTypography.title3)
                        .foregroundColor(.primary)

                    if let subtitle = subtitle {
                        Text(subtitle)
                            .font(AbleTypography.caption1)
                            .foregroundColor(.secondary)
                    }
                }

                Spacer()

                if seeAllAction != nil {
                    Button("See all") {
                        seeAllAction?()
                    }
                    .font(AbleTypography.subheadline)
                    .foregroundColor(.ableOcean)
                }
            }
            .ableScreenPadding()

            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: AbleSpacing.space3) {
                    ForEach(products) { product in
                        NavigationLink(value: product) {
                            ProductCard(product: product)
                                .frame(width: 160)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                .padding(.horizontal, AbleSpacing.screenPadding)
            }
        }
    }
}

// MARK: - Categories Section

struct CategoriesSection: View {
    let categories: [Category]
    @Environment(\.colorScheme) private var colorScheme

    var body: some View {
        VStack(alignment: .leading, spacing: AbleSpacing.space3) {
            Text("Categories")
                .font(AbleTypography.title3)
                .foregroundColor(.primary)
                .ableScreenPadding()

            LazyVGrid(
                columns: [
                    GridItem(.flexible()),
                    GridItem(.flexible()),
                    GridItem(.flexible())
                ],
                spacing: AbleSpacing.space3
            ) {
                ForEach(categories) { category in
                    NavigationLink(value: category) {
                        CategoryCard(category: category)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
            .ableScreenPadding()
        }
    }
}

// MARK: - Category Card

struct CategoryCard: View {
    let category: Category

    @Environment(\.colorScheme) private var colorScheme

    var body: some View {
        VStack(spacing: AbleSpacing.space2) {
            Image(systemName: category.systemIconName)
                .font(.system(size: 28))
                .foregroundColor(Color.ableAccent(for: colorScheme))
                .frame(width: 56, height: 56)
                .background(
                    colorScheme == .dark
                        ? Color.ableDeepBlush
                        : Color.ableBlush.opacity(0.5)
                )
                .clipShape(Circle())

            Text(category.name)
                .font(AbleTypography.caption1)
                .foregroundColor(Color.ablePrimaryText(for: colorScheme))
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, AbleSpacing.space3)
        .background(Color.ableCardBackground(for: colorScheme))
        .cornerRadius(AbleSpacing.cardCornerRadius)
        .accessibilityElement(children: .combine)
        .accessibilityLabel("\(category.name) category")
        .accessibilityAddTraits(.isButton)
    }
}

// MARK: - Brands Section

struct BrandsSection: View {
    @StateObject private var brandService = BrandService.shared
    @Environment(\.colorScheme) private var colorScheme

    var body: some View {
        VStack(alignment: .leading, spacing: AbleSpacing.space3) {
            Text("Shop by Brand")
                .font(AbleTypography.title3)
                .foregroundColor(.primary)
                .ableScreenPadding()

            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: AbleSpacing.space3) {
                    ForEach(brandService.allBrands) { brand in
                        NavigationLink(value: brand) {
                            BrandCard(brand: brand)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                .padding(.horizontal, AbleSpacing.screenPadding)
            }
        }
        .task {
            await brandService.fetchAllBrands()
        }
    }
}

// MARK: - Brand Card

struct BrandCard: View {
    let brand: Brand

    @Environment(\.colorScheme) private var colorScheme

    var body: some View {
        VStack(alignment: .leading, spacing: AbleSpacing.space2) {
            // Brand logo placeholder
            Circle()
                .fill(Color.ableCream)
                .frame(width: 60, height: 60)
                .overlay(
                    Text(brand.name.prefix(1))
                        .font(AbleTypography.title2)
                        .foregroundColor(Color.ableInk)
                )

            Text(brand.name)
                .font(AbleTypography.subheadline)
                .fontWeight(.medium)
                .foregroundColor(Color.ablePrimaryText(for: colorScheme))
                .lineLimit(1)

            Text(brand.priceTier.priceIndicator)
                .font(AbleTypography.caption1)
                .foregroundColor(Color.ableStone)

            if brand.isAdaptiveOnly {
                SimpleTag(text: "Adaptive Only", style: .accent)
            }
        }
        .frame(width: 120)
        .padding(AbleSpacing.space3)
        .background(Color.ableCardBackground(for: colorScheme))
        .cornerRadius(AbleSpacing.cardCornerRadius)
    }
}

// MARK: - Preview

#Preview {
    HomeScreen()
        .environmentObject(AppState())
}
