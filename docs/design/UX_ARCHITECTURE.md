# Able - UX Architecture Document
## Adaptive Fashion Aggregator (iOS)

**Version:** 1.0
**Author:** UX Architect, Irora City
**Project:** Able
**Date:** 2026-01-05

---

## Executive Summary

Able is an iOS app designed to help people with disabilities and their caregivers discover adaptive clothing across multiple brands. This document defines the complete user experience architecture including information architecture, user flows, screen inventory, wireframe descriptions, accessibility specifications, and interaction patterns.

**Core Design Philosophy:** Discovery over Search, Dignity over Medical, Accessibility as Foundation

---

## 1. Information Architecture

### 1.1 App Structure Overview

```
ABLE
├── Onboarding (First Launch Only)
│   ├── Welcome
│   ├── Mode Selection (Individual / Caregiver)
│   ├── Needs Assessment
│   ├── Preferences Setup
│   └── Complete
│
├── Main App (Tab-Based Navigation)
│   ├── Home (Discovery Feed)
│   ├── Browse (Category + Filter)
│   ├── Saved (Wishlist)
│   └── Profile (Settings + Preferences)
│
├── Product Experience
│   ├── Product Detail Page
│   ├── Reviews (Filtered by Need)
│   └── External Link (Affiliate)
│
└── Global Features
    ├── Search (Universal)
    ├── Mode Switch (Individual ↔ Caregiver)
    └── Accessibility Settings
```

### 1.2 Navigation Hierarchy

```
┌─────────────────────────────────────────────────────────────────┐
│                         TAB BAR                                  │
├─────────────┬─────────────┬─────────────┬─────────────┬────────┤
│   Home      │   Browse    │   Search    │   Saved     │Profile │
│   (Feed)    │ (Explore)   │  (Global)   │ (Wishlist)  │(You)   │
└─────────────┴─────────────┴─────────────┴─────────────┴────────┘
```

**Tab Behavior:**
- **Home:** Default landing, personalized discovery feed
- **Browse:** Category exploration with filtering
- **Search:** Quick access to search, opens search interface
- **Saved:** Cross-brand wishlist
- **Profile:** Settings, preferences, mode switching

### 1.3 Content Hierarchy

```
CONTENT ORGANIZATION

Categories (Top Level)
├── Tops
├── Bottoms
├── Dresses & Jumpsuits
├── Outerwear
├── Sleepwear
├── Underwear & Intimates
├── Footwear
├── Accessories
└── Kids

Adaptive Features (Cross-Cutting)
├── Closure Types
│   ├── Magnetic closures
│   ├── Velcro/Hook-and-loop
│   ├── Snap closures
│   ├── Side openings
│   ├── Back openings
│   └── Pull-on (no closures)
│
├── Fit & Cut
│   ├── Seated cut
│   ├── Wheelchair-friendly
│   ├── Extra room for medical devices
│   ├── Adjustable waistband
│   └── Anti-strip design
│
├── Sensory Considerations
│   ├── Tagless
│   ├── Flat seams
│   ├── Soft/sensory-friendly fabrics
│   └── Compression options
│
├── Ease of Dressing
│   ├── Front-dressing
│   ├── Open-back
│   ├── Wide neck openings
│   └── Easy grip pulls
│
└── Specialized Needs
    ├── AFO/brace compatible
    ├── Feeding tube access
    ├── Dialysis access
    └── Incontinence-friendly

Need-Based Challenges (User Language)
├── "Buttons are hard for me"
├── "I dress while seated"
├── "I need help dressing"
├── "Tags and seams bother me"
├── "I wear leg braces"
├── "I have limited arm movement"
├── "I use a feeding tube"
└── "My child fights getting dressed"
```

---

## 2. User Flows

### 2.1 Onboarding Flow

