# Able - Asset Specifications

## App Icon

### Design Requirements
- **Style**: Modern, minimal wordmark
- **Letter**: Stylized "A" that suggests inclusivity and accessibility
- **Background**: Gradient from Blush (#E8D5D5) to Warm White (#FAF8F5)
- **Foreground**: Ink (#1A1A2E)
- **Corner Radius**: Automatic iOS rounded corners (don't add your own)

### Sizes Required (iOS)
| Size | Scale | Dimensions | Usage |
|------|-------|------------|-------|
| 20pt | 2x | 40x40 | Notification (iPhone) |
| 20pt | 3x | 60x60 | Notification (iPhone) |
| 29pt | 2x | 58x58 | Settings (iPhone) |
| 29pt | 3x | 87x87 | Settings (iPhone) |
| 40pt | 2x | 80x80 | Spotlight (iPhone) |
| 40pt | 3x | 120x120 | Spotlight (iPhone) |
| 60pt | 2x | 120x120 | App Icon (iPhone) |
| 60pt | 3x | 180x180 | App Icon (iPhone) |
| 1024pt | 1x | 1024x1024 | App Store |

### Contents.json Structure
```json
{
  "images": [
    { "size": "20x20", "idiom": "iphone", "scale": "2x", "filename": "Icon-20@2x.png" },
    { "size": "20x20", "idiom": "iphone", "scale": "3x", "filename": "Icon-20@3x.png" },
    { "size": "29x29", "idiom": "iphone", "scale": "2x", "filename": "Icon-29@2x.png" },
    { "size": "29x29", "idiom": "iphone", "scale": "3x", "filename": "Icon-29@3x.png" },
    { "size": "40x40", "idiom": "iphone", "scale": "2x", "filename": "Icon-40@2x.png" },
    { "size": "40x40", "idiom": "iphone", "scale": "3x", "filename": "Icon-40@3x.png" },
    { "size": "60x60", "idiom": "iphone", "scale": "2x", "filename": "Icon-60@2x.png" },
    { "size": "60x60", "idiom": "iphone", "scale": "3x", "filename": "Icon-60@3x.png" },
    { "size": "1024x1024", "idiom": "ios-marketing", "scale": "1x", "filename": "Icon-1024.png" }
  ],
  "info": { "version": 1, "author": "xcode" }
}
```

---

## Launch Screen

### Design
- Background: Warm White (#FAF8F5)
- Centered: App icon at 80pt
- Below icon: "Able" wordmark in Ink (#1A1A2E), SF Pro Bold, 28pt
- No loading indicators

### Implementation
Use a LaunchScreen.storyboard with:
- UIView background: Warm White
- Centered UIImageView: app-icon-80.png
- UILabel below: "Able" text

---

## Tab Bar Icons

### Requirements
- All icons: 24x24pt base size
- Provide @2x (48x48) and @3x (72x72) versions
- Style: SF Symbols or custom matching SF Symbol weight
- States: Unselected (Stone #6B6B7B), Selected (Terracotta #C75B39)

### Icons
| Tab | SF Symbol | Custom Alternative |
|-----|-----------|-------------------|
| Home | house | house.fill (selected) |
| Browse | magnifyingglass | - |
| Saved | heart | heart.fill (selected) |
| Profile | person | person.fill (selected) |

---

## Feature Icons

### Closure Types
| Feature | SF Symbol | Fallback |
|---------|-----------|----------|
| Magnetic | button.programmable | Custom magnet icon |
| Velcro | rectangle.connected.to.line.below | Custom hook icon |
| Snap | circle.dotted | Custom snap icon |
| Side Zip | arrow.left.and.right | Custom zipper icon |
| Pull-on | arrow.down.to.line | Custom pull icon |
| Easy Zipper | slider.horizontal.3 | Custom zipper pull |

### Fit Types
| Feature | SF Symbol |
|---------|-----------|
| Seated Cut | figure.roll |
| Adjustable | ruler |
| Extra Room | rectangle.expand.vertical |

### Sensory
| Feature | SF Symbol |
|---------|-----------|
| Tagless | tag.slash |
| Flat Seams | line.horizontal.3 |
| Soft Fabrics | cloud |

### Sizes
- Base: 20x20pt
- Touch target container: 44x44pt minimum
- Color: Clay (#A67C6D) or Ink (#1A1A2E)

---

## Category Icons

| Category | SF Symbol | Size |
|----------|-----------|------|
| Tops | tshirt | 28pt |
| Bottoms | figure.stand | 28pt |
| Dresses | figure.dress.line.vertical.figure | 28pt |
| Outerwear | cloud.rain | 28pt |
| Sleepwear | moon.stars | 28pt |
| Underwear | heart | 28pt |
| Footwear | shoe | 28pt |
| Accessories | bag | 28pt |
| Kids | person.2 | 28pt |

---

## Empty State Illustrations

### Specifications
- Size: 200x200pt
- Style: Simple line art with brand colors
- Background elements: Blush (#E8D5D5) shapes
- Foreground: Ink (#1A1A2E) outlines
- Accent: Clay (#A67C6D) or Terracotta (#C75B39) highlights

### Required Illustrations
1. **No Saved Items**: Heart outline with clothing silhouette
2. **No Search Results**: Magnifying glass with question mark
3. **Network Error**: Cloud with X
4. **Empty Cart**: Shopping bag outline
5. **Welcome/Onboarding**: Person with wardrobe

---

## Brand Assets

### Logo Variations
1. **Full Logo**: "Able" wordmark + icon
2. **Icon Only**: Stylized "A"
3. **Wordmark Only**: "Able" text

### Logo Specifications
- Wordmark font: SF Pro Display Bold or custom
- Letter spacing: -2%
- Minimum size: 32pt height
- Clear space: 1x height on all sides

### Logo Files Needed
- able-logo-full.svg
- able-logo-icon.svg
- able-logo-wordmark.svg
- PNG exports at 1x, 2x, 3x

---

## Color Assets

### Asset Catalog Colors
Create Color Sets in Assets.xcassets for:

```
Colors/
├── AbleInk.colorset/
├── AbleBlush.colorset/
├── AbleWarmWhite.colorset/
├── AbleClay.colorset/
├── AbleStone.colorset/
├── AbleSage.colorset/
├── AbleCream.colorset/
├── AbleTerracotta.colorset/
├── AbleTerracottaPressed.colorset/
├── AbleDustyRose.colorset/
├── AbleOcean.colorset/
├── AbleSuccess.colorset/
├── AbleError.colorset/
├── AbleWarning.colorset/
├── AbleInfo.colorset/
├── AbleDeepInk.colorset/
├── AbleElevatedDark.colorset/
├── AbleSoftWhite.colorset/
├── AbleMutedStone.colorset/
├── AbleDeepBlush.colorset/
└── AbleBrightTerracotta.colorset/
```

### Color Set JSON Structure Example
```json
{
  "colors": [
    {
      "color": {
        "color-space": "srgb",
        "components": {
          "red": "0.102",
          "green": "0.102",
          "blue": "0.180",
          "alpha": "1.000"
        }
      },
      "idiom": "universal"
    }
  ],
  "info": { "version": 1, "author": "xcode" }
}
```

---

## Image Placeholders

### Product Image Placeholder
- Size: 200x200pt
- Background: Cream (#F5F0E8)
- Icon: photo (SF Symbol) in Stone (#6B6B7B)
- Corner radius: 16pt

### Avatar Placeholder
- Size: 50x50pt (circular)
- Background: Blush (#E8D5D5)
- Icon: person (SF Symbol) in Stone

### Brand Logo Placeholder
- Size: 40x40pt
- Background: Cream
- Icon: building.2 (SF Symbol) in Stone

---

## Export Checklist

### Before Development
- [ ] App Icon (all sizes)
- [ ] Launch screen assets
- [ ] Tab bar icons (all states)
- [ ] Placeholder images

### For MVP
- [ ] Feature icons (20 minimum)
- [ ] Category icons (9 categories)
- [ ] Empty state illustrations (5)

### For Launch
- [ ] Full brand logo suite
- [ ] All color assets
- [ ] App Store screenshots
- [ ] App Store preview video

---

## File Naming Convention

```
[asset-type]-[name]-[variant]@[scale].[format]

Examples:
icon-app@2x.png
icon-tab-home@3x.png
icon-tab-home-selected@3x.png
icon-feature-magnetic.svg
illustration-empty-saved.svg
logo-full-light.svg
logo-full-dark.svg
```

---

## App Store Assets

### Screenshots
- 6.7" Display: 1290 x 2796 px
- 6.5" Display: 1284 x 2778 px
- 5.5" Display: 1242 x 2208 px

### Screenshot Frames
1. Onboarding welcome
2. Home feed with "For You"
3. Product detail with features
4. Filter by adaptive features
5. Saved items with price drop
6. Browse categories

### Preview Video
- Duration: 15-30 seconds
- Resolution: Match screenshot sizes
- Content: Quick tour of key features

---

*Asset Spec Version: 1.0*
*Last Updated: 2026-01-05*
