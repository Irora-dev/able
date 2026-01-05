import Foundation
import SwiftUI

// MARK: - Preference Service

@MainActor
final class PreferenceService: ObservableObject {
    static let shared = PreferenceService()

    @Published var userPreferences: UserPreferences {
        didSet { savePreferences() }
    }

    @Published var currentMode: UserMode = .individual {
        didSet { savePreferences() }
    }

    @Published private(set) var availableFeatures: [AdaptiveFeature] = []
    @Published private(set) var isLoading = false

    private let userDefaultsKey = "able_user_preferences"

    private init() {
        self.userPreferences = Self.loadPreferences()
        Task {
            await loadFeatures()
        }
    }

    // MARK: - Feature Management

    func loadFeatures() async {
        isLoading = true

        do {
            availableFeatures = try await SupabaseClient.shared.fetch(
                from: "adaptive_features",
                query: QueryBuilder()
                    .eq("is_active", "true")
                    .order("sort_order", ascending: true)
            )
        } catch {
            print("Error loading features: \(error)")
        }

        isLoading = false
    }

    func features(for category: FeatureCategory) -> [AdaptiveFeature] {
        availableFeatures.filter { $0.category == category }
    }

    // MARK: - Preference Updates

    func toggleFeature(_ featureId: String) {
        if userPreferences.selectedFeatureIds.contains(featureId) {
            userPreferences.selectedFeatureIds.remove(featureId)
        } else {
            userPreferences.selectedFeatureIds.insert(featureId)
        }
    }

    func setGenderPreference(_ gender: GenderCategory?) {
        userPreferences.preferredGender = gender
    }

    func setPriceTier(_ tier: PriceTier?) {
        userPreferences.preferredPriceTier = tier
    }

    func clearAllPreferences() {
        userPreferences = UserPreferences.default
    }

    // MARK: - Challenge to Feature Mapping

    func selectChallenge(_ challengeSlug: String) {
        userPreferences.selectedChallengeIds.insert(challengeSlug)

        // Auto-select related features based on challenge
        let relatedFeatures = mapChallengeToFeatures(challengeSlug)
        for featureId in relatedFeatures {
            userPreferences.selectedFeatureIds.insert(featureId)
        }
    }

    private func mapChallengeToFeatures(_ challengeSlug: String) -> [String] {
        // Maps user challenges to recommended features
        let mapping: [String: [String]] = [
            "limited-hand-mobility": [
                "aaaa1111-1111-1111-1111-111111111111", // Magnetic
                "aaaa2222-2222-2222-2222-222222222222", // Velcro
                "aaaa7777-7777-7777-7777-777777777777"  // One-hand friendly
            ],
            "wheelchair-user": [
                "aaaa3333-3333-3333-3333-333333333333", // Seated cut
                "aaaa5555-5555-5555-5555-555555555555"  // Side opening
            ],
            "sensory-sensitivities": [
                "aaaa4444-4444-4444-4444-444444444444"  // Sensory-friendly
            ],
            "one-hand-dressing": [
                "aaaa1111-1111-1111-1111-111111111111", // Magnetic
                "aaaa7777-7777-7777-7777-777777777777", // One-hand friendly
                "aaaa8888-8888-8888-8888-888888888888"  // Pull-on
            ],
            "arthritis": [
                "aaaa1111-1111-1111-1111-111111111111", // Magnetic
                "aaaa2222-2222-2222-2222-222222222222", // Velcro
                "aaaa8888-8888-8888-8888-888888888888"  // Pull-on
            ]
        ]

        return mapping[challengeSlug] ?? []
    }

    // MARK: - Persistence

    private func savePreferences() {
        let data = PreferencesData(
            preferredGender: userPreferences.preferredGender?.rawValue,
            preferredPriceTier: userPreferences.preferredPriceTier?.rawValue,
            selectedFeatureIds: Array(userPreferences.selectedFeatureIds),
            selectedChallengeIds: Array(userPreferences.selectedChallengeIds),
            currentMode: currentMode.rawValue
        )

        if let encoded = try? JSONEncoder().encode(data) {
            UserDefaults.standard.set(encoded, forKey: userDefaultsKey)
        }
    }

    private static func loadPreferences() -> UserPreferences {
        guard let data = UserDefaults.standard.data(forKey: "able_user_preferences"),
              let decoded = try? JSONDecoder().decode(PreferencesData.self, from: data) else {
            return UserPreferences.default
        }

        return UserPreferences(
            preferredGender: decoded.preferredGender.flatMap { GenderCategory(rawValue: $0) },
            preferredPriceTier: decoded.preferredPriceTier.flatMap { PriceTier(rawValue: $0) },
            selectedFeatureIds: Set(decoded.selectedFeatureIds),
            selectedChallengeIds: Set(decoded.selectedChallengeIds)
        )
    }
}

// MARK: - Persistence Model

private struct PreferencesData: Codable {
    let preferredGender: String?
    let preferredPriceTier: String?
    let selectedFeatureIds: [String]
    let selectedChallengeIds: [String]
    let currentMode: String
}

// MARK: - Feature Grouping

struct FeatureGroup: Identifiable {
    let id = UUID()
    let category: FeatureCategory
    let features: [AdaptiveFeature]

    var title: String { category.displayName }
}

extension PreferenceService {
    var groupedFeatures: [FeatureGroup] {
        let grouped = Dictionary(grouping: availableFeatures) { $0.category }

        return FeatureCategory.allCases
            .compactMap { category in
                guard let features = grouped[category], !features.isEmpty else { return nil }
                return FeatureGroup(category: category, features: features)
            }
            .sorted { $0.category.sortOrder < $1.category.sortOrder }
    }
}
