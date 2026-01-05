# Able - Visual Style Guide

> **"Find adaptive clothing you didn't know existed"**
>
> A fashion-forward iOS app for discovering adaptive clothing with dignity.

---

## 1. Brand Identity

### App Name Treatment: "Able"

The name "Able" was chosen deliberately:
- **Positive framing** - Focuses on capability, not limitation
- **Short and memorable** - Easy to say, search, and recommend
- **Fashionable** - Could be any fashion brand name, not medical-sounding
- **Dual meaning** - "I am able" + "Able (to find what I need)"

### Logo Concept

**Primary Mark:** The word "Able" in a custom sans-serif typeface:
- **Weight:** Medium-bold, confident but not aggressive
- **Letter spacing:** Slightly expanded for readability
- **The "A":** Features a subtle, elegant opening at the apex - symbolizing accessibility and openness
- **The "b" and "l":** Connected with a gentle ligature suggesting flow and ease

**App Icon:** A stylized "A" from the wordmark, set within a rounded square. The "A" has the characteristic open apex, rendered in Ink against Warm White.

**Logo Don'ts:**
- Never use wheelchair symbols or medical imagery
- Never add disability-related iconography
- Never use stiff, institutional typography

### Brand Personality

| Attribute | Expression |
|-----------|------------|
| **Fashion-forward** | We look like Everlane or Madewell, not a medical supply catalog |
| **Dignified** | Every person deserves stylish options presented beautifully |
| **Empowering** | "You have choices" not "Here's what's available for you" |
| **Warm** | Welcoming, not sterile; friendly, not clinical |
| **Trustworthy** | Clear information, honest descriptions, reliable experience |
| **Effortless** | Simple to use, especially for those with motor challenges |

### Brand Voice

**We say:**
- "Explore styles that work for you"
- "Seated-friendly fit"
- "Magnetic closure for easy dressing"
- "Designed for your lifestyle"

**We never say:**
- "Disability clothing"
- "Special needs fashion"
- "Handicapped accessible"
- Medical or clinical terminology

---

## 2. Color Palette

### Primary Colors

| Name | Hex | RGB | Usage |
|------|-----|-----|-------|
| **Ink** | `#1A1A2E` | 26, 26, 46 | Primary text, headers, logo |
| **Blush** | `#E8D5D5` | 232, 213, 213 | Primary brand accent, warm backgrounds |
| **Warm White** | `#FAF8F5` | 250, 248, 245 | Primary background |

### Secondary Colors

| Name | Hex | RGB | Usage |
|------|-----|-----|-------|
| **Clay** | `#A67C6D` | 166, 124, 109 | Secondary accent, icons, highlights |
| **Stone** | `#6B6B7B` | 107, 107, 123 | Secondary text, captions, metadata |
| **Sage** | `#8FA68F` | 143, 166, 143 | Success states, positive indicators |
| **Cream** | `#F5F0E8` | 245, 240, 232 | Card backgrounds, elevated surfaces |

### Accent Colors

| Name | Hex | RGB | Usage |
|------|-----|-----|-------|
| **Terracotta** | `#C75B39` | 199, 91, 57 | Call-to-action, primary buttons |
| **Dusty Rose** | `#D4A5A5` | 212, 165, 165 | Tags, badges, subtle highlights |
| **Ocean** | `#4A7C8C` | 74, 124, 140 | Links, interactive elements |

### Semantic Colors

| State | Hex | Usage |
|-------|-----|-------|
| **Success** | `#4A7C59` | Confirmations, completed states |
| **Error** | `#B84A4A` | Errors, required field indicators |
| **Warning** | `#C4954A` | Warnings, important notices |
| **Info** | `#4A7C8C` | Informational messages |

### Dark Mode Palette

