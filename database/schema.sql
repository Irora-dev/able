-- =============================================================================
-- Able - Adaptive Fashion Aggregator Database Schema
-- Supabase-compatible PostgreSQL
-- =============================================================================
-- Version: 1.0
-- Created: 2026-01-05
-- =============================================================================

-- Enable required extensions
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- =============================================================================
-- ENUM TYPES
-- =============================================================================

CREATE TYPE closure_type AS ENUM (
    'magnetic', 'velcro', 'snap', 'side_zip', 'back_opening',
    'pull_on', 'front_opening', 'easy_grip_zipper', 'hook_and_loop',
    'elastic', 'wrap_tie', 'none'
);

CREATE TYPE product_category AS ENUM (
    'tops', 'bottoms', 'dresses', 'outerwear', 'sleepwear',
    'underwear', 'footwear', 'accessories', 'kids_tops',
    'kids_bottoms', 'kids_dresses', 'kids_footwear', 'kids_accessories'
);

CREATE TYPE feature_category AS ENUM (
    'closure', 'fit', 'sensory', 'specialized', 'ease_of_dressing'
);

CREATE TYPE user_mode AS ENUM ('individual', 'caregiver');

CREATE TYPE price_tier AS ENUM ('budget', 'mid', 'premium');

CREATE TYPE gender_category AS ENUM (
    'mens', 'womens', 'unisex', 'boys', 'girls', 'kids_unisex'
);

CREATE TYPE vote_type AS ENUM ('helpful', 'not_helpful');

-- =============================================================================
-- CORE TABLES
-- =============================================================================

