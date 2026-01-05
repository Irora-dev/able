import SwiftUI

// MARK: - Product Card

struct ProductCard: View {
    let product: Product
    var isSaved: Bool = false
    var onSaveToggle: (() -> Void)?
    var onTap: (() -> Void)?

    @Environment(\.colorScheme) private var colorScheme

    var body: some View {
        Button(action: { onTap?() }) {
            VStack(alignment: .leading, spacing: AbleSpacing.space2) {
                // Image
                productImage

                // Content
                VStack(alignment: .leading, spacing: AbleSpacing.space1) {
                    // Brand
                    if let brandName = product.brandName {
                        Text(brandName)
                            .font(AbleTypography.caption1)
                            .foregroundColor(Color.ableSecondaryText(for: colorScheme))
                    }

                    // Name
                    Text(product.name)
                        .font(AbleTypography.subheadline)
                        .foregroundColor(Color.ablePrimaryText(for: colorScheme))
                        .lineLimit(2)
                        .multilineTextAlignment(.leading)

                    // Price
                    priceView

                    // Rating
                    if let rating = product.averageRating, product.reviewCount > 0 {
                        ratingView(rating: rating, count: product.reviewCount)
                    }
                }
                .padding(.horizontal, AbleSpacing.space2)
                .padding(.bottom, AbleSpacing.space3)
            }
            .background(Color.ableCardBackground(for: colorScheme))
            .cornerRadius(AbleSpacing.cardCornerRadius)
            .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 2)
        }
        .buttonStyle(PlainButtonStyle())
        .accessibilityElement(children: .combine)
        .accessibilityLabel(accessibilityDescription)
        .accessibilityAddTraits(.isButton)
    }

    // MARK: - Subviews

    private var productImage: some View {
        ZStack(alignment: .topTrailing) {
            // Image placeholder
            AsyncImage(url: URL(string: product.imageUrl ?? "")) { phase in
                switch phase {
                case .empty:
                    Rectangle()
                        .fill(Color.ableCream)
                        .overlay(
                            Image(systemName: "photo")
                                .foregroundColor(Color.ableStone)
                        )
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                case .failure:
                    Rectangle()
                        .fill(Color.ableCream)
                        .overlay(
                            Image(systemName: "photo")
                                .foregroundColor(Color.ableStone)
                        )
                @unknown default:
                    Rectangle()
                        .fill(Color.ableCream)
                }
            }
            .frame(height: 180)
            .clipped()
            .cornerRadius(AbleSpacing.cardCornerRadius, corners: [.topLeft, .topRight])

            // Save button
            Button(action: { onSaveToggle?() }) {
                Image(systemName: isSaved ? "heart.fill" : "heart")
                    .font(.system(size: 20))
                    .foregroundColor(isSaved ? Color.ableError : Color.white)
                    .padding(AbleSpacing.space2)
                    .background(Color.black.opacity(0.3))
                    .clipShape(Circle())
            }
            .padding(AbleSpacing.space2)
            .accessibilityLabel(isSaved ? "Remove from favorites" : "Save to favorites")

            // Sale badge
            if product.isOnSale {
                Text("SALE")
                    .font(AbleTypography.caption2)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.horizontal, AbleSpacing.space2)
                    .padding(.vertical, AbleSpacing.space1)
                    .background(Color.ableError)
                    .cornerRadius(AbleSpacing.tagCornerRadius)
                    .padding(AbleSpacing.space2)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            }
        }
    }

    private var priceView: some View {
        HStack(spacing: AbleSpacing.space1) {
            Text(product.formattedPrice)
                .font(AbleTypography.headline)
                .foregroundColor(product.isOnSale ? Color.ableError : Color.ablePrimaryText(for: colorScheme))

            if product.isOnSale, let original = product.formattedOriginalPrice {
                Text(original)
                    .font(AbleTypography.caption1)
                    .foregroundColor(Color.ableStone)
                    .strikethrough()
            }
        }
    }

    private func ratingView(rating: Decimal, count: Int) -> some View {
        HStack(spacing: AbleSpacing.space1) {
            Image(systemName: "star.fill")
                .font(.system(size: 12))
                .foregroundColor(Color.ableWarning)

            Text(String(format: "%.1f", Double(truncating: rating as NSNumber)))
                .font(AbleTypography.caption1)
                .foregroundColor(Color.ablePrimaryText(for: colorScheme))

            Text("(\(count))")
                .font(AbleTypography.caption1)
                .foregroundColor(Color.ableStone)
        }
    }

    private var accessibilityDescription: String {
        var desc = product.name
        if let brandName = product.brandName {
            desc = "\(brandName) \(desc)"
        }
        desc += ", \(product.formattedPrice)"
        if product.isOnSale {
            desc += ", on sale"
        }
        if isSaved {
            desc += ", saved"
        }
        return desc
    }
}

// MARK: - Corner Radius Extension

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}

// MARK: - Preview

#Preview {
    var sampleProduct = Product(
        id: UUID(),
        brandId: UUID(),
        categoryId: UUID(),
        name: "Magnetic Button Oxford Shirt",
        slug: "magnetic-button-oxford",
        description: "Classic oxford with hidden magnetic closures",
        price: 59.99,
        originalPrice: 79.99,
        currency: "USD",
        gender: .mens,
        closureType: .magnetic,
        imageUrl: nil,
        imageUrls: nil,
        productUrl: "https://example.com",
        affiliateUrl: nil,
        isAvailable: true,
        availableSizes: ["S", "M", "L", "XL"],
        safetyNotes: nil,
        pacemakerSafe: nil,
        reviewCount: 42,
        averageRating: 4.5,
        saveCount: 128,
        createdAt: Date(),
        updatedAt: Date(),
        brandName: "Tommy Adaptive"
    )

    ScrollView {
        LazyVGrid(columns: [
            GridItem(.flexible()),
            GridItem(.flexible())
        ], spacing: AbleSpacing.space4) {
            ProductCard(product: sampleProduct, isSaved: false)
            ProductCard(product: sampleProduct, isSaved: true)
        }
        .padding()
    }
    .background(Color.ableWarmWhite)
}
