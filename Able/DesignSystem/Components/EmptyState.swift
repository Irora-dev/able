import SwiftUI

// MARK: - Empty State View

struct EmptyStateView: View {
    let title: String
    let message: String
    var systemImage: String = "tray"
    var buttonTitle: String?
    var buttonAction: (() -> Void)?

    @Environment(\.colorScheme) private var colorScheme

    var body: some View {
        VStack(spacing: AbleSpacing.space4) {
            Spacer()

            Image(systemName: systemImage)
                .font(.system(size: 48))
                .foregroundColor(Color.ableStone)

            VStack(spacing: AbleSpacing.space2) {
                Text(title)
                    .font(AbleTypography.title3)
                    .foregroundColor(Color.ablePrimaryText(for: colorScheme))
                    .multilineTextAlignment(.center)

                Text(message)
                    .font(AbleTypography.body)
                    .foregroundColor(Color.ableSecondaryText(for: colorScheme))
                    .multilineTextAlignment(.center)
            }
            .padding(.horizontal, AbleSpacing.space8)

            if let buttonTitle = buttonTitle, let action = buttonAction {
                PrimaryButton(title: buttonTitle, action: action)
                    .padding(.horizontal, AbleSpacing.space8)
                    .padding(.top, AbleSpacing.space2)
            }

            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

// MARK: - Error State View

struct ErrorStateView: View {
    let title: String
    let message: String
    var retryAction: (() -> Void)?

    @Environment(\.colorScheme) private var colorScheme

    var body: some View {
        VStack(spacing: AbleSpacing.space4) {
            Spacer()

            Image(systemName: "exclamationmark.triangle")
                .font(.system(size: 48))
                .foregroundColor(Color.ableWarning)

            VStack(spacing: AbleSpacing.space2) {
                Text(title)
                    .font(AbleTypography.title3)
                    .foregroundColor(Color.ablePrimaryText(for: colorScheme))
                    .multilineTextAlignment(.center)

                Text(message)
                    .font(AbleTypography.body)
                    .foregroundColor(Color.ableSecondaryText(for: colorScheme))
                    .multilineTextAlignment(.center)
            }
            .padding(.horizontal, AbleSpacing.space8)

            if let retryAction = retryAction {
                PrimaryButton(title: "Try again", action: retryAction)
                    .padding(.horizontal, AbleSpacing.space8)
                    .padding(.top, AbleSpacing.space2)
            }

            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

// MARK: - Loading State View

struct LoadingStateView: View {
    var message: String = "Loading..."

    @Environment(\.colorScheme) private var colorScheme

    var body: some View {
        VStack(spacing: AbleSpacing.space4) {
            Spacer()

            ProgressView()
                .scaleEffect(1.5)
                .tint(Color.ableAccent(for: colorScheme))

            Text(message)
                .font(AbleTypography.body)
                .foregroundColor(Color.ableSecondaryText(for: colorScheme))

            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

// MARK: - No Results View

struct NoResultsView: View {
    let query: String
    var onClearFilters: (() -> Void)?

    @Environment(\.colorScheme) private var colorScheme

    var body: some View {
        EmptyStateView(
            title: "No results for \"\(query)\"",
            message: "Try different keywords or check your spelling.",
            systemImage: "magnifyingglass",
            buttonTitle: "Clear filters",
            buttonAction: onClearFilters
        )
    }
}

// MARK: - No Saved Items View

struct NoSavedItemsView: View {
    var onBrowse: (() -> Void)?

    var body: some View {
        EmptyStateView(
            title: "Nothing saved yet",
            message: "When you find something you like, tap the heart to save it here.",
            systemImage: "heart",
            buttonTitle: "Start browsing",
            buttonAction: onBrowse
        )
    }
}

// MARK: - Network Error View

struct NetworkErrorView: View {
    var onRetry: (() -> Void)?

    var body: some View {
        ErrorStateView(
            title: "Can't connect",
            message: "Check your internet connection and try again.",
            retryAction: onRetry
        )
    }
}

// MARK: - Preview

#Preview {
    TabView {
        EmptyStateView(
            title: "Let's find your style",
            message: "Tell us what features matter to you, and we'll show you clothes that fit your needs.",
            systemImage: "sparkles",
            buttonTitle: "Set up profile"
        ) {}
            .tabItem { Label("Empty", systemImage: "tray") }

        NoSavedItemsView {}
            .tabItem { Label("Saved", systemImage: "heart") }

        NoResultsView(query: "purple jacket") {}
            .tabItem { Label("No Results", systemImage: "magnifyingglass") }

        NetworkErrorView {}
            .tabItem { Label("Error", systemImage: "exclamationmark.triangle") }

        LoadingStateView()
            .tabItem { Label("Loading", systemImage: "arrow.clockwise") }
    }
    .background(Color.ableWarmWhite)
}
