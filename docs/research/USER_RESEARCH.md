# User Research: Adaptive Fashion Aggregator (iOS App)

## Executive Summary

The adaptive clothing market serves two distinct but overlapping user groups: **individuals with disabilities** who want to dress independently and maintain personal style, and **caregivers** who need practical solutions that simplify dressing routines. Both groups face a fragmented, frustrating discovery process marked by poor information architecture, lack of specialized retail expertise, and the emotional burden of shopping in a market that often treats them as an afterthought. The opportunity lies in creating a discovery-first experience that respects dignity, aggregates scattered options, and provides the detailed product information these users desperately need.

---

## Primary Personas

### Persona 1: Marcus - The Independent Adapter

**Demographics:**
- Age: 32
- Occupation: Remote software developer
- Disability: Spinal cord injury (T4 paraplegic), wheelchair user for 8 years
- Technical Comfort: High
- Income: Middle-upper ($85k)

**Goals:**
- **Primary:** Find stylish clothing that works with his body and wheelchair without looking "medical"
- **Secondary:** Dress independently without assistance; maintain professional appearance for video calls
- **Tertiary:** Discover new brands and options he doesn't know exist

**Frustrations:**
- "I spend hours searching Google for 'wheelchair-friendly pants' and get the same 5 geriatric-looking options every time"
- Mainstream brands rarely indicate if clothes work seated; has to guess and return
- Hates that adaptive clothing is marketed with photos of elderly people in hospital settings
- Can't easily filter by specific features (seated rise, magnetic closures, side openings)
- Returns are exhausting - getting to the post office in a wheelchair is a whole ordeal

**Quote:** "I didn't lose my sense of style when I got injured. I just lost the ability to find clothes that work for me AND look good."

**Usage Context:**
- Browses on iPhone during evenings and weekends
- Deep research sessions (20-30 min) when he needs something specific
- Quick saves/bookmarks when he discovers something interesting
- Would share good finds with his SCI Facebook group

**Shopping Behavior:**
- Currently uses: Google searches, niche adaptive brand websites, Reddit r/spinalcordinjury, Facebook groups
- Spends 3-4x longer than average shopper researching before purchase
- Price sensitive but will pay premium for right fit
- Heavily influenced by peer recommendations from disability community

---

### Persona 2: Linda - The Caregiver Navigator

**Demographics:**
- Age: 58
- Occupation: Part-time office manager, primary caregiver for mother
- Care recipient: 82-year-old mother with advanced Parkinson's disease
- Technical Comfort: Medium
- Income: Middle ($55k, stretched thin with care costs)

**Goals:**
- **Primary:** Find clothes that make dressing her mother easier and faster (reduces daily struggle)
- **Secondary:** Maintain her mother's dignity - she was always a stylish dresser
- **Tertiary:** Not spend hours researching; needs quick, reliable options

**Frustrations:**
- "I didn't know adaptive clothing existed until her occupational therapist mentioned it"
- Overwhelmed by options she doesn't understand - what's the difference between all these closure types?
- Hard to know what will actually help with her mother's specific challenges (tremors, rigidity)
- Mother resists "old people clothes" - needs options that don't scream institutional
- Bought wrong things multiple times - wasted money she can't afford to waste

**Quote:** "I just need someone to tell me: for a person with Parkinson's who can't do buttons, here's what actually works."

**Usage Context:**
- Quick research during lunch breaks or waiting rooms
- Often distracted, interrupted - needs to be able to save and return
- Would research on iPhone, possibly purchase on desktop later
- Desperate for curated recommendations, not endless browsing

**Shopping Behavior:**
- Currently uses: Google (overwhelmed), Amazon (poor filtering), OT recommendations (limited)
- Decision paralysis from too many unknown brands
- Very return-conscious due to time constraints
- Will pay more for confidence in purchase
- Trusts occupational therapist and caregiver forum recommendations highly

---

### Persona 3: Jasmine - The Disability Parent

