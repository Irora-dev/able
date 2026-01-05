import SwiftUI

struct BrowseScreen: View {
    @Environment(\.colorScheme) private var colorScheme

    @StateObject private var productService = ProductService.shared
    @StateObject private var preferenceService = PreferenceService.shared

    @State private var searchText = ""
    @State private var selectedFilters: Set<String> = []
    @State private var filteredProducts: [Product] = []
    @State private var isLoading = true
    @State private var showFilters = false
    @State private var selectedCategory: UUID?
    @State private var selectedPriceTier: PriceTier?

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // Search bar
                SearchBar(text: $searchText, placeholder: "Search adaptive clothing") {
                    Task { await performSearch() }
                }
                .padding(.horizontal, AbleSpacing.screenPadding)
                .padding(.vertical, AbleSpacing.space2)

                // Active filters display
                if !selectedFilters.isEmpty || selectedCategory != nil || selectedPriceTier != nil {
                    activeFiltersBar
                }

                // Feature filter chips
                featureFilterBar

                // Results
                if isLoading {
                    LoadingStateView(message: "Finding products...")
                } else if filteredProducts.isEmpty {
                    emptyState
                } else {
                    productGrid
                }
            }
            .background(Color.ableBackground(for: colorScheme))
            .navigationTitle("Browse")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { showFilters = true }) {
                        Image(systemName: "slider.horizontal.3")
                    }
                }
            }
            .sheet(isPresented: $showFilters) {
                AdvancedFilterSheet(
                    selectedFeatures: $selectedFilters,
                    selectedCategory: $selectedCategory,
                    selectedPriceTier: $selectedPriceTier,
                    onApply: {
                        showFilters = false
                        Task { await applyFilters() }
                    }
                )
            }
        }
        .task {
            await loadInitialData()
        }
        .onChange(of: searchText) { _, newValue in
            if newValue.isEmpty {
                Task { await applyFilters() }
            }
        }
    }

    // MARK: - Subviews

    private var activeFiltersBar: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: AbleSpacing.space2) {
                ForEach(Array(selectedFilters), id: \.self) { filterId in
                    if let feature = preferenceService.availableFeatures.first(where: { $0.id.uuidString == filterId }) {
                        FilterChip(title: feature.displayName, isSelected: true) {
                            selectedFilters.remove(filterId)
                            Task { await applyFilters() }
                        }
                    }
                }

                if selectedPriceTier != nil {
                    FilterChip(title: selectedPriceTier!.displayName, isSelected: true) {
                        selectedPriceTier = nil
                        Task { await applyFilters() }
                    }
                }

                Button("Clear all") {
                    selectedFilters.removeAll()
                    selectedCategory = nil
                    selectedPriceTier = nil
                    Task { await applyFilters() }
                }
                .font(AbleTypography.caption1)
                .foregroundColor(.ableOcean)
            }
            .padding(.horizontal, AbleSpacing.screenPadding)
            .padding(.vertical, AbleSpacing.space2)
        }
    }

    private var featureFilterBar: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: AbleSpacing.space2) {
                ForEach(preferenceService.availableFeatures.prefix(6)) { feature in
                    FilterChip(
                        title: feature.displayName,
                        isSelected: selectedFilters.contains(feature.id.uuidString)
                    ) {
                        toggleFilter(feature.id.uuidString)
                    }
                }

                Button(action: { showFilters = true }) {
                    HStack(spacing: 4) {
                        Image(systemName: "plus")
                        Text("More")
                    }
                    .font(AbleTypography.subheadline)
                    .foregroundColor(.ableOcean)
                    .padding(.horizontal, AbleSpacing.space3)
                    .padding(.vertical, AbleSpacing.space2)
                }
            }
            .padding(.horizontal, AbleSpacing.screenPadding)
            .padding(.vertical, AbleSpacing.space2)
        }
    }

    private var productGrid: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: AbleSpacing.space2) {
                Text("\(filteredProducts.count) results")
                    .font(AbleTypography.caption1)
                    .foregroundColor(.secondary)
                    .padding(.horizontal, AbleSpacing.screenPadding)

                LazyVGrid(
                    columns: [
                        GridItem(.flexible()),
                        GridItem(.flexible())
                    ],
                    spacing: AbleSpacing.space3
                ) {
                    ForEach(filteredProducts) { product in
                        NavigationLink(value: product) {
                            ProductCard(product: product)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                .padding(AbleSpacing.screenPadding)
            }
        }
    }

    @ViewBuilder
    private var emptyState: some View {
        if searchText.isEmpty && selectedFilters.isEmpty {
            EmptyStateView(
                title: "Browse our collection",
                message: "Use the search or filters above to find adaptive clothing.",
                systemImage: "magnifyingglass"
            )
        } else {
            NoResultsView(query: searchText.isEmpty ? "your filters" : searchText) {
                searchText = ""
                selectedFilters.removeAll()
                selectedCategory = nil
                selectedPriceTier = nil
                Task { await applyFilters() }
            }
        }
    }

    // MARK: - Data Loading

    private func loadInitialData() async {
        isLoading = true
        await preferenceService.loadFeatures()
        await productService.fetchAllProducts()

        // Start with preference-based results
        selectedFilters = preferenceService.userPreferences.selectedFeatureIds

        await applyFilters()
        isLoading = false
    }

    private func toggleFilter(_ filterId: String) {
        if selectedFilters.contains(filterId) {
            selectedFilters.remove(filterId)
        } else {
            selectedFilters.insert(filterId)
        }
        Task { await applyFilters() }
    }

    private func applyFilters() async {
        isLoading = true

        var preferences = preferenceService.userPreferences
        preferences.selectedFeatureIds = selectedFilters
        preferences.preferredPriceTier = selectedPriceTier

        filteredProducts = await productService.fetchProducts(
            matching: preferences,
            category: selectedCategory,
            searchQuery: searchText.isEmpty ? nil : searchText,
            limit: 100
        )

        isLoading = false
    }

    private func performSearch() async {
        guard !searchText.isEmpty else {
            await applyFilters()
            return
        }

        isLoading = true
        filteredProducts = await productService.search(query: searchText, limit: 100)
        isLoading = false
    }
}