```
[App Launch - First Time]
         │
         ▼
┌─────────────────────┐
│   WELCOME SCREEN    │
│                     │
│ "Find adaptive      │
│  clothing you       │
│  didn't know        │
│  existed"           │
│                     │
│ [Get Started]       │
└─────────────────────┘
         │
         ▼
┌─────────────────────┐
│   MODE SELECTION    │
│                     │
│ "Are you shopping   │
│  for yourself or    │
│  someone else?"     │
│                     │
│ ┌─────────────────┐ │
│ │   For Myself    │ │
│ └─────────────────┘ │
│ ┌─────────────────┐ │
│ │ For Someone     │ │
│ │ I Care For      │ │
│ └─────────────────┘ │
└─────────────────────┘
         │
    ┌────┴────┐
    │         │
    ▼         ▼
[Individual] [Caregiver]
    │         │
    ▼         ▼
┌─────────────────────┐
│ NEEDS ASSESSMENT    │
│                     │
│ "What challenges    │
│  do you/they face   │
│  when dressing?"    │
│                     │
│ [Multi-select list] │
│ □ Buttons/zippers   │
│   are difficult     │
│ □ Dress while       │
│   seated            │
│ □ Sensitive to      │
│   certain textures  │
│ □ Limited arm/hand  │
│   movement          │
│ □ Wear braces/AFOs  │
│ □ Other (specify)   │
│                     │
│ [Skip] [Continue]   │
└─────────────────────┘
         │
         ▼
┌─────────────────────┐
│  PREFERENCES        │
│                     │
│ Size (optional)     │
│ Style preference    │
│ Price preference    │
│                     │
│ [Skip] [Complete]   │
└─────────────────────┘
         │
         ▼
┌─────────────────────┐
│  SETUP COMPLETE     │
│                     │
│ "You're all set!"   │
│                     │
│ [Start Exploring]   │
└─────────────────────┘
         │
         ▼
    [HOME FEED]
```

### 2.2 Discovery Flow (Primary Use Case)

```
[Launch App]
     │
     ▼
┌─────────────────────┐
│    HOME FEED        │
│                     │
│ ┌─────────────────┐ │
│ │ For You         │ │  ← Personalized based on profile
│ │ (Horizontal     │ │
│ │  scroll)        │ │
│ └─────────────────┘ │
│                     │
│ ┌─────────────────┐ │
│ │ New Arrivals    │ │
│ │ (Grid)          │ │
│ └─────────────────┘ │
│                     │
│ ┌─────────────────┐ │
│ │ Popular in      │ │
│ │ [Your Category] │ │
│ └─────────────────┘ │
└─────────────────────┘
     │
     │ [Tap Product Card]
     ▼
┌─────────────────────┐
│  PRODUCT DETAIL     │
│                     │
│ [Hero Image]        │
│ Brand Name          │
│ Product Title       │
│ $Price              │
│                     │
│ ★ Adaptive Features │
│ • Magnetic buttons  │
│ • Seated cut        │
│                     │
│ [Save] [Buy Now →]  │
│                     │
│ ───────────────     │
│ Details             │
│ Reviews (by need)   │
│ Similar Items       │
└─────────────────────┘
     │
     │ [Tap "Buy Now"]
     ▼
┌─────────────────────┐
│  LEAVING APP        │
│  CONFIRMATION       │
│                     │
│ "You're heading to  │
│  [Brand]'s website  │
│  to complete your   │
│  purchase."         │
│                     │
│ [Cancel] [Continue] │
└─────────────────────┘
     │
     ▼
[External Browser - Affiliate Link]
```

### 2.3 Browse & Filter Flow

```
[Tap Browse Tab]
     │
     ▼
┌─────────────────────┐
│    BROWSE SCREEN    │
│                     │
│ ┌─────────────────┐ │
│ │ Category Pills  │ │
│ │ [Tops][Bottoms] │ │
│ │ [Dresses]...    │ │
│ └─────────────────┘ │
│                     │
│ ┌─────────────────┐ │
│ │ [Filter Button] │ │
│ │ [Sort Dropdown] │ │
│ └─────────────────┘ │
│                     │
│ ┌─────────────────┐ │
│ │ Product Grid    │ │
│ └─────────────────┘ │
└─────────────────────┘
     │
     │ [Tap Filter]
     ▼
┌─────────────────────┐
│  FILTER SHEET       │
│  (Bottom Sheet)     │
│                     │
│ ┌─────────────────┐ │
│ │ Your Needs      │ │  ← Pre-populated from profile
│ │ ☑ Magnetic      │ │
│ │ ☑ Seated cut    │ │
│ │ + Add need      │ │
│ └─────────────────┘ │
│                     │
│ ┌─────────────────┐ │
│ │ Challenges      │ │
│ │ Features        │ │
│ │ Brand           │ │
│ │ Price           │ │
│ │ Size            │ │
│ └─────────────────┘ │
│                     │
│ [Clear] [Apply(N)]  │
└─────────────────────┘
     │
     │ [Apply Filters]
     ▼
[Filtered Results with Active Filter Pills]
```