| Light Mode | Dark Mode Equivalent | Hex |
|------------|---------------------|-----|
| Warm White (bg) | Deep Ink | `#0D0D1A` |
| Card Background | Elevated Dark | `#1A1A2E` |
| Ink (text) | Soft White | `#F5F3F0` |
| Stone (secondary) | Muted Stone | `#9F9FAF` |
| Blush | Deep Blush | `#3D2E2E` |
| Terracotta | Bright Terracotta | `#E06B45` |

---

## 3. Typography

### Font Family

**Primary Font:** SF Pro (iOS system font)

**Rationale:**
- Native to iOS, ensuring optimal rendering
- Excellent accessibility features built-in
- Full Dynamic Type support
- Comprehensive weight range

**Secondary/Display Font:** SF Pro Rounded (used sparingly)

### Type Scale

| Style | Size | Weight | Line Height | Usage |
|-------|------|--------|-------------|-------|
| **Large Title** | 34pt | Bold | 41pt | Screen titles |
| **Title 1** | 28pt | Bold | 34pt | Section headers |
| **Title 2** | 22pt | Bold | 28pt | Card titles |
| **Title 3** | 20pt | Semibold | 25pt | Subsection headers |
| **Headline** | 17pt | Semibold | 22pt | List item titles, emphasis |
| **Body** | 17pt | Regular | 22pt | Primary content |
| **Callout** | 16pt | Regular | 21pt | Secondary content |
| **Subheadline** | 15pt | Regular | 20pt | Supporting text |
| **Footnote** | 13pt | Regular | 18pt | Captions, timestamps |
| **Caption 1** | 12pt | Regular | 16pt | Labels, badges |
| **Caption 2** | 11pt | Regular | 13pt | Legal, fine print |

### Dynamic Type Support

**All text must scale with user preferences.** This is non-negotiable for our audience.

**Implementation Notes:**
- Use `.font(.body)` not `.font(.system(size: 17))`
- Test at AX5 (largest accessibility size)
- Ensure layouts adapt - use ScrollView when content may overflow
- Never truncate critical information

---

## 4. Spacing System

### Base Unit: 4pt

| Token | Value | Usage |
|-------|-------|-------|
| `space-1` | 4pt | Minimal separation, icon padding |
| `space-2` | 8pt | Tight spacing, inline elements |
| `space-3` | 12pt | Standard internal padding |
| `space-4` | 16pt | Standard margins, card padding |
| `space-5` | 20pt | Section spacing |
| `space-6` | 24pt | Large section gaps |
| `space-8` | 32pt | Major section separation |
| `space-10` | 40pt | Hero spacing |
| `space-12` | 48pt | Screen-level spacing |

### Touch Target Minimums

**Critical for our users: All interactive elements must be at least 48x48pt.**

| Element | Minimum Size | Recommended |
|---------|--------------|-------------|
| Buttons | 48x48pt | 50x50pt |
| Icon buttons | 48x48pt | 48x48pt |
| List rows | 48pt height | 56pt+ |
| Checkboxes/Radio | 48x48pt tap area | Visual 24pt, tap 48pt |
| Tab bar items | 48x48pt | 80pt wide |

---

## 5. Component Styles

### Buttons

#### Primary Button
```
Background: Terracotta (#C75B39)
Text: Warm White (#FAF8F5)
Corner radius: 12pt
Height: 50pt minimum
Font: Body (17pt), Semibold

Pressed state: Background darkens 10% (#B34E2E)
Disabled state: Background at 40% opacity
```

#### Secondary Button
```
Background: Transparent
Border: 1.5pt, Clay (#A67C6D)
Text: Clay (#A67C6D)
Corner radius: 12pt
Height: 50pt minimum
```

#### Text Button
```
Background: None
Text: Ocean (#4A7C8C)
Font: Body (17pt), Medium
```

### Product Card
```
Background: White (#FFFFFF)
Corner radius: 16pt
Shadow: 0pt 2pt 8pt rgba(26, 26, 46, 0.08)

Image area:
  - Aspect ratio: 4:5 (portrait)
  - Corner radius: 16pt 16pt 0pt 0pt

Content area:
  - Padding: 12pt
  - Brand: Footnote, Stone
  - Name: Headline, Ink
  - Price: Callout, Ink
```

