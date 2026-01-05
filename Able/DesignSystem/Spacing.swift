import SwiftUI

// MARK: - Able Spacing System
// Base unit: 4pt

enum AbleSpacing {

    // MARK: - Spacing Scale

    /// 4pt - Minimal separation
    static let space1: CGFloat = 4

    /// 8pt - Tight spacing
    static let space2: CGFloat = 8

    /// 12pt - Standard internal padding
    static let space3: CGFloat = 12

    /// 16pt - Standard margins, card padding
    static let space4: CGFloat = 16

    /// 20pt - Section spacing
    static let space5: CGFloat = 20

    /// 24pt - Large section gaps
    static let space6: CGFloat = 24

    /// 32pt - Major section separation
    static let space8: CGFloat = 32

    /// 40pt - Hero spacing
    static let space10: CGFloat = 40

    /// 48pt - Screen-level spacing
    static let space12: CGFloat = 48

    // MARK: - Component Sizes

    /// Minimum touch target - 48pt
    static let touchTarget: CGFloat = 48

    /// Standard card padding - 16pt
    static let cardPadding: CGFloat = 16

    /// Screen horizontal padding - 16pt
    static let screenPadding: CGFloat = 16

    /// Button height - 50pt
    static let buttonHeight: CGFloat = 50

    /// Tab bar icon size - 24pt
    static let tabIconSize: CGFloat = 24

    /// Product card corner radius - 16pt
    static let cardCornerRadius: CGFloat = 16

    /// Button corner radius - 12pt
    static let buttonCornerRadius: CGFloat = 12

    /// Feature tag corner radius - 8pt
    static let tagCornerRadius: CGFloat = 8
}

// MARK: - Padding Helpers

extension View {

    /// Apply standard screen padding
    func ableScreenPadding() -> some View {
        self.padding(.horizontal, AbleSpacing.screenPadding)
    }

    /// Apply standard card padding
    func ableCardPadding() -> some View {
        self.padding(AbleSpacing.cardPadding)
    }

    /// Apply section spacing
    func ableSectionSpacing() -> some View {
        self.padding(.vertical, AbleSpacing.space6)
    }
}