---

## 3. Screen Inventory

### 3.1 Complete Screen List

| # | Screen Name | Purpose | Entry Points |
|---|-------------|---------|--------------|
| **Onboarding** ||||
| 1 | Welcome | First impression, value prop | App launch (first time) |
| 2 | Mode Selection | Individual vs Caregiver | Welcome screen |
| 3 | Needs Assessment | Capture dressing challenges | Mode selection |
| 4 | Preferences Setup | Size, style, price | Needs assessment |
| 5 | Setup Complete | Confirmation, transition | Preferences setup |
| **Main Navigation** ||||
| 6 | Home Feed | Personalized discovery | Tab bar, app launch |
| 7 | Browse | Category exploration | Tab bar |
| 8 | Search | Product search | Tab bar, global |
| 9 | Search Results | Search output | Search submission |
| 10 | Saved Items | Wishlist management | Tab bar |
| 11 | Profile | Settings & preferences | Tab bar |
| **Product Experience** ||||
| 12 | Product Detail | Full product info | Any product card tap |
| 13 | Image Gallery | Full-screen images | Product detail image tap |
| 14 | Reviews List | All reviews filtered | Product detail reviews |
| 15 | Write Review | User review submission | Reviews list |
| **Utility Screens** ||||
| 16 | Filter Sheet | Filter controls | Browse, search results |
| 17 | Sort Sheet | Sort options | Browse, search results |
| 18 | External Link Modal | Affiliate disclosure | Buy button tap |
| 19 | Mode Switch Sheet | Change user mode | Profile |
| 20 | Create Collection | New wishlist folder | Save long-press |
| **Profile Sub-screens** ||||
| 21 | Edit Profile | Modify preferences | Profile |
| 22 | Edit Needs | Update challenges | Profile |
| 23 | Accessibility Settings | App accessibility | Profile |
| 24 | Care Recipients | Manage people | Profile (caregiver) |
| 25 | About/Help | App info, support | Profile |

---

## 4. Accessibility Specifications

### 4.1 Touch Target Sizes

| Element | Minimum Size | Recommended | Notes |
|---------|--------------|-------------|-------|
| Buttons (Primary CTA) | 44pt x 44pt | 56pt height | Full width preferred |
| Icon buttons | 44pt x 44pt | 48pt x 48pt | Include padding in target |
| List rows | 44pt height | 56pt height | Full width tap target |
| Chips/Pills | 44pt height | 48pt height | Text + padding |
| Tab bar items | 44pt x 44pt | iOS default | Standard spacing |
| Checkboxes | 44pt x 44pt | 48pt x 48pt | Include label in target |
| Close/Dismiss | 44pt x 44pt | 48pt x 48pt | Positioned for easy reach |

**Implementation Notes:**
- All interactive elements must meet minimum 44pt in both dimensions
- Spacing between targets: minimum 8pt
- For small visual elements (icons), extend the hit area with transparent padding

### 4.2 VoiceOver Label Guidelines

#### Naming Conventions

```
ELEMENT TYPE          LABEL FORMAT                    EXAMPLE
─────────────────────────────────────────────────────────────────
Buttons               [Action]                        "Save"
                      [Action], button                "Save, button"

Toggle buttons        [State]. [Action]               "Saved. Remove from saved"
                                                      "Not saved. Add to saved"

Images (functional)   [Description of function]       "Product image 1 of 5"

Images (decorative)   accessibilityHidden = true      (Not announced)

Product cards         [Brand]. [Title]. [Price].      "Tommy Adaptive.
                      [Save state]. Double tap        Seated polo. $49.
                      to view                         Not saved. Double tap
                                                      to view"

Filters (active)      [Filter name], active filter.   "Magnetic closures,
                      Remove                          active filter. Remove"

Sections              [Section name], heading         "For You, heading"

Links                 [Text], link                    "See all, link"
```

