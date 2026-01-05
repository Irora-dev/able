import SwiftUI

// MARK: - Able Color System
// Fashion-forward palette from VISUAL_STYLE_GUIDE.md

extension Color {

    // MARK: - Primary Colors

    /// Primary text, headers, logo - #1A1A2E
    static let ableInk = Color(red: 26/255, green: 26/255, blue: 46/255)

    /// Primary brand accent, warm backgrounds - #E8D5D5
    static let ableBlush = Color(red: 232/255, green: 213/255, blue: 213/255)

    /// Primary background - #FAF8F5
    static let ableWarmWhite = Color(red: 250/255, green: 248/255, blue: 245/255)

    // MARK: - Secondary Colors

    /// Secondary accent, icons, highlights - #A67C6D
    static let ableClay = Color(red: 166/255, green: 124/255, blue: 109/255)

    /// Secondary text, captions, metadata - #6B6B7B
    static let ableStone = Color(red: 107/255, green: 107/255, blue: 123/255)

    /// Success states, positive indicators - #8FA68F
    static let ableSage = Color(red: 143/255, green: 166/255, blue: 143/255)

    /// Card backgrounds, elevated surfaces - #F5F0E8
    static let ableCream = Color(red: 245/255, green: 240/255, blue: 232/255)

    // MARK: - Accent Colors

    /// Call-to-action, primary buttons - #C75B39
    static let ableTerracotta = Color(red: 199/255, green: 91/255, blue: 57/255)

    /// Pressed state for Terracotta - #B34E2E
    static let ableTerracottaPressed = Color(red: 179/255, green: 78/255, blue: 46/255)

    /// Tags, badges, subtle highlights - #D4A5A5
    static let ableDustyRose = Color(red: 212/255, green: 165/255, blue: 165/255)

    /// Links, interactive elements - #4A7C8C
    static let ableOcean = Color(red: 74/255, green: 124/255, blue: 140/255)

    // MARK: - Semantic Colors

    /// Success - #4A7C59
    static let ableSuccess = Color(red: 74/255, green: 124/255, blue: 89/255)

    /// Error - #B84A4A
    static let ableError = Color(red: 184/255, green: 74/255, blue: 74/255)

    /// Warning - #C4954A
    static let ableWarning = Color(red: 196/255, green: 149/255, blue: 74/255)

    /// Info (same as Ocean) - #4A7C8C
    static let ableInfo = Color(red: 74/255, green: 124/255, blue: 140/255)

    // MARK: - Dark Mode Colors

    /// Dark mode background - #0D0D1A
    static let ableDeepInk = Color(red: 13/255, green: 13/255, blue: 26/255)

    /// Dark mode elevated surfaces - #1A1A2E
    static let ableElevatedDark = Color(red: 26/255, green: 26/255, blue: 46/255)

    /// Dark mode primary text - #F5F3F0
    static let ableSoftWhite = Color(red: 245/255, green: 243/255, blue: 240/255)

    /// Dark mode secondary text - #9F9FAF
    static let ableMutedStone = Color(red: 159/255, green: 159/255, blue: 175/255)

    /// Dark mode blush accent - #3D2E2E
    static let ableDeepBlush = Color(red: 61/255, green: 46/255, blue: 46/255)

    /// Dark mode terracotta - #E06B45
    static let ableBrightTerracotta = Color(red: 224/255, green: 107/255, blue: 69/255)
}

// MARK: - Adaptive Color Helpers

extension Color {

    /// Background color for current color scheme
    static func ableBackground(for colorScheme: ColorScheme) -> Color {
        colorScheme == .dark ? .ableDeepInk : .ableWarmWhite
    }

    /// Card background for current color scheme
    static func ableCardBackground(for colorScheme: ColorScheme) -> Color {
        colorScheme == .dark ? .ableElevatedDark : .white
    }

    /// Primary text for current color scheme
    static func ablePrimaryText(for colorScheme: ColorScheme) -> Color {
        colorScheme == .dark ? .ableSoftWhite : .ableInk
    }

    /// Secondary text for current color scheme
    static func ableSecondaryText(for colorScheme: ColorScheme) -> Color {
        colorScheme == .dark ? .ableMutedStone : .ableStone
    }

    /// Accent color for current color scheme
    static func ableAccent(for colorScheme: ColorScheme) -> Color {
        colorScheme == .dark ? .ableBrightTerracotta : .ableTerracotta
    }
}