// MARK: - Advanced Filter Sheet

struct AdvancedFilterSheet: View {
    @Binding var selectedFeatures: Set<String>
    @Binding var selectedCategory: UUID?
    @Binding var selectedPriceTier: PriceTier?
    var onApply: () -> Void

    @Environment(\.dismiss) private var dismiss
    @Environment(\.colorScheme) private var colorScheme

    @StateObject private var preferenceService = PreferenceService.shared
    @StateObject private var categoryService = CategoryService.shared

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: AbleSpacing.space6) {
                    // Categories
                    filterSection(title: "Category") {
                        FlowLayout(spacing: AbleSpacing.space2) {
                            ForEach(categoryService.rootCategories) { category in
                                FilterChip(
                                    title: category.name,
                                    isSelected: selectedCategory == category.id
                                ) {
                                    selectedCategory = selectedCategory == category.id ? nil : category.id
                                }
                            }
                        }
                    }

                    // Price Tier
                    filterSection(title: "Price Range") {
                        HStack(spacing: AbleSpacing.space2) {
                            ForEach(PriceTier.allCases, id: \.self) { tier in
                                FilterChip(
                                    title: "\(tier.displayName) \(tier.priceIndicator)",
                                    isSelected: selectedPriceTier == tier
                                ) {
                                    selectedPriceTier = selectedPriceTier == tier ? nil : tier
                                }
                            }
                        }
                    }

                    // Features by category
                    ForEach(preferenceService.groupedFeatures) { group in
                        filterSection(title: group.title) {
                            FlowLayout(spacing: AbleSpacing.space2) {
                                ForEach(group.features) { feature in
                                    FilterChip(
                                        title: feature.displayName,
                                        isSelected: selectedFeatures.contains(feature.id.uuidString)
                                    ) {
                                        toggleFeature(feature.id.uuidString)
                                    }
                                }
                            }
                        }
                    }
                }
                .padding(AbleSpacing.screenPadding)
            }
            .background(Color.ableBackground(for: colorScheme))
            .navigationTitle("Filters")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Reset") {
                        selectedFeatures.removeAll()
                        selectedCategory = nil
                        selectedPriceTier = nil
                    }
                    .foregroundColor(.ableOcean)
                }

                ToolbarItem(placement: .confirmationAction) {
                    Button("Apply") {
                        onApply()
                    }
                    .fontWeight(.semibold)
                    .foregroundColor(Color.ableAccent(for: colorScheme))
                }
            }
        }
        .task {
            await categoryService.fetchAllCategories()
        }
    }

    private func toggleFeature(_ featureId: String) {
        if selectedFeatures.contains(featureId) {
            selectedFeatures.remove(featureId)
        } else {
            selectedFeatures.insert(featureId)
        }
    }

    @ViewBuilder
    private func filterSection(title: String, @ViewBuilder content: () -> some View) -> some View {
        VStack(alignment: .leading, spacing: AbleSpacing.space3) {
            Text(title)
                .font(AbleTypography.headline)
                .foregroundColor(Color.ablePrimaryText(for: colorScheme))

            content()
        }
    }
}

// MARK: - Preview

#Preview {
    BrowseScreen()
        .environmentObject(AppState())
}