### 4.3 Dynamic Type Support

| Text Style | Usage | Min Size | Max Size |
|------------|-------|----------|----------|
| Large Title | Screen titles | 34pt | 53pt |
| Title 1 | Section headers | 28pt | 44pt |
| Title 2 | Product titles (detail) | 22pt | 34pt |
| Title 3 | Card titles | 20pt | 31pt |
| Headline | Emphasized text | 17pt | 27pt |
| Body | General content | 17pt | 27pt |
| Callout | Secondary info | 16pt | 25pt |
| Subhead | Captions, metadata | 15pt | 24pt |
| Footnote | Legal, timestamps | 13pt | 21pt |
| Caption 1 | Labels, hints | 12pt | 19pt |
| Caption 2 | Smallest text | 11pt | 17pt |

**Layout Adaptations:**
- At largest sizes, product grids switch from 2-column to 1-column
- Card layouts stack vertically instead of side-by-side
- Truncation with "..." and "Read more" for long text
- Images maintain fixed size, text area expands

### 4.4 Color Contrast Requirements

| Element | Foreground | Background | Ratio | WCAG |
|---------|------------|------------|-------|------|
| Primary text | #000000 | #FFFFFF | 21:1 | AAA |
| Secondary text | #666666 | #FFFFFF | 5.7:1 | AA |
| Primary button text | #FFFFFF | Brand color | 4.5:1+ | AA |
| Link text | Brand color | #FFFFFF | 4.5:1+ | AA |
| Disabled text | #999999 | #FFFFFF | 3:1 | AA (large) |
| Error text | #CC0000 | #FFFFFF | 5.9:1 | AA |

**Additional Requirements:**
- Never use color alone to convey information
- Include icons or text labels alongside color indicators
- Provide high-contrast mode option in Accessibility Settings
- Test with iOS color filters (grayscale, red/green filter)

---

## 5. Key Interaction Patterns

### 5.1 Filtering System

**Need-Based to Feature Mapping:**

```
USER SAYS                    MAPS TO FEATURES
────────────────────────────────────────────────────────────────
"Buttons are hard"       →   magnetic_closures, velcro, snap
"I dress while seated"   →   seated_cut, wheelchair_friendly
"Tags bother me"         →   tagless, flat_seams, sensory_friendly
"Limited arm movement"   →   front_dressing, wide_neck, easy_grip
"I wear leg braces"      →   afo_compatible, adjustable, wide_leg
"Hard to pull over head" →   front_opening, button_front, side_zip
```

### 5.2 Dual Mode (Individual/Caregiver) Switching

**Mode Differences:**

| Aspect | Individual Mode | Caregiver Mode |
|--------|-----------------|----------------|
| Profile prompt | "Your challenges" | "[Person]'s challenges" |
| Feed headers | "For You" | "For [Name]" |
| Review filter | "People like me" | "Caregivers" + "People like [Name]" |
| Tips | Independence-focused | Care-assistance focused |
| Badges | "Easy to wear" | "Easy to help with" |
| Language | "your size" | "their size" / "[Name]'s size" |

### 5.3 Affiliate Link Presentation

**Transparency Principles:**
1. Always disclose affiliate relationship
2. Never disguise external links as internal
3. Show brand name prominently
4. Allow users to dismiss disclosure after reading

---

## 6. Summary

This UX architecture document provides the foundation for building Able, an adaptive fashion discovery app that prioritizes:

1. **Accessibility First:** Every interaction designed for users with disabilities
2. **Discovery Over Search:** Personalized feeds bring relevant products to users
3. **Need-Based Filtering:** Human language challenges map to technical features
4. **Dignity in Design:** Fashion-forward aesthetic, empowering language
5. **Dual Mode Support:** Seamless experience for individuals and caregivers

**Success Metrics to Design For:**
- Time to first relevant product: < 30 seconds from launch
- Filter application success: > 90% find useful results
- Accessibility audit: WCAG 2.1 AA compliance
- User satisfaction: Products match stated needs > 80% of time

---

*Document created by UX Architect, Irora City*
*Version 1.0 | 2026-01-05*
