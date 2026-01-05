import SwiftUI

// MARK: - Able Typography System
// SF Pro with Dynamic Type support

enum AbleTypography {

    // MARK: - Font Styles

    /// Large Title - 34pt Bold
    static var largeTitle: Font { .largeTitle.bold() }

    /// Title 1 - 28pt Bold
    static var title1: Font { .title.bold() }

    /// Title 2 - 22pt Bold
    static var title2: Font { .title2.bold() }

    /// Title 3 - 20pt Semibold
    static var title3: Font { .title3.weight(.semibold) }

    /// Headline - 17pt Semibold
    static var headline: Font { .headline }

    /// Body - 17pt Regular
    static var body: Font { .body }

    /// Callout - 16pt Regular
    static var callout: Font { .callout }

    /// Subheadline - 15pt Regular
    static var subheadline: Font { .subheadline }

    /// Footnote - 13pt Regular
    static var footnote: Font { .footnote }

    /// Caption 1 - 12pt Regular
    static var caption1: Font { .caption }

    /// Caption 2 - 11pt Regular
    static var caption2: Font { .caption2 }
}

// MARK: - Text Style Modifiers

extension View {

    /// Apply primary text styling
    func ablePrimaryText() -> some View {
        self
            .font(AbleTypography.body)
            .foregroundStyle(Color.ableInk)
    }

    /// Apply secondary text styling
    func ableSecondaryText() -> some View {
        self
            .font(AbleTypography.callout)
            .foregroundStyle(Color.ableStone)
    }

    /// Apply headline styling
    func ableHeadline() -> some View {
        self
            .font(AbleTypography.headline)
            .foregroundStyle(Color.ableInk)
    }

    /// Apply caption styling
    func ableCaption() -> some View {
        self
            .font(AbleTypography.caption1)
            .foregroundStyle(Color.ableStone)
    }
}
