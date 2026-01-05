import SwiftUI

@main
struct AbleApp: App {
    @StateObject private var appState = AppState()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(appState)
                .preferredColorScheme(appState.colorSchemePreference)
        }
    }
}

// MARK: - App State

@MainActor
final class AppState: ObservableObject {
    @Published var isAuthenticated = false
    @Published var hasCompletedOnboarding = false
    @Published var currentUser: UserProfile?
    @Published var colorSchemePreference: ColorScheme?

    // MARK: - Navigation State

    @Published var selectedTab: Tab = .home
    @Published var showingOnboarding = false

    enum Tab: String, CaseIterable {
        case home
        case browse
        case saved
        case profile

        var title: String {
            switch self {
            case .home: return "Home"
            case .browse: return "Browse"
            case .saved: return "Saved"
            case .profile: return "Profile"
            }
        }

        var systemImage: String {
            switch self {
            case .home: return "house"
            case .browse: return "magnifyingglass"
            case .saved: return "heart"
            case .profile: return "person"
            }
        }

        var accessibilityLabel: String {
            "\(title) tab"
        }
    }

    // MARK: - Initialization

    init() {
        checkAuthenticationStatus()
        loadUserPreferences()
    }

    // MARK: - Methods

    func checkAuthenticationStatus() {
        // TODO: Implement Supabase auth check
        // For now, start in unauthenticated state
        isAuthenticated = false
    }

    func loadUserPreferences() {
        // Load from UserDefaults
        hasCompletedOnboarding = UserDefaults.standard.bool(forKey: "hasCompletedOnboarding")

        if let schemeString = UserDefaults.standard.string(forKey: "colorSchemePreference") {
            colorSchemePreference = schemeString == "dark" ? .dark : (schemeString == "light" ? .light : nil)
        }
    }

    func completeOnboarding() {
        hasCompletedOnboarding = true
        UserDefaults.standard.set(true, forKey: "hasCompletedOnboarding")
    }

    func signOut() {
        isAuthenticated = false
        currentUser = nil
        hasCompletedOnboarding = false
        UserDefaults.standard.set(false, forKey: "hasCompletedOnboarding")
    }
}
