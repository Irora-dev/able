import SwiftUI

// MARK: - Search Bar

struct SearchBar: View {
    @Binding var text: String
    var placeholder: String = "Search"
    var onSubmit: (() -> Void)?

    @Environment(\.colorScheme) private var colorScheme
    @FocusState private var isFocused: Bool

    var body: some View {
        HStack(spacing: AbleSpacing.space2) {
            Image(systemName: "magnifyingglass")
                .foregroundColor(Color.ableStone)
                .font(.system(size: 16))

            TextField(placeholder, text: $text)
                .font(AbleTypography.body)
                .foregroundColor(Color.ablePrimaryText(for: colorScheme))
                .focused($isFocused)
                .submitLabel(.search)
                .onSubmit { onSubmit?() }
                .accessibilityLabel("Search field")

            if !text.isEmpty {
                Button(action: { text = "" }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(Color.ableStone)
                        .font(.system(size: 16))
                }
                .accessibilityLabel("Clear search")
            }
        }
        .padding(.horizontal, AbleSpacing.space3)
        .frame(height: AbleSpacing.touchTarget)
        .background(
            colorScheme == .dark
                ? Color.ableElevatedDark
                : Color.ableCream
        )
        .cornerRadius(AbleSpacing.buttonCornerRadius)
        .overlay(
            RoundedRectangle(cornerRadius: AbleSpacing.buttonCornerRadius)
                .stroke(
                    isFocused ? Color.ableAccent(for: colorScheme) : Color.clear,
                    lineWidth: 2
                )
        )
    }
}

// MARK: - Filter Chip

struct FilterChip: View {
    let title: String
    var isSelected: Bool = false
    var count: Int?
    var onTap: (() -> Void)?

    @Environment(\.colorScheme) private var colorScheme

    var body: some View {
        Button(action: { onTap?() }) {
            HStack(spacing: AbleSpacing.space1) {
                Text(title)
                    .font(AbleTypography.subheadline)

                if let count = count, count > 0 {
                    Text("\(count)")
                        .font(AbleTypography.caption2)
                        .foregroundColor(.white)
                        .padding(.horizontal, 6)
                        .padding(.vertical, 2)
                        .background(Color.ableAccent(for: colorScheme))
                        .clipShape(Capsule())
                }

                if isSelected {
                    Image(systemName: "xmark")
                        .font(.system(size: 10, weight: .bold))
                }
            }
            .foregroundColor(foregroundColor)
            .padding(.horizontal, AbleSpacing.space3)
            .padding(.vertical, AbleSpacing.space2)
            .background(backgroundColor)
            .cornerRadius(20)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(borderColor, lineWidth: 1)
            )
        }
        .buttonStyle(PlainButtonStyle())
        .accessibilityLabel("\(title)\(isSelected ? ", selected" : "")")
        .accessibilityAddTraits(isSelected ? .isSelected : [])
    }

    private var foregroundColor: Color {
        isSelected
            ? Color.ableAccent(for: colorScheme)
            : Color.ablePrimaryText(for: colorScheme)
    }

    private var backgroundColor: Color {
        isSelected
            ? (colorScheme == .dark ? Color.ableDeepBlush : Color.ableBlush.opacity(0.5))
            : Color.clear
    }

    private var borderColor: Color {
        isSelected
            ? Color.ableAccent(for: colorScheme)
            : Color.ableStone.opacity(0.3)
    }
}

// MARK: - Filter Bar

struct FilterBar: View {
    let filters: [FilterOption]
    var selectedFilters: Set<String> = []
    var onFilterTap: ((String) -> Void)?
    var onShowAllFilters: (() -> Void)?

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: AbleSpacing.space2) {
                // All Filters button
                Button(action: { onShowAllFilters?() }) {
                    HStack(spacing: AbleSpacing.space1) {
                        Image(systemName: "slider.horizontal.3")
                        Text("Filters")
                    }
                    .font(AbleTypography.subheadline)
                    .fontWeight(.medium)
                    .foregroundColor(.white)
                    .padding(.horizontal, AbleSpacing.space3)
                    .padding(.vertical, AbleSpacing.space2)
                    .background(Color.ableInk)
                    .cornerRadius(20)
                }
                .accessibilityLabel("Show all filters")

                // Individual filter chips
                ForEach(filters, id: \.id) { filter in
                    FilterChip(
                        title: filter.title,
                        isSelected: selectedFilters.contains(filter.id),
                        count: filter.count
                    ) {
                        onFilterTap?(filter.id)
                    }
                }
            }
            .padding(.horizontal, AbleSpacing.screenPadding)
        }
    }
}

struct FilterOption: Identifiable {
    let id: String
    let title: String
    var count: Int?
}

// MARK: - Preview

#Preview {
    VStack(spacing: AbleSpacing.space6) {
        VStack(alignment: .leading, spacing: AbleSpacing.space2) {
            Text("Search Bar")
                .font(AbleTypography.headline)

            SearchBar(text: .constant(""))
            SearchBar(text: .constant("magnetic shirts"))
        }
        .padding(.horizontal)

        VStack(alignment: .leading, spacing: AbleSpacing.space2) {
            Text("Filter Chips")
                .font(AbleTypography.headline)
                .padding(.horizontal)

            FilterBar(
                filters: [
                    FilterOption(id: "magnetic", title: "Magnetic", count: 24),
                    FilterOption(id: "seated", title: "Seated Cut", count: 12),
                    FilterOption(id: "velcro", title: "Velcro"),
                    FilterOption(id: "sensory", title: "Sensory-Friendly", count: 8)
                ],
                selectedFilters: ["magnetic"]
            )
        }
    }
    .background(Color.ableWarmWhite)
}
