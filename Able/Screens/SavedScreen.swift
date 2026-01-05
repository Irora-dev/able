import SwiftUI

struct SavedScreen: View {
    @EnvironmentObject private var appState: AppState
    @Environment(\.colorScheme) private var colorScheme
    @State private var savedItems: [SavedItem] = []
    @State private var isLoading = true

    var body: some View {
        NavigationStack {
            Group {
                if isLoading {
                    LoadingStateView(message: "Loading saved items...")
                } else if savedItems.isEmpty {
                    NoSavedItemsView {
                        appState.selectedTab = .browse
                    }
                } else {
                    savedItemsList
                }
            }
            .background(Color.ableBackground(for: colorScheme))
            .navigationTitle("Saved")
            .navigationBarTitleDisplayMode(.large)
            .refreshable {
                await loadSavedItems()
            }
        }
        .task {
            await loadSavedItems()
        }
    }

    private var savedItemsList: some View {
        ScrollView {
            LazyVStack(spacing: AbleSpacing.space3) {
                // Price drop alerts section
                let priceDropItems = savedItems.filter { $0.hasPriceDropped }
                if !priceDropItems.isEmpty {
                    VStack(alignment: .leading, spacing: AbleSpacing.space2) {
                        HStack {
                            Image(systemName: "tag.fill")
                                .foregroundColor(.ableError)
                            Text("Price Drops")
                                .font(AbleTypography.headline)
                        }
                        .ableScreenPadding()

                        ForEach(priceDropItems) { item in
                            if let product = item.product {
                                SavedItemRow(
                                    savedItem: item,
                                    product: product,
                                    onRemove: { removeSavedItem(item) }
                                )
                            }
                        }
                    }
                    .padding(.bottom, AbleSpacing.space4)
                }

                // All saved items
                VStack(alignment: .leading, spacing: AbleSpacing.space2) {
                    Text("All Saved (\(savedItems.count))")
                        .font(AbleTypography.headline)
                        .ableScreenPadding()

                    ForEach(savedItems) { item in
                        if let product = item.product {
                            SavedItemRow(
                                savedItem: item,
                                product: product,
                                onRemove: { removeSavedItem(item) }
                            )
                        }
                    }
                }
            }
            .padding(.vertical, AbleSpacing.space4)
        }
    }

    private func loadSavedItems() async {
        isLoading = true
        // TODO: Fetch from Supabase
        try? await Task.sleep(nanoseconds: 500_000_000)
        isLoading = false
    }

    private func removeSavedItem(_ item: SavedItem) {
        withAnimation {
            savedItems.removeAll { $0.id == item.id }
        }
        // TODO: Remove from Supabase
    }
}

// MARK: - Saved Item Row

struct SavedItemRow: View {
    let savedItem: SavedItem
    let product: Product
    var onRemove: (() -> Void)?

    @Environment(\.colorScheme) private var colorScheme
    @State private var showRemoveConfirmation = false

    var body: some View {
        HStack(spacing: AbleSpacing.space3) {
            // Product image
            AsyncImage(url: URL(string: product.imageUrl ?? "")) { phase in
                switch phase {
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                default:
                    Rectangle()
                        .fill(Color.ableCream)
                        .overlay(
                            Image(systemName: "photo")
                                .foregroundColor(Color.ableStone)
                        )
                }
            }
            .frame(width: 80, height: 80)
            .cornerRadius(AbleSpacing.tagCornerRadius)

            // Product info
            VStack(alignment: .leading, spacing: AbleSpacing.space1) {
                if let brand = product.brand {
                    Text(brand.name)
                        .font(AbleTypography.caption1)
                        .foregroundColor(Color.ableSecondaryText(for: colorScheme))
                }

                Text(product.name)
                    .font(AbleTypography.subheadline)
                    .foregroundColor(Color.ablePrimaryText(for: colorScheme))
                    .lineLimit(2)

                HStack(spacing: AbleSpacing.space1) {
                    Text(product.formattedPrice)
                        .font(AbleTypography.headline)
                        .foregroundColor(
                            savedItem.hasPriceDropped
                                ? Color.ableError
                                : Color.ablePrimaryText(for: colorScheme)
                        )

                    if savedItem.hasPriceDropped, let drop = savedItem.priceDrop {
                        Text("-$\(NSDecimalNumber(decimal: drop).doubleValue, specifier: "%.0f")")
                            .font(AbleTypography.caption1)
                            .foregroundColor(.white)
                            .padding(.horizontal, 6)
                            .padding(.vertical, 2)
                            .background(Color.ableError)
                            .cornerRadius(4)
                    }
                }
            }

            Spacer()

            // Remove button
            Button(action: { showRemoveConfirmation = true }) {
                Image(systemName: "heart.fill")
                    .font(.system(size: 22))
                    .foregroundColor(Color.ableError)
                    .frame(width: AbleSpacing.touchTarget, height: AbleSpacing.touchTarget)
            }
            .accessibilityLabel("Remove from saved")
        }
        .padding(AbleSpacing.space3)
        .background(Color.ableCardBackground(for: colorScheme))
        .cornerRadius(AbleSpacing.cardCornerRadius)
        .ableScreenPadding()
        .confirmationDialog(
            "Remove from saved?",
            isPresented: $showRemoveConfirmation,
            titleVisibility: .visible
        ) {
            Button("Remove", role: .destructive) {
                onRemove?()
            }
            Button("Cancel", role: .cancel) {}
        } message: {
            Text("This item will be removed from your saved list.")
        }
    }
}

// MARK: - Preview

#Preview {
    SavedScreen()
        .environmentObject(AppState())
}