-- Brands
CREATE TABLE brands (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name VARCHAR(255) NOT NULL,
    slug VARCHAR(255) NOT NULL UNIQUE,
    description TEXT,
    logo_url VARCHAR(512),
    website_url VARCHAR(512) NOT NULL,
    is_adaptive_only BOOLEAN DEFAULT false,
    has_mainstream_line BOOLEAN DEFAULT false,
    affiliate_network VARCHAR(100),
    affiliate_program_id VARCHAR(255),
    commission_rate DECIMAL(5, 2),
    price_tier price_tier DEFAULT 'mid',
    is_active BOOLEAN DEFAULT true,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE INDEX idx_brands_slug ON brands(slug);
CREATE INDEX idx_brands_is_active ON brands(is_active);

-- Adaptive Features
CREATE TABLE adaptive_features (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name VARCHAR(255) NOT NULL,
    slug VARCHAR(255) NOT NULL UNIQUE,
    description TEXT,
    category feature_category NOT NULL,
    icon_name VARCHAR(100),
    search_terms TEXT[],
    display_name VARCHAR(255) NOT NULL,
    badge_text VARCHAR(100),
    is_active BOOLEAN DEFAULT true,
    sort_order INTEGER DEFAULT 0,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE INDEX idx_adaptive_features_slug ON adaptive_features(slug);
CREATE INDEX idx_adaptive_features_category ON adaptive_features(category);

-- User Challenges
CREATE TABLE user_challenges (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name VARCHAR(255) NOT NULL,
    slug VARCHAR(255) NOT NULL UNIQUE,
    display_text VARCHAR(500) NOT NULL,
    description TEXT,
    icon_name VARCHAR(100),
    sort_order INTEGER DEFAULT 0,
    is_active BOOLEAN DEFAULT true,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Challenge to Feature Mapping
CREATE TABLE challenge_feature_mapping (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    challenge_id UUID NOT NULL REFERENCES user_challenges(id) ON DELETE CASCADE,
    feature_id UUID NOT NULL REFERENCES adaptive_features(id) ON DELETE CASCADE,
    relevance_score INTEGER DEFAULT 100,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    UNIQUE(challenge_id, feature_id)
);

-- Categories
CREATE TABLE categories (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name VARCHAR(255) NOT NULL,
    slug VARCHAR(255) NOT NULL UNIQUE,
    description TEXT,
    parent_id UUID REFERENCES categories(id) ON DELETE SET NULL,
    category_type product_category NOT NULL,
    icon_name VARCHAR(100),
    image_url VARCHAR(512),
    sort_order INTEGER DEFAULT 0,
    is_active BOOLEAN DEFAULT true,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Products
CREATE TABLE products (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    brand_id UUID NOT NULL REFERENCES brands(id) ON DELETE CASCADE,
    category_id UUID NOT NULL REFERENCES categories(id) ON DELETE CASCADE,
    name VARCHAR(500) NOT NULL,
    slug VARCHAR(500) NOT NULL,
    description TEXT,
    price DECIMAL(10, 2) NOT NULL,
    original_price DECIMAL(10, 2),
    currency VARCHAR(3) DEFAULT 'USD',
    gender gender_category NOT NULL,
    closure_type closure_type,
    image_url VARCHAR(512),
    image_urls TEXT[],
    product_url VARCHAR(1024) NOT NULL,
    affiliate_url VARCHAR(1024),
    is_available BOOLEAN DEFAULT true,
    available_sizes TEXT[],
    external_id VARCHAR(255),
    sku VARCHAR(255),
    search_text TSVECTOR,
    safety_notes TEXT,
    pacemaker_safe BOOLEAN,
    review_count INTEGER DEFAULT 0,
    average_rating DECIMAL(3, 2),
    save_count INTEGER DEFAULT 0,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW(),
    last_synced_at TIMESTAMPTZ,
    UNIQUE(brand_id, slug)
);

CREATE INDEX idx_products_brand ON products(brand_id);
CREATE INDEX idx_products_category ON products(category_id);
CREATE INDEX idx_products_price ON products(price);
CREATE INDEX idx_products_available ON products(is_available);
CREATE INDEX idx_products_search ON products USING GIN(search_text);

-- Product Features Junction
CREATE TABLE product_features (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    product_id UUID NOT NULL REFERENCES products(id) ON DELETE CASCADE,
    feature_id UUID NOT NULL REFERENCES adaptive_features(id) ON DELETE CASCADE,
    notes TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    UNIQUE(product_id, feature_id)
);

-- =============================================================================
-- USER TABLES
-- =============================================================================

-- Care Recipients (before profiles due to FK)
CREATE TABLE care_recipients (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID NOT NULL,
    name VARCHAR(255) NOT NULL,
    relationship VARCHAR(100),
    gender gender_category,
    sizes TEXT[],
    price_preference price_tier,
    notes TEXT,
    is_active BOOLEAN DEFAULT true,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- User Profiles
CREATE TABLE profiles (
    id UUID PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
    display_name VARCHAR(255),
    avatar_url VARCHAR(512),
    current_mode user_mode DEFAULT 'individual',
    preferred_gender gender_category,
    preferred_sizes TEXT[],
    preferred_price_tier price_tier,
    onboarding_completed BOOLEAN DEFAULT false,
    onboarding_step INTEGER DEFAULT 0,
    notifications_enabled BOOLEAN DEFAULT true,
    email_new_arrivals BOOLEAN DEFAULT false,
    email_saved_item_sales BOOLEAN DEFAULT true,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW(),
    last_active_at TIMESTAMPTZ
);

-- Add FK to care_recipients
ALTER TABLE care_recipients
    ADD CONSTRAINT fk_care_recipients_user
    FOREIGN KEY (user_id) REFERENCES profiles(id) ON DELETE CASCADE;

-- User Needs
CREATE TABLE user_needs (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
    challenge_id UUID NOT NULL REFERENCES user_challenges(id) ON DELETE CASCADE,
    care_recipient_id UUID REFERENCES care_recipients(id) ON DELETE CASCADE,
    priority INTEGER DEFAULT 1,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Saved Items
CREATE TABLE saved_items (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
    product_id UUID NOT NULL REFERENCES products(id) ON DELETE CASCADE,
    care_recipient_id UUID REFERENCES care_recipients(id) ON DELETE SET NULL,
    collection_name VARCHAR(255),
    notes TEXT,
    price_when_saved DECIMAL(10, 2),
    created_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE INDEX idx_saved_items_user ON saved_items(user_id);
CREATE INDEX idx_saved_items_product ON saved_items(product_id);

-- =============================================================================
-- COMMUNITY TABLES
-- =============================================================================

-- Reviews
CREATE TABLE reviews (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    product_id UUID NOT NULL REFERENCES products(id) ON DELETE CASCADE,
    user_id UUID NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
    rating INTEGER NOT NULL CHECK (rating >= 1 AND rating <= 5),
    title VARCHAR(255),
    body TEXT NOT NULL,
    reviewer_challenges TEXT[],
    is_caregiver_review BOOLEAN DEFAULT false,
    ease_of_dressing_rating INTEGER CHECK (ease_of_dressing_rating >= 1 AND ease_of_dressing_rating <= 5),
    quality_rating INTEGER CHECK (quality_rating >= 1 AND quality_rating <= 5),
    style_rating INTEGER CHECK (style_rating >= 1 AND style_rating <= 5),
    value_rating INTEGER CHECK (value_rating >= 1 AND value_rating <= 5),
    size_purchased VARCHAR(50),
    fit_feedback VARCHAR(50),
    is_verified_purchase BOOLEAN DEFAULT false,
    is_approved BOOLEAN DEFAULT true,
    is_flagged BOOLEAN DEFAULT false,
    helpful_count INTEGER DEFAULT 0,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE INDEX idx_reviews_product ON reviews(product_id);
CREATE INDEX idx_reviews_approved ON reviews(is_approved);

-- Review Helpful Votes
CREATE TABLE review_helpful (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    review_id UUID NOT NULL REFERENCES reviews(id) ON DELETE CASCADE,
    user_id UUID NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
    vote vote_type NOT NULL,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    UNIQUE(review_id, user_id)
);

-- =============================================================================
-- AFFILIATE TABLES
-- =============================================================================

-- Affiliate Links
CREATE TABLE affiliate_links (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    product_id UUID NOT NULL REFERENCES products(id) ON DELETE CASCADE,
    affiliate_url VARCHAR(2048) NOT NULL,
    affiliate_network VARCHAR(100),
    affiliate_program_id VARCHAR(255),
    tracking_id VARCHAR(255),
    sub_id VARCHAR(255),
    is_active BOOLEAN DEFAULT true,
    last_verified_at TIMESTAMPTZ,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Affiliate Clicks
CREATE TABLE affiliate_clicks (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    affiliate_link_id UUID NOT NULL REFERENCES affiliate_links(id) ON DELETE CASCADE,
    product_id UUID NOT NULL REFERENCES products(id) ON DELETE CASCADE,
    brand_id UUID NOT NULL REFERENCES brands(id) ON DELETE CASCADE,
    user_id UUID REFERENCES profiles(id) ON DELETE SET NULL,
    source VARCHAR(100),
    session_id VARCHAR(255),
    device_type VARCHAR(50),
    app_version VARCHAR(20),
    clicked_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE INDEX idx_affiliate_clicks_date ON affiliate_clicks(clicked_at);

-- =============================================================================
-- TRIGGERS
-- =============================================================================

CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER update_brands_updated_at BEFORE UPDATE ON brands
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_products_updated_at BEFORE UPDATE ON products
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_profiles_updated_at BEFORE UPDATE ON profiles
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_reviews_updated_at BEFORE UPDATE ON reviews
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

-- Auto-create profile on signup
CREATE OR REPLACE FUNCTION handle_new_user()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO public.profiles (id) VALUES (NEW.id);
    RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

CREATE TRIGGER on_auth_user_created
    AFTER INSERT ON auth.users
    FOR EACH ROW EXECUTE FUNCTION handle_new_user();

-- =============================================================================
-- ROW LEVEL SECURITY
-- =============================================================================

ALTER TABLE brands ENABLE ROW LEVEL SECURITY;
ALTER TABLE products ENABLE ROW LEVEL SECURITY;
ALTER TABLE profiles ENABLE ROW LEVEL SECURITY;
ALTER TABLE saved_items ENABLE ROW LEVEL SECURITY;
ALTER TABLE reviews ENABLE ROW LEVEL SECURITY;
ALTER TABLE affiliate_clicks ENABLE ROW LEVEL SECURITY;

-- Public read for catalog
CREATE POLICY "Brands viewable by everyone" ON brands FOR SELECT USING (is_active = true);
CREATE POLICY "Products viewable by everyone" ON products FOR SELECT USING (is_available = true);
CREATE POLICY "Reviews viewable by everyone" ON reviews FOR SELECT USING (is_approved = true);

-- User-specific policies
CREATE POLICY "Users can view own profile" ON profiles FOR SELECT USING (auth.uid() = id);
CREATE POLICY "Users can update own profile" ON profiles FOR UPDATE USING (auth.uid() = id);

CREATE POLICY "Users can view own saved items" ON saved_items FOR SELECT USING (auth.uid() = user_id);
CREATE POLICY "Users can insert own saved items" ON saved_items FOR INSERT WITH CHECK (auth.uid() = user_id);
CREATE POLICY "Users can delete own saved items" ON saved_items FOR DELETE USING (auth.uid() = user_id);

CREATE POLICY "Users can insert own reviews" ON reviews FOR INSERT WITH CHECK (auth.uid() = user_id);
CREATE POLICY "Users can update own reviews" ON reviews FOR UPDATE USING (auth.uid() = user_id);

CREATE POLICY "Anyone can insert clicks" ON affiliate_clicks FOR INSERT WITH CHECK (true);

-- =============================================================================
-- END OF SCHEMA
-- =============================================================================
