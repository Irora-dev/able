import SwiftUI

struct BrowseScreen: View {
    @Environment(\.colorScheme) private var colorScheme
    @State private var searchText = ""
    @State private var selectedFilters: Set<String> = []
    @State private var products: [Product] = []
    @State private var isLoading = true
    @State private var showFilters = false

    private let filters: [FilterOption] = [
        FilterOption(id: "magnetic", title: "Magnetic", count: 24),
        FilterOption(id: "velcro", title: "Velcro", count: 18),
        FilterOption(id: "seated", title: "Seated Cut", count: 12),
        FilterOption(id: "sensory", title: "Sensory-Friendly", count: 15),
        FilterOption(id: "one-hand", title: "One-Hand", count: 8)
    ]

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // Search bar
                SearchBar(text: $searchText, placeholder: "Search adaptive clothing") {
                    Task { await searchProducts() }
                }
                .padding(.horizontal, AbleSpacing.screenPadding)
                .padding(.vertical, AbleSpacing.space2)

                // Filter bar
                FilterBar(
                    filters: filters,
                    selectedFilters: selectedFilters,
                    onFilterTap: { filterId in
                        if selectedFilters.contains(filterId) {
                            selectedFilters.remove(filterId)
                        } else {
                            selectedFilters.insert(filterId)
                        }
                        Task { await fetchProducts() }
                    },
                    onShowAllFilters: { showFilters = true }
                )
                .padding(.vertical, AbleSpacing.space2)

                // Results
                if isLoading {
                    LoadingStateView(message: "Finding products...")
                } else if products.isEmpty {
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
                            Task { await fetchProducts() }
                        }
                    }
                } else {
                    productGrid
                }
            }
            .background(Color.ableBackground(for: colorScheme))
            .navigationTitle("Browse")
            .navigationBarTitleDisplayMode(.large)
            .sheet(isPresented: $showFilters) {
                FilterSheet(
                    selectedFilters: $selectedFilters,
                    onApply: {
                        showFilters = false
                        Task { await fetchProducts() }
                    }
                )
            }
        }
        .task {
            await fetchProducts()
        }
    }

    private var productGrid: some View {
        ScrollView {
            LazyVGrid(
                columns: [
                    GridItem(.flexible()),
                    GridItem(.flexible())
                ],
                spacing: AbleSpacing.space3
            ) {
                ForEach(products) { product in
                    NavigationLink(value: product) {
                        ProductCard(product: product)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
            .padding(AbleSpacing.screenPadding)
        }
    }

    private func fetchProducts() async {
        isLoading = true
        // TODO: Fetch from Supabase with filters
        try? await Task.sleep(nanoseconds: 500_000_000)
        isLoading = false
    }

    private func searchProducts() async {
        guard !searchText.isEmpty else {
            await fetchProducts()
            return
        }
        isLoading = true
        // TODO: Search Supabase
        try? await Task.sleep(nanoseconds: 500_000_000)
        isLoading = false
    }
}

// MARK: - Filter Sheet

struct FilterSheet: View {
    @Binding var selectedFilters: Set<String>
    var onApply: () -> Void
    @Environment(\.dismiss) private var dismiss
    @Environment(\.colorScheme) private var colorScheme

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: AbleSpacing.space6) {
                    // Closure types
                    filterSection(
                        title: "Closures",
                        options: [
                            ("magnetic", "Magnetic closures"),
                            ("velcro", "Velcro closures"),
                            ("snap", "Snap closures"),
                            ("zipper", "Easy-grip zippers"),
                            ("pull-on", "Pull-on (no fasteners)")
                        ]
                    )

                    // Fit options
                    filterSection(
                        title: "Fit & Cut",
                        options: [
                            ("seated", "Seated/wheelchair cut"),
                            ("adjustable", "Adjustable fit"),
                            ("extra-room", "Extra room")
                        ]
                    )

                    // Sensory options
                    filterSection(
                        title: "Comfort",
                        options: [
                            ("sensory", "Sensory-friendly"),
                            ("tagless", "Tagless"),
                            ("flat-seams", "Flat seams"),
                            ("soft", "Soft fabrics")
                        ]
                    )

                    // Ease of dressing
                    filterSection(
                        title: "Ease of Dressing",
                        options: [
                            ("one-hand", "One-hand friendly"),
                            ("side-opening", "Side openings"),
                            ("back-opening", "Back openings"),
                            ("front-opening", "Front opening")
                        ]
                    )
                }
                .padding(AbleSpacing.screenPadding)
            }
            .background(Color.ableBackground(for: colorScheme))
            .navigationTitle("Filters")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Reset") {
                        selectedFilters.removeAll()
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
    }

    @ViewBuilder
    private func filterSection(title: String, options: [(String, String)]) -> some View {
        VStack(alignment: .leading, spacing: AbleSpacing.space3) {
            Text(title)
                .font(AbleTypography.headline)
                .foregroundColor(Color.ablePrimaryText(for: colorScheme))

            VStack(spacing: AbleSpacing.space2) {
                ForEach(options, id: \.0) { option in
                    filterRow(id: option.0, label: option.1)
                }
            }
        }
    }

    private func filterRow(id: String, label: String) -> some View {
        Button(action: {
            if selectedFilters.contains(id) {
                selectedFilters.remove(id)
            } else {
                selectedFilters.insert(id)
            }
        }) {
            HStack {
                Text(label)
                    .font(AbleTypography.body)
                    .foregroundColor(Color.ablePrimaryText(for: colorScheme))

                Spacer()

                Image(systemName: selectedFilters.contains(id) ? "checkmark.circle.fill" : "circle")
                    .foregroundColor(
                        selectedFilters.contains(id)
                            ? Color.ableAccent(for: colorScheme)
                            : Color.ableStone
                    )
                    .font(.system(size: 22))
            }
            .padding(.vertical, AbleSpacing.space2)
        }
        .accessibilityLabel(label)
        .accessibilityAddTraits(selectedFilters.contains(id) ? .isSelected : [])
    }
}

// MARK: - Preview

#Preview {
    BrowseScreen()
        .environmentObject(AppState())
}