**Demographics:**
- Age: 34
- Occupation: Marketing manager (full-time)
- Child: 7-year-old son with cerebral palsy (uses AFO braces, limited fine motor)
- Technical Comfort: High
- Income: Middle-upper (dual income household)

**Goals:**
- **Primary:** Find clothes her son can wear that accommodate his braces and let him dress more independently
- **Secondary:** Make him look like his peers - not "the kid with special clothes"
- **Tertiary:** Find options quickly; has no time for extensive research

**Frustrations:**
- "Every back-to-school season is a nightmare. Where are the pants that fit over AFOs?"
- Children's adaptive options are even more limited than adult
- Mainstream kids' brands assume standard sizing - his needs are completely different
- Tired of modifying regular clothes herself (cutting seams, adding velcro)
- Style options are terrible - everything looks babyish for his age

**Quote:** "He wants to wear what his friends wear. He just needs it to work differently."

**Usage Context:**
- Researches in short bursts - during son's therapy sessions, before bed
- Seasonal intense shopping (back to school, growth spurts)
- Active in CP parent Facebook groups, shares finds
- Would use app frequently if it solved her problem

**Shopping Behavior:**
- Currently uses: Facebook groups (best source), specialty shops, endless Google searching
- Relies heavily on other parents' recommendations
- Willing to pay premium for quality and style
- Frustrated by limited size ranges in adaptive kids' wear
- Makes purchase decisions quickly once she finds something promising

---

## User Journey Map

### Current State: Finding Adaptive Clothing (Without App)

```
[TRIGGER]                    [AWARENESS]                     [SEARCH]
"Need new pants that         "I've heard adaptive           Google: "adaptive pants
 work with wheelchair"        clothing exists"               wheelchair"
        │                           │                              │
        ▼                           ▼                              ▼
   Often triggered by:        Many don't know the          Results are overwhelming:
   - Frustration event         term "adaptive"             - Mix of medical supply
   - Occupational therapist   - Takes months/years to       sites and fashion brands
   - Peer recommendation       discover market exists      - SEO spam articles
   - Life transition                                       - Same brands repeatedly
        │
        ▼
[DISCOVERY]                  [EVALUATION]                   [PURCHASE]
 Visit 5-10 different         "Is this what I need?"        "Hope this works..."
 brand websites                      │                             │
        │                            ▼                             ▼
        ▼                     - Poor product photos         - High uncertainty
 - No aggregated view         - Missing key specs           - Expensive shipping
 - Each site different        - Don't know if it fits       - Complicated returns
 - Can't compare easily         my specific need            - Often doesn't fit
 - Limited filtering          - No peer reviews             - 30-40% return rate
        │
        ▼
[POST-PURCHASE]              [SHARE/REPEAT]
 "It doesn't fit /           Finally found something
  doesn't work"               that works!
        │                            │
        ▼                            ▼
 - Returns are hard           - Share in Facebook group
 - Money wasted               - Bookmark brand
 - Back to square one         - Hope they don't discontinue
 - Trust eroded
```

### Pain Points in Current Journey

| Stage | Pain Point | Severity | Quote |
|-------|-----------|----------|-------|
| Awareness | Don't know adaptive clothing exists | Critical | "I spent 2 years struggling before someone told me this was a thing" |
| Awareness | Don't know the right search terms | High | "I was searching 'easy to put on clothes' and getting toddler results" |
| Search | No centralized place to browse | Critical | "Every brand has its own website. I have 47 bookmarked." |
| Search | Generic search engines don't understand needs | High | "Google shows me the same 3 brands no matter what I search" |
| Discovery | Can't filter by specific adaptive features | Critical | "I need magnetic buttons specifically but can't search for that" |
| Discovery | Don't know what brands/options exist | High | "I keep finding new brands I never heard of. How many are there?" |
| Evaluation | Poor product photography | High | "Show me what it looks like on a seated person, not a standing model" |
| Evaluation | Missing critical specifications | Critical | "Nowhere does it say if this works with AFO braces" |
| Evaluation | No peer reviews from similar users | High | "Amazon reviews are useless - I need to hear from other wheelchair users" |
| Purchase | Sizing is unpredictable | Critical | "Every brand sizes differently. I'm 3 different sizes across brands" |
| Purchase | Returns are difficult | High | "Getting to the post office is hard enough. Returns are a nightmare" |
| Post-purchase | Favorite items get discontinued | Medium | "I finally found perfect pants and they stopped making them" |

