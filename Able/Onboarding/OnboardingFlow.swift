import SwiftUI

struct OnboardingFlow: View {
    @EnvironmentObject private var appState: AppState
    @Environment(\.colorScheme) private var colorScheme
    @State private var currentStep = 0

    var body: some View {
        VStack(spacing: 0) {
            // Progress indicator
            ProgressView(value: Double(currentStep + 1), total: 4)
                .tint(Color.ableAccent(for: colorScheme))
                .padding(.horizontal, AbleSpacing.screenPadding)

            // Content
            TabView(selection: $currentStep) {
                WelcomeStep(onContinue: { currentStep = 1 })
                    .tag(0)

                ShoppingForStep(onContinue: { currentStep = 2 })
                    .tag(1)

                FeaturesStep(onContinue: { currentStep = 3 })
                    .tag(2)

                CompleteStep(onFinish: {
                    appState.completeOnboarding()
                })
                    .tag(3)
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .animation(.easeInOut, value: currentStep)
        }
        .background(Color.ableBackground(for: colorScheme))
    }
}

// MARK: - Welcome Step

struct WelcomeStep: View {
    var onContinue: () -> Void

    @Environment(\.colorScheme) private var colorScheme

    var body: some View {
        VStack(spacing: AbleSpacing.space6) {
            Spacer()

            // Logo placeholder
            Circle()
                .fill(Color.ableBlush)
                .frame(width: 100, height: 100)
                .overlay(
                    Text("A")
                        .font(.system(size: 48, weight: .bold))
                        .foregroundColor(Color.ableInk)
                )

            VStack(spacing: AbleSpacing.space3) {
                Text("Welcome to Able")
                    .font(AbleTypography.largeTitle)
                    .foregroundColor(Color.ablePrimaryText(for: colorScheme))

                Text("Fashion that works for you")
                    .font(AbleTypography.title3)
                    .foregroundColor(Color.ableSecondaryText(for: colorScheme))
            }

            Text("We help you discover adaptive clothing from brands across the web. Tell us a bit about what you're looking for, and we'll show you pieces that fit your needs.")
                .font(AbleTypography.body)
                .foregroundColor(Color.ableSecondaryText(for: colorScheme))
                .multilineTextAlignment(.center)
                .padding(.horizontal, AbleSpacing.space4)

            Spacer()

            PrimaryButton(title: "Let's get started", action: onContinue)
                .ableScreenPadding()
                .padding(.bottom, AbleSpacing.space8)
        }
    }
}

// MARK: - Shopping For Step

struct ShoppingForStep: View {
    var onContinue: () -> Void

    @Environment(\.colorScheme) private var colorScheme
    @State private var selectedMode: UserMode?

    var body: some View {
        VStack(spacing: AbleSpacing.space6) {
            Spacer()

            Text("Who are you shopping for?")
                .font(AbleTypography.title1)
                .foregroundColor(Color.ablePrimaryText(for: colorScheme))

            VStack(spacing: AbleSpacing.space3) {
                ModeOptionCard(
                    title: "Myself",
                    subtitle: "I'm looking for clothes that fit my needs",
                    icon: "person",
                    isSelected: selectedMode == .individual
                ) {
                    selectedMode = .individual
                }

                ModeOptionCard(
                    title: "Someone else",
                    subtitle: "I'm a caregiver, parent, or shopping for another person",
                    icon: "person.2",
                    isSelected: selectedMode == .caregiver
                ) {
                    selectedMode = .caregiver
                }
            }
            .padding(.horizontal, AbleSpacing.screenPadding)

            Spacer()

            VStack(spacing: AbleSpacing.space3) {
                PrimaryButton(title: "Continue", action: onContinue)
                    .disabled(selectedMode == nil)

                TextButton(title: "Skip for now", action: onContinue)
            }
            .ableScreenPadding()
            .padding(.bottom, AbleSpacing.space8)
        }
    }
}

// MARK: - Mode Option Card

struct ModeOptionCard: View {
    let title: String
    let subtitle: String
    let icon: String
    var isSelected: Bool = false
    var onTap: () -> Void

