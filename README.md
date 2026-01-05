# Able - Adaptive Fashion Aggregator

> **"Find adaptive clothing you didn't know existed"**

An iOS app that helps people with disabilities and caregivers discover adaptive clothing across multiple brands.

## Overview

Able is a discovery-focused fashion aggregator for adaptive clothing. It surfaces products with features like magnetic closures, seated cuts, sensory-friendly fabrics, and more from brands including Tommy Adaptive, Target, Zappos, Nike FlyEase, and specialty adaptive retailers.

## Target Users

- **Individuals with disabilities** seeking stylish, functional clothing
- **Caregivers** shopping for family members or clients
- **Parents** of children with disabilities

## Core Features (v1)

- **Need-Based Discovery**: Filter by challenges ("buttons are hard") not just features
- **Multi-Brand Aggregation**: Products from 15+ brands in one place
- **Adaptive Feature Filtering**: Magnetic closures, seated cuts, sensory-friendly, etc.
- **Dual Mode**: Individual and Caregiver shopping experiences
- **Community Reviews**: Reviews tagged by disability type
- **Affiliate Monetization**: Links to brand sites

## Tech Stack

- **Platform**: iOS (SwiftUI)
- **Backend**: Supabase
- **Auth**: Supabase Auth
- **Monetization**: Affiliate links (Amazon, CJ, Target Partners, etc.)

## Documentation

- [`docs/design/VISUAL_STYLE_GUIDE.md`](docs/design/VISUAL_STYLE_GUIDE.md) - Colors, typography, components
- [`docs/design/UX_ARCHITECTURE.md`](docs/design/UX_ARCHITECTURE.md) - User flows, wireframes
- [`docs/copy/APP_COPY.md`](docs/copy/APP_COPY.md) - All app copy and microcopy

## Design Principles

1. **Fashion-forward, not medical** - Looks like Everlane, not a medical catalog
2. **Accessibility as foundation** - 48pt touch targets, VoiceOver, Dynamic Type
3. **Discovery over search** - Personalized feeds bring products to users
4. **Dignity in language** - "Adaptive features" not "disability clothing"

## Project Status

- [x] Research Phase (Domain, Market, User)
- [x] Specification
- [x] Design Phase (UX, Visual, Copy)
- [ ] Production Phase (Build)

## Repository Structure

```
able/
├── README.md
├── docs/
│   ├── design/
│   │   ├── VISUAL_STYLE_GUIDE.md
│   │   └── UX_ARCHITECTURE.md
│   ├── copy/
│   │   └── APP_COPY.md
│   └── research/
│       ├── DOMAIN_RESEARCH.md
│       ├── MARKET_ANALYSIS.md
│       └── USER_RESEARCH.md
└── Able/                    # iOS app (coming)
    ├── App/
    ├── Views/
    ├── Models/
    └── Services/
```

## Brand Colors

| Color | Hex | Usage |
|-------|-----|-------|
| Ink | `#1A1A2E` | Primary text |
| Terracotta | `#C75B39` | CTAs, buttons |
| Warm White | `#FAF8F5` | Background |
| Ocean | `#4A7C8C` | Links |
| Clay | `#A67C6D` | Secondary accent |

---

*Built with [Irora City](https://github.com/Irora-dev/irora-platform) - A city of AI workers*