---

## Pain Points (Prioritized by Severity)

| Rank | Pain Point | Severity | Frequency | Personas Affected | App Opportunity |
|------|-----------|----------|-----------|-------------------|-----------------|
| 1 | **No centralized discovery platform** | Critical | Every shopping session | All | Core value proposition |
| 2 | **Can't filter by specific adaptive features** | Critical | Every search | All | Advanced filtering system |
| 3 | **Missing product specifications** | Critical | Every evaluation | All | Standardized product data |
| 4 | **Sizing unpredictability across brands** | Critical | Every purchase | All | Size comparison tools |
| 5 | **Don't know what exists** | High | Initial discovery | All | Discovery-focused browsing |
| 6 | **Lack of peer reviews from similar users** | High | Every evaluation | Marcus, Jasmine | Community reviews by disability type |
| 7 | **Returns are difficult with disability** | High | 30-40% of purchases | Marcus, Linda | Return policy visibility, fit prediction |
| 8 | **Products marketed as "medical" not stylish** | High | Style-conscious moments | Marcus, Jasmine | Style-forward curation |
| 9 | **Overwhelming for caregivers** | High | Every session | Linda | Guided recommendations |
| 10 | **Limited children's options** | Medium | Seasonal | Jasmine | Kids section, age-appropriate filters |

---

## Decision Factors (Ranked by Importance)

### 1. Functional Fit (Must Have)
**Weight: Critical**
- Does it actually work for my specific disability/need?
- Will it accommodate my equipment (wheelchair, braces, prosthetics)?
- Can I dress myself or dress my care recipient?
- "Fit" means more than size - it means functional for my body

### 2. Dignity/Style (Essential)
**Weight: Very High**
- Does it look like regular clothing, not medical equipment?
- Will I/they feel good wearing this?
- Age-appropriate styling (especially for children and young adults)
- "I don't want to look disabled"

### 3. Return Policy & Purchase Confidence
**Weight: Very High**
- What if it doesn't work? How hard is the return?
- Can I trust the sizing information?
- Are there reviews from people like me?
- Free returns are almost a requirement

### 4. Price
**Weight: High (but complex)**
- Adaptive clothing averages 20-40% more than mainstream
- Users ARE willing to pay premium for right solution
- But many are on fixed incomes (disability benefits) or stretched (caregiver costs)
- Value sensitivity more than pure price sensitivity
- "Expensive" is acceptable if it works; "cheap and doesn't work" is unacceptable

### 5. Durability
**Weight: High**
- Adaptive features must survive repeated use
- Velcro wears out, magnets can weaken
- Laundering adaptive features without damage
- Wheelchair users especially hard on seat areas

### 6. Availability & Sizing
**Weight: High**
- Is my size available?
- Extended sizing is common need (seated bodies, atypical proportions)
- Consistent availability (not constantly out of stock)

### 7. Brand Trust
**Weight: Medium-High**
- New brands face skepticism
- Disability-owned or disability-designed brands get preference
- Mainstream brands entering space viewed with some suspicion
- Community endorsement matters enormously

---

## Emotional Journey

### The Emotional Landscape of Adaptive Clothing Shopping

**Pre-Shopping Emotions:**
- Dread: "Here we go again"
- Frustration: Knowing the process will be hard
- Resignation: "I'll probably end up with the same ugly options"
- For caregivers: Guilt about not having time to find better options

**During Shopping:**
- Overwhelm: Too many unknown options, no guidance
- Frustration: Can't find what's needed, poor search results
- Self-consciousness: Feeling like an outsider in fashion
- Confusion: Which features do I actually need?
- Hope (rare): When discovering a new brand or option