    @Environment(\.colorScheme) private var colorScheme

    var body: some View {
        Button(action: onTap) {
            HStack(spacing: AbleSpacing.space3) {
                Image(systemName: icon)
                    .font(.system(size: 24))
                    .foregroundColor(
                        isSelected
                            ? Color.ableAccent(for: colorScheme)
                            : Color.ableStone
                    )
                    .frame(width: 40)

                VStack(alignment: .leading, spacing: 2) {
                    Text(title)
                        .font(AbleTypography.headline)
                        .foregroundColor(Color.ablePrimaryText(for: colorScheme))

                    Text(subtitle)
                        .font(AbleTypography.caption1)
                        .foregroundColor(Color.ableSecondaryText(for: colorScheme))
                        .multilineTextAlignment(.leading)
                }

                Spacer()

                Image(systemName: isSelected ? "checkmark.circle.fill" : "circle")
                    .font(.system(size: 24))
                    .foregroundColor(
                        isSelected
                            ? Color.ableAccent(for: colorScheme)
                            : Color.ableStone
                    )
            }
            .padding(AbleSpacing.cardPadding)
            .background(Color.ableCardBackground(for: colorScheme))
            .cornerRadius(AbleSpacing.cardCornerRadius)
            .overlay(
                RoundedRectangle(cornerRadius: AbleSpacing.cardCornerRadius)
                    .stroke(
                        isSelected ? Color.ableAccent(for: colorScheme) : Color.clear,
                        lineWidth: 2
                    )
            )
        }
        .buttonStyle(PlainButtonStyle())
        .accessibilityLabel("\(title): \(subtitle)")
        .accessibilityAddTraits(isSelected ? .isSelected : [])
    }
}

// MARK: - Features Step

struct FeaturesStep: View {
    var onContinue: () -> Void

    @Environment(\.colorScheme) private var colorScheme
    @State private var selectedFeatures: Set<String> = []

    let featureGroups: [(String, [(String, String)])] = [
        ("Getting Dressed", [
            ("magnetic", "Magnetic closures"),
            ("velcro", "Velcro or hook-and-loop"),
            ("side-opening", "Side or back openings"),
            ("pull-on", "Pull-on styles (no fasteners)"),
            ("front-opening", "Front-opening designs"),
            ("easy-zipper", "Easy-grip zippers")
        ]),
        ("Fit & Comfort", [
            ("seated", "Seated/wheelchair cut"),
            ("extra-room", "Extra room in specific areas"),
            ("tagless", "Tagless and soft seams"),
            ("sensory", "Sensory-friendly fabrics"),
            ("adjustable", "Adjustable sizing")
        ])
    ]

    var body: some View {
        ScrollView {
            VStack(spacing: AbleSpacing.space6) {
                VStack(spacing: AbleSpacing.space2) {
                    Text("What features would help?")
                        .font(AbleTypography.title1)
                        .foregroundColor(Color.ablePrimaryText(for: colorScheme))

                    Text("Select all that apply. You can always change these later.")
                        .font(AbleTypography.subheadline)
                        .foregroundColor(Color.ableSecondaryText(for: colorScheme))
                        .multilineTextAlignment(.center)
                }
                .padding(.top, AbleSpacing.space6)

                ForEach(featureGroups, id: \.0) { group in
                    VStack(alignment: .leading, spacing: AbleSpacing.space3) {
                        Text(group.0)
                            .font(AbleTypography.headline)
                            .foregroundColor(Color.ablePrimaryText(for: colorScheme))

                        FlowLayout(spacing: AbleSpacing.space2) {
                            ForEach(group.1, id: \.0) { feature in
                                FeatureSelectionChip(
                                    title: feature.1,
                                    isSelected: selectedFeatures.contains(feature.0)
                                ) {
                                    if selectedFeatures.contains(feature.0) {
                                        selectedFeatures.remove(feature.0)
                                    } else {
                                        selectedFeatures.insert(feature.0)
                                    }
                                }
                            }
                        }
                    }
                }

                VStack(spacing: AbleSpacing.space3) {
                    PrimaryButton(title: "Continue", action: onContinue)

                    TextButton(title: "Skip for now", action: onContinue)
                }
                .padding(.top, AbleSpacing.space4)
                .padding(.bottom, AbleSpacing.space8)
            }
            .ableScreenPadding()
        }
    }
}

// MARK: - Feature Selection Chip

struct FeatureSelectionChip: View {
    let title: String
    var isSelected: Bool = false
    var onTap: () -> Void

