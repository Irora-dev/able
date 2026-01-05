import SwiftUI

struct HomeScreen: View {
    @EnvironmentObject private var appState: AppState
    @Environment(\.colorScheme) private var colorScheme
    @State private var searchText = ""
    @State private var featuredProducts: [Product] = []
    @State private var newArrivals: [Product] = []
    @State private var forYou: [Product] = []
    @State private var isLoading = true

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: AbleSpacing.space6) {
                    // Search bar
                    SearchBar(text: $searchText, placeholder: "Search adaptive clothing")
                        .ableScreenPadding()

                    if isLoading {
                        LoadingStateView(message: "Loading your feed...")
                            .frame(height: 300)
                    } else {
                        // For You section
                        if !forYou.isEmpty {
                            ProductSection(
                                title: "For You",
                                products: forYou
                            )
                        }

                        // Featured section
                        if !featuredProducts.isEmpty {
                            ProductSection(
                                title: "Featured",
                                products: featuredProducts
                            )
                        }

                        // New Arrivals section
                        if !newArrivals.isEmpty {
                            ProductSection(
                                title: "New Arrivals",
                                products: newArrivals
                            )
                        }

                        // Categories section
                        CategoriesSection()
                    }
                }
                .padding(.vertical, AbleSpacing.space4)
            }
            .background(Color.ableBackground(for: colorScheme))
            .navigationTitle("Home")
            .navigationBarTitleDisplayMode(.large)
            .refreshable {
                await loadData()
            }
        }
        .task {
            await loadData()
        }
    }

    private func loadData() async {
        isLoading = true
        // TODO: Fetch from Supabase
        // Simulating network delay
        try? await Task.sleep(nanoseconds: 500_000_000)
        isLoading = false
    }
}

// MARK: - Product Section

struct ProductSection: View {
    let title: String
    let products: [Product]
    var seeAllAction: (() -> Void)?

    var body: some View {
        VStack(alignment: .leading, spacing: AbleSpacing.space3) {
            HStack {
                Text(title)
                    .font(AbleTypography.title3)
                    .foregroundColor(.primary)

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
    @Environment(\.colorScheme) private var colorScheme

    let categories = [
        ("Tops", "tshirt", ProductCategory.tops),
        ("Bottoms", "figure.stand", ProductCategory.bottoms),
        ("Dresses", "figure.dress.line.vertical.figure", ProductCategory.dresses),
        ("Outerwear", "cloud.rain", ProductCategory.outerwear),
        ("Footwear", "shoe", ProductCategory.footwear),
        ("Kids", "person.2", ProductCategory.kidsTops)
    ]

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
                ForEach(categories, id: \.0) { category in
                    CategoryCard(
                        title: category.0,
                        iconName: category.1
                    )
                }
            }
            .ableScreenPadding()
        }
    }
}

// MARK: - Category Card

struct CategoryCard: View {
    let title: String
    let iconName: String

    @Environment(\.colorScheme) private var colorScheme

    var body: some View {
        VStack(spacing: AbleSpacing.space2) {
            Image(systemName: iconName)
                .font(.system(size: 28))
                .foregroundColor(Color.ableAccent(for: colorScheme))
                .frame(width: 56, height: 56)
                .background(
                    colorScheme == .dark
                        ? Color.ableDeepBlush
                        : Color.ableBlush.opacity(0.5)
                )
                .clipShape(Circle())

            Text(title)
                .font(AbleTypography.caption1)
                .foregroundColor(Color.ablePrimaryText(for: colorScheme))
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, AbleSpacing.space3)
        .background(Color.ableCardBackground(for: colorScheme))
        .cornerRadius(AbleSpacing.cardCornerRadius)
        .accessibilityElement(children: .combine)
        .accessibilityLabel("\(title) category")
        .accessibilityAddTraits(.isButton)
    }
}

// MARK: - Preview

#Preview {
    HomeScreen()
        .environmentObject(AppState())
}
