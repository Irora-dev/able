import SwiftUI

// MARK: - Primary Button

struct PrimaryButton: View {
    let title: String
    let action: () -> Void
    var isLoading: Bool = false
    var isDisabled: Bool = false

    @Environment(\.colorScheme) private var colorScheme

    var body: some View {
        Button(action: action) {
            HStack(spacing: AbleSpacing.space2) {
                if isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        .scaleEffect(0.8)
                }
                Text(title)
                    .font(AbleTypography.headline)
                    .foregroundColor(.white)
            }
            .frame(maxWidth: .infinity)
            .frame(height: AbleSpacing.buttonHeight)
            .background(buttonBackground)
            .cornerRadius(AbleSpacing.buttonCornerRadius)
        }
        .disabled(isDisabled || isLoading)
        .accessibilityLabel(title)
        .accessibilityHint(isLoading ? "Loading" : "")
    }

    private var buttonBackground: Color {
        if isDisabled {
            return Color.ableStone.opacity(0.5)
        }
        return Color.ableAccent(for: colorScheme)
    }
}

// MARK: - Secondary Button

struct SecondaryButton: View {
    let title: String
    let action: () -> Void
    var isDisabled: Bool = false

    @Environment(\.colorScheme) private var colorScheme

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(AbleTypography.headline)
                .foregroundColor(Color.ableAccent(for: colorScheme))
                .frame(maxWidth: .infinity)
                .frame(height: AbleSpacing.buttonHeight)
                .background(Color.clear)
                .overlay(
                    RoundedRectangle(cornerRadius: AbleSpacing.buttonCornerRadius)
                        .stroke(Color.ableAccent(for: colorScheme), lineWidth: 2)
                )
        }
        .disabled(isDisabled)
        .opacity(isDisabled ? 0.5 : 1.0)
        .accessibilityLabel(title)
    }
}

// MARK: - Text Button

struct TextButton: View {
    let title: String
    let action: () -> Void

    @Environment(\.colorScheme) private var colorScheme

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(AbleTypography.callout)
                .foregroundColor(Color.ableOcean)
        }
        .frame(minHeight: AbleSpacing.touchTarget)
        .accessibilityLabel(title)
    }
}

// MARK: - Icon Button

struct IconButton: View {
    let systemName: String
    let action: () -> Void
    var accessibilityLabel: String
    var size: CGFloat = 24

    @Environment(\.colorScheme) private var colorScheme

    var body: some View {
        Button(action: action) {
            Image(systemName: systemName)
                .font(.system(size: size))
                .foregroundColor(Color.ablePrimaryText(for: colorScheme))
                .frame(width: AbleSpacing.touchTarget, height: AbleSpacing.touchTarget)
        }
        .accessibilityLabel(accessibilityLabel)
    }
}

// MARK: - Preview

#Preview {
    VStack(spacing: AbleSpacing.space4) {
        PrimaryButton(title: "Shop at Tommy Adaptive") {}
        PrimaryButton(title: "Loading...", action: {}, isLoading: true)
        PrimaryButton(title: "Disabled", action: {}, isDisabled: true)
        SecondaryButton(title: "Save for Later") {}
        TextButton(title: "Skip for now") {}
        HStack {
            IconButton(systemName: "heart", action: {}, accessibilityLabel: "Save")
            IconButton(systemName: "heart.fill", action: {}, accessibilityLabel: "Unsave")
            IconButton(systemName: "square.and.arrow.up", action: {}, accessibilityLabel: "Share")
        }
    }
    .padding()
}
