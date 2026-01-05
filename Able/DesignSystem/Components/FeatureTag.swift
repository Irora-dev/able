import SwiftUI

// MARK: - Feature Tag

struct FeatureTag: View {
    let feature: AdaptiveFeature
    var isSelected: Bool = false
    var onTap: (() -> Void)?

    @Environment(\.colorScheme) private var colorScheme

    var body: some View {
        Button(action: { onTap?() }) {
            HStack(spacing: AbleSpacing.space1) {
                Image(systemName: feature.systemIconName)
                    .font(.system(size: 14))

                Text(feature.displayName)
                    .font(AbleTypography.caption1)
            }
            .foregroundColor(foregroundColor)
            .padding(.horizontal, AbleSpacing.space3)
            .padding(.vertical, AbleSpacing.space2)
            .background(backgroundColor)
            .cornerRadius(AbleSpacing.tagCornerRadius)
            .overlay(
                RoundedRectangle(cornerRadius: AbleSpacing.tagCornerRadius)
                    .stroke(borderColor, lineWidth: isSelected ? 2 : 1)
            )
        }
        .buttonStyle(PlainButtonStyle())
        .accessibilityLabel(feature.displayName)
        .accessibilityAddTraits(isSelected ? .isSelected : [])
    }

    private var foregroundColor: Color {
        if isSelected {
            return Color.ableAccent(for: colorScheme)
        }
        return Color.ablePrimaryText(for: colorScheme)
    }

    private var backgroundColor: Color {
        if isSelected {
            return colorScheme == .dark
                ? Color.ableDeepBlush
                : Color.ableBlush.opacity(0.5)
        }
        return colorScheme == .dark
            ? Color.ableElevatedDark
            : Color.ableCream
    }

    private var borderColor: Color {
        if isSelected {
            return Color.ableAccent(for: colorScheme)
        }
        return Color.clear
    }
}

// MARK: - Simple Text Tag

struct SimpleTag: View {
    let text: String
    var style: TagStyle = .default

    @Environment(\.colorScheme) private var colorScheme

    var body: some View {
        Text(text)
            .font(AbleTypography.caption1)
            .foregroundColor(foregroundColor)
            .padding(.horizontal, AbleSpacing.space3)
            .padding(.vertical, AbleSpacing.space1)
            .background(backgroundColor)
            .cornerRadius(AbleSpacing.tagCornerRadius)
    }

    private var foregroundColor: Color {
        switch style {
        case .default:
            return Color.ablePrimaryText(for: colorScheme)
        case .accent:
            return Color.ableAccent(for: colorScheme)
        case .success:
            return Color.ableSuccess
        case .warning:
            return Color.ableWarning
        case .info:
            return Color.ableInfo
        }
    }

    private var backgroundColor: Color {
        switch style {
        case .default:
            return colorScheme == .dark ? Color.ableElevatedDark : Color.ableCream
        case .accent:
            return colorScheme == .dark ? Color.ableDeepBlush : Color.ableBlush.opacity(0.5)
        case .success:
            return Color.ableSage.opacity(0.3)
        case .warning:
            return Color.ableWarning.opacity(0.2)
        case .info:
            return Color.ableOcean.opacity(0.2)
        }
    }

    enum TagStyle {
        case `default`
        case accent
        case success
        case warning
        case info
    }
}

// MARK: - Badge Tag

struct BadgeTag: View {
    let text: String
    var color: Color = .ableDustyRose

    var body: some View {
        Text(text)
            .font(AbleTypography.caption2)
            .fontWeight(.semibold)
            .foregroundColor(.white)
            .padding(.horizontal, AbleSpacing.space2)
            .padding(.vertical, 2)
            .background(color)
            .cornerRadius(4)
    }
}

// MARK: - Feature Tag Grid

struct FeatureTagGrid: View {
    let features: [AdaptiveFeature]
    var selectedIds: Set<UUID> = []
    var onFeatureTap: ((AdaptiveFeature) -> Void)?

    var body: some View {
        FlowLayout(spacing: AbleSpacing.space2) {
            ForEach(features) { feature in
                FeatureTag(
                    feature: feature,
                    isSelected: selectedIds.contains(feature.id)
                ) {
                    onFeatureTap?(feature)
                }
            }
        }
    }
}

// MARK: - Flow Layout

struct FlowLayout: Layout {
    var spacing: CGFloat = 8

    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        let result = arrange(proposal: proposal, subviews: subviews)
        return result.size
    }

    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        let result = arrange(proposal: proposal, subviews: subviews)

        for (index, frame) in result.frames.enumerated() {
            subviews[index].place(
                at: CGPoint(x: bounds.minX + frame.minX, y: bounds.minY + frame.minY),
                proposal: ProposedViewSize(frame.size)
            )
        }
    }

    private func arrange(proposal: ProposedViewSize, subviews: Subviews) -> (size: CGSize, frames: [CGRect]) {
        let maxWidth = proposal.width ?? .infinity
        var frames: [CGRect] = []
        var x: CGFloat = 0
        var y: CGFloat = 0
        var rowHeight: CGFloat = 0

        for subview in subviews {
            let size = subview.sizeThatFits(.unspecified)

            if x + size.width > maxWidth && x > 0 {
                x = 0
                y += rowHeight + spacing
                rowHeight = 0
            }

            frames.append(CGRect(origin: CGPoint(x: x, y: y), size: size))
            rowHeight = max(rowHeight, size.height)
            x += size.width + spacing
        }

        let totalHeight = y + rowHeight
        return (CGSize(width: maxWidth, height: totalHeight), frames)
    }
}

// MARK: - Preview

#Preview {
    let sampleFeatures = [
        AdaptiveFeature(
            id: UUID(), name: "Magnetic Closures", slug: "magnetic",
            description: nil, category: .closure, iconName: "button.programmable",
            searchTerms: nil, displayName: "Magnetic Closures", badgeText: nil,
            isActive: true, sortOrder: 0, createdAt: Date(), updatedAt: Date()
        ),
        AdaptiveFeature(
            id: UUID(), name: "Seated Cut", slug: "seated",
            description: nil, category: .fit, iconName: "figure.roll",
            searchTerms: nil, displayName: "Seated Cut", badgeText: nil,
            isActive: true, sortOrder: 1, createdAt: Date(), updatedAt: Date()
        ),
        AdaptiveFeature(
            id: UUID(), name: "Sensory-Friendly", slug: "sensory",
            description: nil, category: .sensory, iconName: "hand.raised",
            searchTerms: nil, displayName: "Sensory-Friendly", badgeText: nil,
            isActive: true, sortOrder: 2, createdAt: Date(), updatedAt: Date()
        )
    ]

    VStack(alignment: .leading, spacing: AbleSpacing.space4) {
        Text("Feature Tags")
            .font(AbleTypography.headline)

        FeatureTagGrid(
            features: sampleFeatures,
            selectedIds: [sampleFeatures[0].id]
        )

        Divider()

        Text("Simple Tags")
            .font(AbleTypography.headline)

        HStack {
            SimpleTag(text: "Default")
            SimpleTag(text: "Accent", style: .accent)
            SimpleTag(text: "Success", style: .success)
        }

        Divider()

        Text("Badge Tags")
            .font(AbleTypography.headline)

        HStack {
            BadgeTag(text: "NEW")
            BadgeTag(text: "SALE", color: .ableError)
            BadgeTag(text: "TOP PICK", color: .ableOcean)
        }
    }
    .padding()
    .background(Color.ableWarmWhite)
}