**Post-Purchase (Negative Outcome):**
- Disappointment: "It doesn't work like I hoped"
- Anger: Wasted money and time
- Exhaustion: Have to start the return process
- Defeat: "Maybe I'm stuck with what I have"

**Post-Purchase (Positive Outcome):**
- Relief: "Finally, something that works"
- Joy: Feeling good in clothing
- Pride: Looking stylish, feeling "normal"
- Evangelism: Eager to share with others

### Making the Experience Positive

The app should:

1. **Validate immediately**: Show that this app understands - disability-first language, relevant imagery, no medical-catalog feel

2. **Reduce anxiety**: Clear, complete information reduces purchase uncertainty

3. **Create delight in discovery**: "I didn't know this existed!" should be a common reaction

4. **Build community**: Reviews and sharing create belonging

5. **Respect autonomy**: Let users define their own needs, don't assume

6. **Celebrate style**: Position adaptive clothing as fashion, not medical supply

---

## Caregiver vs. Individual Differences

| Dimension | Individual with Disability | Caregiver |
|-----------|---------------------------|-----------|
| **Primary Goal** | Independence, self-expression | Ease of caregiving, dignity for recipient |
| **Time Available** | More time for research | Severely time-constrained |
| **Decision Authority** | Full control | Navigating recipient preferences |
| **Key Pain Point** | Finding stylish options | Understanding what features are needed |
| **Price Sensitivity** | Medium (personal budget) | High (stretched by care costs) |
| **Information Need** | "Does this work for MY body?" | "What do I need for their condition?" |
| **Community** | Disability-specific (SCI, CP, etc.) | Caregiver-specific (aging parent, special needs child) |
| **Emotional State** | Seeking dignity and style | Seeking relief and confidence |
| **Feature Priority** | Style first, then function | Function first, then style |
| **Return Tolerance** | Low (accessibility barriers) | Low (no time) |
| **Guidance Needs** | Moderate - knows their body | High - learning care recipient's needs |

### Who Controls Purchasing?

- **Adults with disabilities**: Usually self, sometimes with trusted input
- **Children with disabilities**: Parents decide, child input on style
- **Elderly care recipients**: Often caregiver decides, should involve recipient
- **Institutional care**: Professional caregivers or family advocates

### Recommendation

The app should support BOTH journeys:
1. **Individual mode**: Style-forward, detailed specs, peer community
2. **Caregiver mode**: Guided recommendations, "shop by condition," educational content

---

## UX Recommendations for the App

### Core Experience

1. **Onboarding: Profile Creation**
   - "Shopping for yourself or someone else?"
   - Disability type / condition (optional but helpful for filtering)
   - Specific needs: wheelchair user, uses AFOs, limited hand mobility, etc.
   - Style preferences
   - Save this profile for personalized experience

2. **Discovery-First Home Screen**
   - "New arrivals that work for you"
   - Trending in community
   - "Did you know?" featuring lesser-known brands/options
   - NOT a search bar first - discovery is the value

3. **Filtering System**
   - By adaptive feature: magnetic closures, side-zip, seated rise, etc.
   - By disability type/need: wheelchair user, Parkinson's, arthritis, etc.
   - By style: casual, professional, active, formal
   - By age group: children, young adult, adult, senior
   - By equipment compatibility: AFO-friendly, catheter-accessible, etc.

4. **Product Detail Pages**
   - Standardized adaptive feature icons/badges
   - "Works well for" tags (contributed by community)
   - Photos on diverse bodies (seated, with equipment)
   - Community reviews filtered by similarity to user
   - Size comparison tool across brands
   - Return policy clearly visible

5. **Community Features**
   - Reviews tagged by disability type
   - "Verified purchase" badges
   - Ability to follow reviewers with similar needs
   - Q&A on products
   - Sharing to external communities (Facebook groups)

6. **Caregiver-Specific Features**
   - "Shop by condition" guided experience
   - Educational content: "Understanding adaptive features"
   - "Recommended for Parkinson's" curated lists
   - Care team sharing (OT can recommend products)

