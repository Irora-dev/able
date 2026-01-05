import SwiftUI

struct ContentView: View {
    @EnvironmentObject private var appState: AppState

    var body: some View {
        Group {
            if !appState.hasCompletedOnboarding {
                OnboardingFlow()
            } else {
                MainTabView()
            }
        }
    }
}

// MARK: - Main Tab View

struct MainTabView: View {
    @EnvironmentObject private var appState: AppState
    @Environment(\.colorScheme) private var colorScheme

    var body: some View {
        TabView(selection: $appState.selectedTab) {
            HomeScreen()
                .tabItem {
                    Label(AppState.Tab.home.title, systemImage: AppState.Tab.home.systemImage)
                }
                .tag(AppState.Tab.home)
                .accessibilityLabel(AppState.Tab.home.accessibilityLabel)

            BrowseScreen()
                .tabItem {
                    Label(AppState.Tab.browse.title, systemImage: AppState.Tab.browse.systemImage)
                }
                .tag(AppState.Tab.browse)
                .accessibilityLabel(AppState.Tab.browse.accessibilityLabel)

            SavedScreen()
                .tabItem {
                    Label(AppState.Tab.saved.title, systemImage: AppState.Tab.saved.systemImage)
                }
                .tag(AppState.Tab.saved)
                .accessibilityLabel(AppState.Tab.saved.accessibilityLabel)

            ProfileScreen()
                .tabItem {
                    Label(AppState.Tab.profile.title, systemImage: AppState.Tab.profile.systemImage)
                }
                .tag(AppState.Tab.profile)
                .accessibilityLabel(AppState.Tab.profile.accessibilityLabel)
        }
        .tint(Color.ableAccent(for: colorScheme))
    }
}

// MARK: - Preview

#Preview {
    ContentView()
        .environmentObject(AppState())
}