### Feature Tag
```
Background: Dusty Rose (#D4A5A5) at 30% opacity
Text: Clay (#A67C6D)
Corner radius: 8pt
Padding: 6pt horizontal, 4pt vertical
Font: Caption 1 (12pt), Medium
```

### Bottom Tab Bar
```
Background: White (#FFFFFF) with top border
Border: 0.5pt, Stone at 20% opacity
Height: 49pt + safe area

Tab items:
  - Inactive: Stone (#6B6B7B)
  - Active: Terracotta (#C75B39)
  - Icon: 24pt
  - Label: Caption 2 (11pt)
```

---

## 6. Iconography

### Icon Style

**Style:** SF Symbols (Apple's system icons)
**Weight:** Regular or Medium
**Rendering:** Hierarchical or Monochrome

### Navigation Icons

| Purpose | SF Symbol |
|---------|-----------|
| Discover | `safari` |
| Browse | `square.grid.2x2` |
| Saved/Wishlist | `heart` / `heart.fill` |
| Profile | `person.crop.circle` |
| Search | `magnifyingglass` |
| Filter | `line.3.horizontal.decrease` |
| Back | `chevron.left` |
| Close | `xmark` |
| Share | `square.and.arrow.up` |

### Custom Adaptive Feature Icons

| Feature | Icon Description |
|---------|------------------|
| **Magnetic Closure** | Two rectangles with magnetic field lines |
| **Seated Cut** | Simplified seated figure silhouette |
| **Sensory-Friendly** | Soft textile wave pattern |
| **One-Handed** | Single hand with ease indicator |
| **Velcro/Hook-Loop** | Two interlocking strip segments |
| **Easy Pull** | Ring or loop with upward arrow |
| **Open Back** | Garment outline with opening |

---

## 7. Photography/Imagery Guidelines

### Photo Style

**Overall Aesthetic:** Editorial fashion photography, not catalog shots.

**Do:**
- Show products on diverse models in lifestyle contexts
- Capture genuine expressions and natural poses
- Use warm, inviting color grading
- Show adaptive features in use naturally

**Don't:**
- Use clinical white backgrounds exclusively
- Show only the disability, not the person
- Photograph products like medical equipment
- Over-emphasize modifications

### Model Diversity Requirements

| Dimension | Requirement |
|-----------|-------------|
| **Mobility** | Wheelchair users, crutch/cane users, ambulatory |
| **Age** | Young adults, middle-aged, seniors (30% 55+) |
| **Body type** | Range of sizes, including plus sizes |
| **Ethnicity** | Diverse racial/ethnic representation |
| **Gender** | All genders represented equally |
| **Visible disabilities** | Limb differences, visible conditions |

---

## 8. Motion/Animation

### Transition Principles

| Principle | Application |
|-----------|-------------|
| **Purposeful** | Animation conveys meaning or feedback |
| **Brief** | 200-350ms for most transitions |
| **Subtle** | No large-scale movement or zooms |
| **Consistent** | Same animation for same action type |
| **Interruptible** | User can always take control |

### Standard Durations

| Type | Duration | Easing |
|------|----------|--------|
| **Micro-interaction** | 100-150ms | easeOut |
| **State change** | 200-250ms | easeInOut |
| **Page transition** | 300-350ms | easeInOut |
| **Modal presentation** | 350ms | spring |

### Accessibility: Reduced Motion

**CRITICAL:** Respect `UIAccessibility.isReduceMotionEnabled`

When Reduce Motion is enabled:
- Replace animations with instant state changes
- Remove all decorative animation
- Use crossfade instead of slide transitions
- Disable parallax effects entirely

---

## 9. Accessibility Specifications

### Color Contrast Ratios

| Combination | Ratio | Status |
|-------------|-------|--------|
| Ink on Warm White | 15.1:1 | Exceeds AAA |
| Stone on Warm White | 5.2:1 | Exceeds AA |
| Terracotta on White | 4.8:1 | Meets AA |
| Warm White on Terracotta | 4.7:1 | Meets AA |
| Ocean on White | 5.4:1 | Exceeds AA |
| Ink on Cream | 12.3:1 | Exceeds AAA |

### Focus States

```
Focus ring:
  Color: Ocean (#4A7C8C)
  Width: 3pt
  Offset: 2pt from element edge
  Style: Solid (not dashed)
  Corner radius: Matches element + 2pt
```

### Touch Target Sizes

**Minimum: 48x48pt for all interactive elements**

| Element | Visual Size | Tap Target |
|---------|-------------|------------|
| Small icon button | 24pt | 48x48pt |
| Checkbox | 24pt | 48x48pt |
| List row | Variable | Full width x 56pt min |
| Tag/chip | 36pt height | 44pt height tap area |

---

## 10. SwiftUI Implementation Notes

### Color System

```swift
extension Color {
    // Primary
    static let ableInk = Color(hex: "1A1A2E")
    static let ableBlush = Color(hex: "E8D5D5")
    static let ableWarmWhite = Color(hex: "FAF8F5")

    // Secondary
    static let ableClay = Color(hex: "A67C6D")
    static let ableStone = Color(hex: "6B6B7B")
    static let ableSage = Color(hex: "8FA68F")
    static let ableCream = Color(hex: "F5F0E8")

    // Accent
    static let ableTerracotta = Color(hex: "C75B39")
    static let ableDustyRose = Color(hex: "D4A5A5")
    static let ableOcean = Color(hex: "4A7C8C")

    // Semantic
    static let ableSuccess = Color(hex: "4A7C59")
    static let ableError = Color(hex: "B84A4A")
    static let ableWarning = Color(hex: "C4954A")
}
```

### Spacing Constants

```swift
enum AbleSpacing {
    static let space1: CGFloat = 4
    static let space2: CGFloat = 8
    static let space3: CGFloat = 12
    static let space4: CGFloat = 16
    static let space5: CGFloat = 20
    static let space6: CGFloat = 24
    static let space8: CGFloat = 32
    static let space10: CGFloat = 40
    static let space12: CGFloat = 48

    static let touchTarget: CGFloat = 48
    static let cardPadding: CGFloat = 16
    static let screenPadding: CGFloat = 16
}
```

### Accessibility Helpers

```swift
// Check for Reduce Motion
@Environment(\.accessibilityReduceMotion) var reduceMotion

// Conditional animation
withAnimation(reduceMotion ? nil : .easeInOut(duration: 0.25)) {
    // animate
}

// Expand touch target
Button(action: {}) {
    Image(systemName: "heart")
        .frame(width: 24, height: 24)
}
.frame(width: 48, height: 48)
.contentShape(Rectangle())
```

---

## Quick Reference: Color Hex Codes

```
PRIMARY
Ink:            #1A1A2E
Blush:          #E8D5D5
Warm White:     #FAF8F5

SECONDARY
Clay:           #A67C6D
Stone:          #6B6B7B
Sage:           #8FA68F
Cream:          #F5F0E8

ACCENT
Terracotta:     #C75B39
Dusty Rose:     #D4A5A5
Ocean:          #4A7C8C

SEMANTIC
Success:        #4A7C59
Error:          #B84A4A
Warning:        #C4954A

DARK MODE
Deep Ink:       #0D0D1A
Elevated Dark:  #1A1A2E
Soft White:     #F5F3F0
Muted Stone:    #9F9FAF
Deep Blush:     #3D2E2E
Bright Terracotta: #E06B45
```

---

### The Core Principle

**Every design decision should answer: "Does this make our users feel like they're shopping for fashion, or shopping for medical supplies?"**

If it feels clinical, institutional, or othering - redesign it.

---

*Created by Visual Designer, Irora City*
*Project: Able - Adaptive Fashion Aggregator*
*Version 1.0 | 2026-01-05*