    @Environment(\.colorScheme) private var colorScheme

    var body: some View {
        Button(action: onTap) {
            Text(title)
                .font(AbleTypography.subheadline)
                .foregroundColor(
                    isSelected
                        ? Color.ableAccent(for: colorScheme)
                        : Color.ablePrimaryText(for: colorScheme)
                )
                .padding(.horizontal, AbleSpacing.space3)
                .padding(.vertical, AbleSpacing.space2)
                .background(
                    isSelected
                        ? (colorScheme == .dark ? Color.ableDeepBlush : Color.ableBlush.opacity(0.5))
                        : Color.ableCardBackground(for: colorScheme)
                )
                .cornerRadius(20)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(
                            isSelected ? Color.ableAccent(for: colorScheme) : Color.ableStone.opacity(0.3),
                            lineWidth: isSelected ? 2 : 1
                        )
                )
        }
        .buttonStyle(PlainButtonStyle())
        .accessibilityLabel(title)
        .accessibilityAddTraits(isSelected ? .isSelected : [])
    }
}

// MARK: - Complete Step

struct CompleteStep: View {
    var onFinish: () -> Void

    @Environment(\.colorScheme) private var colorScheme

    var body: some View {
        VStack(spacing: AbleSpacing.space6) {
            Spacer()

            Image(systemName: "checkmark.circle.fill")
                .font(.system(size: 64))
                .foregroundColor(Color.ableSage)

            VStack(spacing: AbleSpacing.space3) {
                Text("You're all set")
                    .font(AbleTypography.largeTitle)
                    .foregroundColor(Color.ablePrimaryText(for: colorScheme))

                Text("Your profile is saved. Here's what happens next:")
                    .font(AbleTypography.subheadline)
                    .foregroundColor(Color.ableSecondaryText(for: colorScheme))
            }

            VStack(alignment: .leading, spacing: AbleSpacing.space3) {
                BulletPoint(text: "We'll show you items that match your preferences")
                BulletPoint(text: "Tap the heart to save pieces you like")
                BulletPoint(text: "Read reviews from people with similar needs")
                BulletPoint(text: "Shop directly from brand sites")
            }
            .padding(.horizontal, AbleSpacing.space4)

            Spacer()

            PrimaryButton(title: "Start exploring", action: onFinish)
                .ableScreenPadding()
                .padding(.bottom, AbleSpacing.space8)
        }
    }
}

// MARK: - Bullet Point

struct BulletPoint: View {
    let text: String

    @Environment(\.colorScheme) private var colorScheme

    var body: some View {
        HStack(alignment: .top, spacing: AbleSpacing.space3) {
            Image(systemName: "checkmark")
                .font(.system(size: 14, weight: .bold))
                .foregroundColor(Color.ableAccent(for: colorScheme))

            Text(text)
                .font(AbleTypography.body)
                .foregroundColor(Color.ablePrimaryText(for: colorScheme))
        }
    }
}

// MARK: - Preview

#Preview {
    OnboardingFlow()
        .environmentObject(AppState())
}