### Key UX Principles

| Principle | Implementation |
|-----------|----------------|
| **Dignity-first language** | "Adaptive features" not "disability clothing" |
| **Show diverse bodies** | Wheelchair users, different ages, different disabilities |
| **Assume competence** | Users know their needs; help them find solutions |
| **Reduce decision fatigue** | Curated collections, smart recommendations |
| **Build trust through transparency** | Clear specs, honest reviews, return visibility |
| **Celebrate style** | Fashion-forward presentation, not medical catalog |

---

## Accessibility Considerations

**Critical: Many users of this app will have disabilities themselves.**

### Motor/Dexterity
- Large tap targets (minimum 44x44pt, prefer 48x48pt)
- Avoid small buttons, especially for key actions
- Support for switch access and head tracking
- Avoid gestures that require precision (pinch-to-zoom only as enhancement)
- Voice control compatibility (VoiceOver actions)

### Vision
- Full VoiceOver support with meaningful labels
- High contrast mode
- Dynamic Type support (all text sizes)
- Don't rely on color alone for information
- Clear visual hierarchy

### Cognitive
- Simple, consistent navigation
- Save progress (don't lose filters/searches)
- Avoid time limits
- Clear, plain language
- Progressive disclosure (don't overwhelm)

### Situational
- One-handed operation support
- Works in bright sunlight (caregivers outdoors with recipient)
- Offline access for saved items
- Quick sessions supported (interruption-friendly)

### Testing Recommendations
- Test with actual users with disabilities (not just simulated)
- Include wheelchair users testing on iPhone in lap
- Include users with hand tremors
- Include VoiceOver users
- Include users with cognitive differences

---

## Key Insights

### 1. Discovery Gap is the Opportunity
The adaptive clothing market isn't lacking options - it's lacking discoverability. Dozens of brands exist, but users struggle to find them. An aggregator that simply surfaces what exists creates enormous value.

### 2. "Adaptive" is a Spectrum, Not a Category
Users don't think "I need adaptive clothing" - they think "I need pants that work with my wheelchair" or "I need shirts my mom can put on herself." The app must support specific need-based discovery, not category browsing.

### 3. The Emotional Journey Matters as Much as the Functional
Shopping for adaptive clothing often carries emotional weight - grief over lost abilities, frustration with being "different," desire for normalcy. The app's tone, imagery, and experience can either compound this burden or alleviate it.

### 4. Caregivers Need Guidance, Not Just Options
Individuals with disabilities know their needs. Caregivers often don't - they're learning as they go. The app should provide education and guided recommendations for caregiver users.

### 5. Community Trust Outweighs Brand Marketing
In this market, peer recommendations are gold. Reviews from "someone like me" are worth more than professional product descriptions. Building community features is essential.

---

## Confidence Levels for Findings

| Finding | Confidence | Evidence Basis |
|---------|------------|----------------|
| Discovery is the core problem | **High** | Consistent across all disability community discussions, market analysis |
| Caregivers and individuals have different needs | **High** | Distinct community discussions, different pain point patterns |
| Style/dignity matters as much as function | **High** | Strong theme in user feedback, especially younger demographics |
| Current search/filtering is inadequate | **High** | Universal complaint in adaptive clothing discussions |
| Peer reviews by disability type highly valued | **High** | Community recommendation patterns, forum behavior |
| Return difficulty is major barrier | **High** | Consistent pain point, especially for wheelchair users |
| Price sensitivity is moderate | **Medium** | Varies by segment; fixed income vs. employed |
| Children's adaptive wear is underserved | **Medium-High** | Parent community discussions, limited market options |
| Occupational therapists are key referral source | **Medium** | Mentioned frequently but hard to quantify impact |
| Users will pay for curation/convenience | **Medium** | Inferred from pain points, needs validation |

---

*This document represents the User Researcher deliverable for the Adaptive Fashion Aggregator project.*

*Prepared by: User Researcher, Irora City*
*Date: 2026-01-05*
