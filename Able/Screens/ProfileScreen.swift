import SwiftUI

struct ProfileScreen: View {
    @EnvironmentObject private var appState: AppState
    @Environment(\.colorScheme) private var colorScheme
    @State private var showSignOutConfirmation = false

    var body: some View {
        NavigationStack {
            List {
                // Account section
                Section {
                    if appState.isAuthenticated {
                        accountRow
                    } else {
                        signInRow
                    }
                }

                // Shopping mode
                Section("Shopping for") {
                    NavigationLink {
                        ShoppingModeView()
                    } label: {
                        HStack {
                            Image(systemName: "person.2")
                                .foregroundColor(Color.ableAccent(for: colorScheme))
                                .frame(width: 28)

                            Text(appState.currentUser?.currentMode.displayName ?? "Myself")

                            Spacer()

                            Text("Change")
                                .font(AbleTypography.caption1)
                                .foregroundColor(Color.ableOcean)
                        }
                    }
                }

                // Preferences
                Section("My Preferences") {
                    NavigationLink {
                        PreferencesView()
                    } label: {
                        Label("Adaptive Features", systemImage: "sparkles")
                    }

                    NavigationLink {
                        SizesView()
                    } label: {
                        Label("My Sizes", systemImage: "ruler")
                    }
                }

                // Notifications
                Section("Notifications") {
                    Toggle(isOn: .constant(true)) {
                        Label("Price Drop Alerts", systemImage: "tag")
                    }
                    .tint(Color.ableAccent(for: colorScheme))

                    Toggle(isOn: .constant(false)) {
                        Label("New Arrivals", systemImage: "bell")
                    }
                    .tint(Color.ableAccent(for: colorScheme))
                }

                // About
                Section("About") {
                    NavigationLink {
                        AboutView()
                    } label: {
                        Label("About Able", systemImage: "info.circle")
                    }

                    NavigationLink {
                        Text("Privacy Policy") // TODO: Implement
                    } label: {
                        Label("Privacy Policy", systemImage: "hand.raised")
                    }

                    NavigationLink {
                        Text("Terms of Service") // TODO: Implement
                    } label: {
                        Label("Terms of Service", systemImage: "doc.text")
                    }
                }

                // Sign out
                if appState.isAuthenticated {
                    Section {
                        Button(action: { showSignOutConfirmation = true }) {
                            HStack {
                                Spacer()
                                Text("Sign Out")
                                    .foregroundColor(.ableError)
                                Spacer()
                            }
                        }
                    }
                }

                // Affiliate disclosure
                Section {
                    Text("Able may earn a commission when you shop through our links.")
                        .font(AbleTypography.caption1)
                        .foregroundColor(Color.ableSecondaryText(for: colorScheme))
                }
            }
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.large)
            .confirmationDialog(
                "Sign out?",
                isPresented: $showSignOutConfirmation,
                titleVisibility: .visible
            ) {
                Button("Sign Out", role: .destructive) {
                    appState.signOut()
                }
                Button("Cancel", role: .cancel) {}
            } message: {
                Text("You can sign back in anytime.")
            }
        }
    }

    private var accountRow: some View {
        HStack(spacing: AbleSpacing.space3) {
            Circle()
                .fill(Color.ableBlush)
                .frame(width: 50, height: 50)
                .overlay(
                    Text(appState.currentUser?.displayName?.prefix(1).uppercased() ?? "A")
                        .font(AbleTypography.title2)
                        .foregroundColor(Color.ableInk)
                )

            VStack(alignment: .leading, spacing: 2) {
                Text(appState.currentUser?.displayName ?? "User")
                    .font(AbleTypography.headline)

                Text("View account")
                    .font(AbleTypography.caption1)
                    .foregroundColor(Color.ableOcean)
            }
        }
        .padding(.vertical, AbleSpacing.space1)
    }

    private var signInRow: some View {
        NavigationLink {
            Text("Sign In View") // TODO: Implement
        } label: {
            HStack(spacing: AbleSpacing.space3) {
                Circle()
                    .fill(Color.ableCream)
                    .frame(width: 50, height: 50)
                    .overlay(
                        Image(systemName: "person")
                            .foregroundColor(Color.ableStone)
                    )

                VStack(alignment: .leading, spacing: 2) {
                    Text("Sign in")
                        .font(AbleTypography.headline)

                    Text("Save items across devices")
                        .font(AbleTypography.caption1)
                        .foregroundColor(Color.ableSecondaryText(for: colorScheme))
                }
            }
            .padding(.vertical, AbleSpacing.space1)
        }
    }
}

// MARK: - Placeholder Views

struct ShoppingModeView: View {
    var body: some View {
        Text("Shopping Mode View")
            .navigationTitle("Shopping For")
    }
}

struct PreferencesView: View {
    var body: some View {
        Text("Preferences View")
            .navigationTitle("Adaptive Features")
    }
}

struct SizesView: View {
    var body: some View {
        Text("Sizes View")
            .navigationTitle("My Sizes")
    }
}

struct AboutView: View {
    @Environment(\.colorScheme) private var colorScheme

    var body: some View {
        ScrollView {
            VStack(spacing: AbleSpacing.space6) {
                // Logo placeholder
                Circle()
                    .fill(Color.ableBlush)
                    .frame(width: 80, height: 80)
                    .overlay(
                        Text("A")
                            .font(.system(size: 36, weight: .bold))
                            .foregroundColor(Color.ableInk)
                    )

                VStack(spacing: AbleSpacing.space2) {
                    Text("Able")
                        .font(AbleTypography.title1)

                    Text("Adaptive fashion, your style")
                        .font(AbleTypography.subheadline)
                        .foregroundColor(Color.ableSecondaryText(for: colorScheme))
                }

                Text("We help you discover adaptive clothing from brands across the web. Whether you're looking for magnetic closures, seated-fit jeans, easy-on shoes, or sensory-friendly fabrics, we connect you with fashion designed to fit bodies and lives as they actually are.")
                    .font(AbleTypography.body)
                    .foregroundColor(Color.ablePrimaryText(for: colorScheme))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)

                Text("Version 1.0")
                    .font(AbleTypography.caption1)
                    .foregroundColor(Color.ableStone)
            }
            .padding(.vertical, AbleSpacing.space8)
        }
        .navigationTitle("About")
        .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: - Preview

#Preview {
    ProfileScreen()
        .environmentObject(AppState())
}
