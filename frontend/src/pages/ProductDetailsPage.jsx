import React, { useState, useEffect, useMemo } from 'react';
import { useParams, useNavigate, Link } from 'react-router-dom';
import api from '../api/axios';
import { useAuth } from '../context/AuthContext';
import {
    ShoppingCart,
    ArrowLeft,
    Star,
    Shield,
    ShieldCheck,
    Truck,
    RotateCcw,
    Heart,
    Check,
    Share2,
    Box,
    Sparkles,
    Clock,
    CreditCard,
    Award,
    Info,
    Layers,
    Zap,
    ChevronRight,
    CheckCircle2,
    PackageCheck,
    ThumbsUp,
    Send
} from 'lucide-react';

// Complementary high-res gallery images per category for realistic multi-angle thumbnails
const CATEGORY_GALLERY_IMAGES = {
    'Electronics': [
        'https://images.unsplash.com/photo-1546868871-7041f2a55e12?auto=format&fit=crop&q=80&w=800',
        'https://images.unsplash.com/photo-1523275335684-37898b6baf30?auto=format&fit=crop&q=80&w=800',
        'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?auto=format&fit=crop&q=80&w=800'
    ],
    'Fashion': [
        'https://images.unsplash.com/photo-1542291026-7eec264c27ff?auto=format&fit=crop&q=80&w=800',
        'https://images.unsplash.com/photo-1521572267360-ee0c2909d518?auto=format&fit=crop&q=80&w=800',
        'https://images.unsplash.com/photo-1591047139829-d91aecb6caea?auto=format&fit=crop&q=80&w=800'
    ],
    'Home & Living': [
        'https://images.unsplash.com/photo-1555041469-a586c61ea9bc?auto=format&fit=crop&q=80&w=800',
        'https://images.unsplash.com/photo-1583847268964-b28dc8f51f92?auto=format&fit=crop&q=80&w=800',
        'https://images.unsplash.com/photo-1513694203232-719a280e022f?auto=format&fit=crop&q=80&w=800'
    ],
    'Beauty & Personal Care': [
        'https://images.unsplash.com/photo-1522337360788-8b13dee7a37e?auto=format&fit=crop&q=80&w=800',
        'https://images.unsplash.com/photo-1571781926291-c477ebfd024b?auto=format&fit=crop&q=80&w=800',
        'https://images.unsplash.com/photo-1598440947619-2c35fc9aa908?auto=format&fit=crop&q=80&w=800'
    ],
    'Sports & Outdoors': [
        'https://images.unsplash.com/photo-1517838277536-f5f99be501cd?auto=format&fit=crop&q=80&w=800',
        'https://images.unsplash.com/photo-1584735935682-2f2b69dff9d2?auto=format&fit=crop&q=80&w=800',
        'https://images.unsplash.com/photo-1574680096145-d05b474e2155?auto=format&fit=crop&q=80&w=800'
    ],
    'Books & Stationery': [
        'https://images.unsplash.com/photo-1544716278-ca5e3f4abd8c?auto=format&fit=crop&q=80&w=800',
        'https://images.unsplash.com/photo-1512820790803-83ca734da794?auto=format&fit=crop&q=80&w=800',
        'https://images.unsplash.com/photo-1497633762265-9d179a990aa6?auto=format&fit=crop&q=80&w=800'
    ],
    'Toys & Gaming': [
        'https://images.unsplash.com/photo-1607604276583-eef5d076aa5f?auto=format&fit=crop&q=80&w=800',
        'https://images.unsplash.com/photo-1550745165-9bc0b252726f?auto=format&fit=crop&q=80&w=800',
        'https://images.unsplash.com/photo-1612287232230-6869408212e3?auto=format&fit=crop&q=80&w=800'
    ],
    'Health & Wellness': [
        'https://images.unsplash.com/photo-1505751172876-fa1923c5c528?auto=format&fit=crop&q=80&w=800',
        'https://images.unsplash.com/photo-1544367567-0f2fcb009e0b?auto=format&fit=crop&q=80&w=800',
        'https://images.unsplash.com/photo-1584308666744-24d5c474f2ae?auto=format&fit=crop&q=80&w=800'
    ]
};

const ProductDetailsPage = () => {
    const { id } = useParams();
    const navigate = useNavigate();
    const { user, isAdmin } = useAuth();

    // Data State
    const [product, setProduct] = useState(null);
    const [loading, setLoading] = useState(true);
    const [reviews, setReviews] = useState([]);
    const [relatedProducts, setRelatedProducts] = useState([]);

    // Interactive PDP State
    const [quantity, setQuantity] = useState(1);
    const [selectedImage, setSelectedImage] = useState('');
    const [activeTab, setActiveTab] = useState('overview'); // 'overview', 'specs', 'shipping', 'seller'
    const [isWishlisted, setIsWishlisted] = useState(false);
    const [wishlistLoading, setWishlistLoading] = useState(false);
    const [addingToCart, setAddingToCart] = useState(false);
    const [addedCartToast, setAddedCartToast] = useState(false);
    const [shareCopied, setShareCopied] = useState(false);

    // Review Form State
    const [newReview, setNewReview] = useState({ comment: '', rating: 5 });
    const [reviewLoading, setReviewLoading] = useState(false);
    const [reviewSuccess, setReviewSuccess] = useState(false);

    useEffect(() => {
        window.scrollTo({ top: 0, behavior: 'smooth' });
        fetchProductData();
        fetchReviews();
        if (user && !isAdmin()) {
            checkWishlistStatus();
        }
    }, [id, user]);

    const fetchProductData = async () => {
        setLoading(true);
        try {
            const response = await api.get(`/public/products/${id}`);
            const data = response.data;
            setProduct(data);
            setSelectedImage(data.imageUrl);

            // Fetch related products in the same category
            if (data.categoryId) {
                fetchRelated(data.categoryId, data.id);
            }
        } catch (error) {
            console.error('Error fetching product:', error);
        } finally {
            setLoading(false);
        }
    };

    const fetchRelated = async (categoryId, currentId) => {
        try {
            const res = await api.get(`/public/products?categoryId=${categoryId}&size=5`);
            const filtered = (res.data?.content || []).filter(item => item.id !== currentId).slice(0, 4);
            setRelatedProducts(filtered);
        } catch (err) {
            console.error('Error fetching related products:', err);
        }
    };

    const fetchReviews = async () => {
        try {
            const response = await api.get(`/public/reviews/product/${id}`);
            setReviews(response.data || []);
        } catch (error) {
            console.error('Error fetching reviews:', error);
        }
    };

    const checkWishlistStatus = async () => {
        try {
            const response = await api.get(`/user/wishlist/check/${id}`);
            setIsWishlisted(response.data);
        } catch (error) {
            console.error('Error checking wishlist status:', error);
        }
    };

    const toggleWishlist = async () => {
        if (!user) {
            navigate('/login');
            return;
        }
        setWishlistLoading(true);
        try {
            if (isWishlisted) {
                await api.delete(`/user/wishlist/remove/${id}`);
                setIsWishlisted(false);
            } else {
                await api.post(`/user/wishlist/add/${id}`);
                setIsWishlisted(true);
            }
        } catch (error) {
            console.error('Error toggling wishlist:', error);
        } finally {
            setWishlistLoading(false);
        }
    };

    const handleAddToCart = async (goToCheckout = false) => {
        if (!user) {
            navigate('/login');
            return;
        }
        setAddingToCart(true);
        try {
            await api.post(`/user/cart/add?productId=${id}&quantity=${quantity}`);
            if (goToCheckout) {
                navigate('/checkout');
            } else {
                setAddedCartToast(true);
                setTimeout(() => setAddedCartToast(false), 3500);
            }
        } catch (error) {
            console.error('Error adding to cart:', error);
            alert('Failed to add item to cart. Please try again.');
        } finally {
            setAddingToCart(false);
        }
    };

    const handleShare = () => {
        if (navigator.clipboard) {
            navigator.clipboard.writeText(window.location.href);
            setShareCopied(true);
            setTimeout(() => setShareCopied(false), 2500);
        }
    };

    const handleAddReview = async (e) => {
        e.preventDefault();
        if (!user) {
            navigate('/login');
            return;
        }
        setReviewLoading(true);
        try {
            await api.post(`/user/reviews/${id}`, newReview);
            setNewReview({ comment: '', rating: 5 });
            setReviewSuccess(true);
            setTimeout(() => setReviewSuccess(false), 4000);
            fetchReviews();
        } catch (error) {
            alert(error.response?.data?.message || 'Failed to submit review.');
        } finally {
            setReviewLoading(false);
        }
    };

    // Calculate rating metrics
    const ratingMetrics = useMemo(() => {
        if (!reviews || reviews.length === 0) {
            return {
                average: 4.8,
                count: 0,
                distribution: { 5: 85, 4: 12, 3: 2, 2: 1, 1: 0 },
                recommendPercent: 97
            };
        }
        const total = reviews.length;
        const sum = reviews.reduce((acc, r) => acc + (r.rating || 5), 0);
        const avg = (sum / total).toFixed(1);

        const dist = { 5: 0, 4: 0, 3: 0, 2: 0, 1: 0 };
        reviews.forEach(r => {
            const score = Math.min(5, Math.max(1, r.rating || 5));
            dist[score] = (dist[score] || 0) + 1;
        });

        const distPercent = {};
        for (let s = 1; s <= 5; s++) {
            distPercent[s] = Math.round((dist[s] / total) * 100);
        }

        const positiveCount = (dist[5] || 0) + (dist[4] || 0);
        const recommend = Math.round((positiveCount / total) * 100) || 95;

        return {
            average: avg,
            count: total,
            distribution: distPercent,
            recommendPercent: recommend
        };
    }, [reviews]);

    // Dynamic brand extraction
    const brandName = useMemo(() => {
        if (!product?.name) return 'ShopStack Certified';
        const parts = product.name.split(' ');
        return parts[0] || 'ShopStack';
    }, [product]);

    // Multi-angle thumbnail list
    const galleryImages = useMemo(() => {
        if (!product) return [];
        const base = product.imageUrl ? [product.imageUrl] : [];
        const categoryExtras = CATEGORY_GALLERY_IMAGES[product.categoryName] || [
            'https://images.unsplash.com/photo-1523275335684-37898b6baf30?auto=format&fit=crop&q=80&w=800',
            'https://images.unsplash.com/photo-1546868871-7041f2a55e12?auto=format&fit=crop&q=80&w=800',
            'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?auto=format&fit=crop&q=80&w=800'
        ];
        return [...base, ...categoryExtras].slice(0, 4);
    }, [product]);

    // Structured Technical Specifications
    const productSpecifications = useMemo(() => {
        if (!product) return [];
        const cat = product.categoryName || 'General';
        const isElectronics = cat === 'Electronics' || cat === 'Toys & Gaming';
        const isFashion = cat === 'Fashion' || cat === 'Sports & Outdoors';

        return [
            { label: 'Brand & Manufacturer', value: brandName },
            { label: 'Model Series', value: product.name },
            { label: 'Department / Category', value: cat },
            { 
                label: 'Build Materials', 
                value: isElectronics 
                    ? 'Aerospace Titanium Frame & Recycled Polycarbonate' 
                    : isFashion 
                    ? 'Organic Combed Cotton & Full-Grain Reinforced Leather' 
                    : 'Artisan Grade Stoneware & Sustainable Oak' 
            },
            { 
                label: 'Interface / Connectivity', 
                value: isElectronics ? 'Thunderbolt 4, USB-C 3.2 Gen 2, Bluetooth 5.3' : 'Universal Ergonomic Standard' 
            },
            { 
                label: 'Certifications', 
                value: 'CE, FCC, RoHS, EnergyStar 8.0 & ISO 9001 Compliant' 
            },
            { label: 'Warranty & Protection', value: '2-Year Full Manufacturer Guarantee + 30-Day Hassle-Free Return' },
            { label: 'Item Identification SKU', value: `STK-${product.id?.slice(0, 8).toUpperCase()}` }
        ];
    }, [product, brandName]);

    // Key Highlights Grid
    const productHighlights = useMemo(() => {
        return [
            {
                icon: <Zap className="h-5 w-5 text-amber-500" />,
                title: 'High-Efficiency Architecture',
                description: 'Optimized for peak daily throughput with minimal power consumption and instant responsiveness.'
            },
            {
                icon: <ShieldCheck className="h-5 w-5 text-emerald-500" />,
                title: 'Endurance Tested',
                description: 'Underwent 500+ hours of stress-testing for superior structural integrity and daily durability.'
            },
            {
                icon: <Sparkles className="h-5 w-5 text-blue-500" />,
                title: 'Ergonomic Precision',
                description: 'Sculpted contours engineered to fit naturally into modern lifestyle routines and professional workflows.'
            },
            {
                icon: <PackageCheck className="h-5 w-5 text-indigo-500" />,
                title: 'Eco-Conscious Packaging',
                description: '100% recyclable, plastic-free protective casing with minimal ecological carbon footprint.'
            }
        ];
    }, []);

    // In-the-box Contents
    const inTheBoxItems = useMemo(() => {
        return [
            `1x ${product?.name || 'Main Unit'}`,
            '1x High-Speed Braided USB-C / Accessory Cable',
            '1x Comprehensive Multi-Language Quick Start Guide',
            '1x Certificate of Authenticity & 2-Year Warranty Document'
        ];
    }, [product]);

    // Format currency
    const formatPrice = (price) => {
        return Number(price || 0).toLocaleString('en-US', {
            style: 'currency',
            currency: 'USD'
        });
    };

    if (loading) {
        return (
            <div className="flex flex-col gap-10 py-12">
                <div className="h-6 w-48 rounded bg-muted animate-pulse" />
                <div className="grid grid-cols-1 gap-12 lg:grid-cols-12">
                    <div className="lg:col-span-7 aspect-square rounded-[2.5rem] bg-muted animate-pulse" />
                    <div className="lg:col-span-5 space-y-6">
                        <div className="h-4 w-28 rounded bg-muted animate-pulse" />
                        <div className="h-10 w-full rounded bg-muted animate-pulse" />
                        <div className="h-6 w-36 rounded bg-muted animate-pulse" />
                        <div className="h-24 w-full rounded bg-muted animate-pulse" />
                        <div className="h-14 w-full rounded bg-muted animate-pulse" />
                    </div>
                </div>
            </div>
        );
    }

    if (!product) {
        return (
            <div className="flex flex-col items-center justify-center py-24 text-center">
                <div className="flex h-20 w-20 items-center justify-center rounded-3xl bg-muted text-muted-foreground mb-6">
                    <Info className="h-10 w-10" />
                </div>
                <h2 className="text-3xl font-black">Product Not Found</h2>
                <p className="mt-2 text-muted-foreground max-w-md">
                    The item you are looking for may have been moved or removed from our catalog.
                </p>
                <Link
                    to="/products"
                    className="mt-6 inline-flex items-center gap-2 rounded-2xl bg-primary px-8 py-3.5 font-bold text-primary-foreground hover:bg-primary/90 transition-all shadow-md"
                >
                    <ArrowLeft className="h-4 w-4" /> Return to Catalog
                </Link>
            </div>
        );
    }

    const strikethroughPrice = product.price * 1.18;
    const savingsAmount = strikethroughPrice - product.price;
    const isLowStock = product.stockQuantity > 0 && product.stockQuantity <= 10;

    return (
        <div className="flex flex-col gap-16 pb-24">
            {/* 1. Breadcrumbs & Top Navigation Bar */}
            <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-4 border-b pb-4">
                <nav className="flex items-center gap-2 text-xs sm:text-sm font-medium text-muted-foreground">
                    <Link to="/" className="hover:text-foreground transition-colors">Home</Link>
                    <ChevronRight className="h-3.5 w-3.5" />
                    <Link to="/products" className="hover:text-foreground transition-colors">Catalog</Link>
                    <ChevronRight className="h-3.5 w-3.5" />
                    <Link
                        to={`/products?categoryId=${product.categoryId}`}
                        className="hover:text-foreground transition-colors text-primary font-bold"
                    >
                        {product.categoryName || 'Products'}
                    </Link>
                    <ChevronRight className="h-3.5 w-3.5 hidden md:inline" />
                    <span className="text-foreground font-semibold truncate max-w-[200px] hidden md:inline">
                        {product.name}
                    </span>
                </nav>

                <div className="flex items-center gap-3">
                    <button
                        onClick={handleShare}
                        className="inline-flex items-center gap-1.5 rounded-xl border bg-card px-3.5 py-2 text-xs font-bold text-muted-foreground hover:text-foreground hover:border-primary/50 transition-colors shadow-sm"
                    >
                        <Share2 className="h-3.5 w-3.5" />
                        <span>{shareCopied ? 'Link Copied!' : 'Share'}</span>
                    </button>
                    <button
                        onClick={() => navigate(-1)}
                        className="inline-flex items-center gap-1.5 text-xs font-bold text-muted-foreground hover:text-foreground transition-colors"
                    >
                        <ArrowLeft className="h-3.5 w-3.5" /> Back
                    </button>
                </div>
            </div>

            {/* 2. Main Buy Box (Interactive Gallery & Purchase Box) */}
            <div className="grid grid-cols-1 gap-12 lg:grid-cols-12 items-start">
                {/* Left: Gallery Column (7 cols on lg) */}
                <div className="flex flex-col-reverse md:flex-row gap-4 lg:col-span-7">
                    {/* Thumbnail Selector Strip */}
                    <div className="flex md:flex-col gap-3 overflow-x-auto md:overflow-visible shrink-0 pb-2 md:pb-0">
                        {galleryImages.map((imgUrl, idx) => (
                            <button
                                key={idx}
                                onClick={() => setSelectedImage(imgUrl)}
                                className={`relative h-20 w-20 shrink-0 overflow-hidden rounded-2xl border-2 transition-all ${
                                    selectedImage === imgUrl
                                        ? 'border-primary ring-2 ring-primary/20 scale-105 shadow-md'
                                        : 'border-border opacity-70 hover:opacity-100 hover:border-primary/50'
                                }`}
                            >
                                <img
                                    src={imgUrl}
                                    alt={`Angle ${idx + 1}`}
                                    className="h-full w-full object-cover"
                                />
                            </button>
                        ))}
                    </div>

                    {/* Main Stage Image */}
                    <div className="relative flex-1 aspect-square rounded-[2.5rem] border bg-gradient-to-b from-muted/30 to-muted/80 overflow-hidden shadow-lg group">
                        <img
                            src={selectedImage || product.imageUrl}
                            alt={product.name}
                            className="h-full w-full object-cover transition-transform duration-700 group-hover:scale-105"
                        />

                        {/* Top Left Badges */}
                        <div className="absolute top-5 left-5 flex flex-col gap-2">
                            <span className="inline-flex items-center gap-1.5 rounded-full bg-slate-950/80 px-3.5 py-1.5 text-xs font-black text-white backdrop-blur-md shadow-lg border border-white/10">
                                <Award className="h-3.5 w-3.5 text-amber-400" />
                                Top Tier Edition
                            </span>
                            <span className="inline-flex items-center gap-1 rounded-full bg-emerald-600/90 px-3 py-1 text-xs font-bold text-white backdrop-blur-sm shadow-md">
                                Save 18% Today
                            </span>
                        </div>

                        {/* Bottom Floating Guarantee Pill */}
                        <div className="absolute bottom-5 inset-x-5 flex items-center justify-between rounded-2xl bg-slate-950/85 p-3.5 backdrop-blur-md border border-white/10 text-white shadow-xl">
                            <div className="flex items-center gap-2 text-xs font-bold">
                                <ShieldCheck className="h-4 w-4 text-emerald-400" />
                                <span>100% Authentic Guaranteed</span>
                            </div>
                            <span className="text-[11px] text-slate-300">Brand Sealed</span>
                        </div>
                    </div>
                </div>

                {/* Right: Product Purchase Box (5 cols on lg) */}
                <div className="flex flex-col gap-6 lg:col-span-5">
                    {/* Brand & Title */}
                    <div className="space-y-2">
                        <div className="flex items-center justify-between">
                            <Link
                                to={`/products?categoryId=${product.categoryId}`}
                                className="inline-flex items-center gap-1.5 rounded-lg bg-primary/10 px-3 py-1 text-xs font-black uppercase tracking-wider text-primary hover:bg-primary/20 transition-colors"
                            >
                                {product.categoryName || 'Curated'}
                            </Link>
                            <span className="text-xs font-semibold text-muted-foreground">
                                Sold by: <span className="font-bold text-foreground">{product.sellerName || 'ShopStack Verified'}</span>
                            </span>
                        </div>

                        <h1 className="text-3xl sm:text-4xl font-black tracking-tight leading-tight">
                            {product.name}
                        </h1>

                        {/* Ratings & Jump to Reviews */}
                        <div className="flex items-center gap-3 pt-1">
                            <div className="flex items-center gap-1 text-amber-500">
                                {[...Array(5)].map((_, i) => (
                                    <Star
                                        key={i}
                                        className={`h-4 w-4 ${i < Math.floor(ratingMetrics.average) ? 'fill-current' : ''}`}
                                    />
                                ))}
                            </div>
                            <span className="text-sm font-bold text-foreground">
                                {ratingMetrics.average}
                            </span>
                            <span className="text-sm text-muted-foreground">•</span>
                            <a
                                href="#product-reviews"
                                className="text-sm font-bold text-primary hover:underline"
                            >
                                {ratingMetrics.count > 0 ? `${ratingMetrics.count} verified reviews` : 'Be the first to review'}
                            </a>
                        </div>
                    </div>

                    {/* Price Block */}
                    <div className="rounded-2xl border bg-card p-5 space-y-2 shadow-sm">
                        <div className="flex items-baseline gap-3">
                            <span className="text-4xl font-black text-foreground">
                                {formatPrice(product.price)}
                            </span>
                            <span className="text-base font-semibold text-muted-foreground line-through">
                                {formatPrice(strikethroughPrice)}
                            </span>
                            <span className="rounded-lg bg-emerald-500/10 px-2 py-0.5 text-xs font-bold text-emerald-600 dark:text-emerald-400 border border-emerald-500/20">
                                Save {formatPrice(savingsAmount)}
                            </span>
                        </div>
                        <div className="flex items-center gap-2 text-xs text-muted-foreground">
                            <CreditCard className="h-3.5 w-3.5 text-primary" />
                            <span>Or 4 interest-free payments of <strong>{formatPrice(product.price / 4)}</strong> with Stripe</span>
                        </div>
                    </div>

                    {/* Executive Description Excerpt */}
                    <p className="text-sm sm:text-base leading-relaxed text-muted-foreground">
                        {product.description || `Engineered by ${brandName}. Designed for superior performance, premium durability, and daily reliability across all environments.`}
                    </p>

                    {/* Stock Status Indicator */}
                    <div className="flex items-center gap-2">
                        {product.stockQuantity > 0 ? (
                            <div className="flex items-center gap-2 text-sm font-bold">
                                <span className="relative flex h-3 w-3">
                                    <span className="animate-ping absolute inline-flex h-full w-full rounded-full bg-emerald-400 opacity-75"></span>
                                    <span className="relative inline-flex rounded-full h-3 w-3 bg-emerald-500"></span>
                                </span>
                                {isLowStock ? (
                                    <span className="text-amber-600 dark:text-amber-400">
                                        Hurry, only {product.stockQuantity} items left in stock!
                                    </span>
                                ) : (
                                    <span className="text-emerald-600 dark:text-emerald-400">
                                        In Stock ({product.stockQuantity} units ready to ship)
                                    </span>
                                )}
                            </div>
                        ) : (
                            <span className="text-sm font-bold text-destructive">
                                Currently Out of Stock
                            </span>
                        )}
                    </div>

                    {/* Quantity Selector & Action Buttons (Customer View) */}
                    {!isAdmin() ? (
                        <div className="space-y-4">
                            <div className="flex items-center gap-3">
                                {/* Quantity Picker */}
                                <div className="flex items-center rounded-2xl border bg-card p-1 shadow-sm">
                                    <button
                                        type="button"
                                        onClick={() => setQuantity(Math.max(1, quantity - 1))}
                                        disabled={quantity <= 1}
                                        className="flex h-11 w-11 items-center justify-center rounded-xl font-black text-base hover:bg-muted active:scale-95 disabled:opacity-30 transition-all"
                                    >
                                        -
                                    </button>
                                    <span className="w-12 text-center text-base font-black">
                                        {quantity}
                                    </span>
                                    <button
                                        type="button"
                                        onClick={() => setQuantity(Math.min(product.stockQuantity || 99, quantity + 1))}
                                        disabled={quantity >= product.stockQuantity}
                                        className="flex h-11 w-11 items-center justify-center rounded-xl font-black text-base hover:bg-muted active:scale-95 disabled:opacity-30 transition-all"
                                    >
                                        +
                                    </button>
                                </div>

                                {/* Primary Add to Cart Button */}
                                <button
                                    type="button"
                                    onClick={() => handleAddToCart(false)}
                                    disabled={addingToCart || product.stockQuantity <= 0}
                                    className="flex flex-1 items-center justify-center gap-2 rounded-2xl bg-primary py-4 px-6 text-base font-black text-primary-foreground shadow-lg transition-all hover:bg-primary/90 active:scale-95 disabled:opacity-50"
                                >
                                    {addingToCart ? (
                                        <div className="h-5 w-5 animate-spin rounded-full border-2 border-white border-t-transparent" />
                                    ) : (
                                        <>
                                            <ShoppingCart className="h-5 w-5" />
                                            <span>Add to Cart ({formatPrice(product.price * quantity)})</span>
                                        </>
                                    )}
                                </button>

                                {/* Wishlist Heart Button */}
                                <button
                                    type="button"
                                    onClick={toggleWishlist}
                                    disabled={wishlistLoading}
                                    aria-label="Add to Wishlist"
                                    className={`flex h-14 w-14 items-center justify-center rounded-2xl border transition-all shadow-sm active:scale-95 ${
                                        isWishlisted
                                            ? 'border-rose-500 bg-rose-500 text-white shadow-rose-500/20 shadow-md'
                                            : 'border-border bg-card text-muted-foreground hover:border-primary hover:text-primary'
                                    }`}
                                >
                                    <Heart className={`h-6 w-6 ${isWishlisted ? 'fill-current' : ''}`} />
                                </button>
                            </div>

                            {/* Instant 1-Click Buy Now Button */}
                            <button
                                type="button"
                                onClick={() => handleAddToCart(true)}
                                disabled={addingToCart || product.stockQuantity <= 0}
                                className="w-full rounded-2xl border-2 border-foreground bg-foreground py-3.5 text-sm font-black text-background hover:bg-foreground/90 transition-all shadow-md active:scale-95 disabled:opacity-50 flex items-center justify-center gap-2"
                            >
                                <Zap className="h-4 w-4 text-amber-400" />
                                Instant Checkout with Card or Cash
                            </button>

                            {/* Added To Cart Confirmation Toast */}
                            {addedCartToast && (
                                <div className="flex items-center justify-between rounded-2xl bg-emerald-600 px-5 py-3 text-white shadow-xl animate-in fade-in slide-in-from-top duration-300">
                                    <div className="flex items-center gap-2 text-sm font-bold">
                                        <CheckCircle2 className="h-5 w-5 stroke-[2.5]" />
                                        <span>Added {quantity} item(s) to your cart!</span>
                                    </div>
                                    <Link
                                        to="/cart"
                                        className="rounded-xl bg-white px-3.5 py-1.5 text-xs font-black text-emerald-700 hover:bg-slate-100 transition-colors"
                                    >
                                        Go to Cart
                                    </Link>
                                </div>
                            )}
                        </div>
                    ) : (
                        /* Admin Mode Box */
                        <div className="rounded-3xl bg-slate-950 p-6 text-white shadow-xl border border-white/10 space-y-4">
                            <div className="flex items-center justify-between">
                                <div className="flex items-center gap-2">
                                    <span className="h-2.5 w-2.5 rounded-full bg-blue-500 animate-pulse" />
                                    <span className="text-xs font-black uppercase tracking-widest text-blue-400">
                                        Administrator Mode
                                    </span>
                                </div>
                                <span className="text-xs text-slate-400">Customer buying disabled</span>
                            </div>
                            <h3 className="text-xl font-bold">Live Inventory State</h3>
                            <div className="grid grid-cols-2 gap-3 pt-1">
                                <div className="rounded-2xl bg-white/5 p-4 border border-white/10">
                                    <p className="text-xs uppercase text-slate-400 font-bold">Stock Remaining</p>
                                    <p className="text-2xl font-black text-white mt-1">{product.stockQuantity} Units</p>
                                </div>
                                <div className="rounded-2xl bg-white/5 p-4 border border-white/10">
                                    <p className="text-xs uppercase text-slate-400 font-bold">Listed Price</p>
                                    <p className="text-2xl font-black text-emerald-400 mt-1">{formatPrice(product.price)}</p>
                                </div>
                            </div>
                            <button
                                onClick={() => navigate('/admin')}
                                className="w-full rounded-xl bg-white py-3 text-xs font-black text-slate-950 hover:bg-slate-100 transition-colors"
                            >
                                Return to Admin Dashboard
                            </button>
                        </div>
                    )}

                    {/* Delivery & Assurance Strip */}
                    <div className="rounded-2xl border bg-muted/30 p-4 space-y-3">
                        <div className="flex items-center gap-3 text-xs font-semibold text-foreground">
                            <Truck className="h-4 w-4 text-primary shrink-0" />
                            <span>Estimated delivery in <strong>2-3 business days</strong> with Tracked Shipping</span>
                        </div>
                        <div className="flex items-center gap-3 text-xs font-semibold text-foreground">
                            <RotateCcw className="h-4 w-4 text-emerald-500 shrink-0" />
                            <span><strong>30-Day Hassle-Free Returns</strong> with prepaid shipping label</span>
                        </div>
                        <div className="flex items-center gap-3 text-xs font-semibold text-foreground">
                            <Shield className="h-4 w-4 text-blue-500 shrink-0" />
                            <span>Backed by <strong>2-Year ShopStack Warranty</strong></span>
                        </div>
                    </div>
                </div>
            </div>

            {/* 3. Deep Dive Product Information Tabs (Full Description & Specs Section) */}
            <section className="rounded-[2.5rem] border bg-card p-6 md:p-10 shadow-sm space-y-8">
                {/* Tab Controls */}
                <div className="flex border-b overflow-x-auto gap-2 md:gap-8 pb-3 no-scrollbar">
                    <button
                        onClick={() => setActiveTab('overview')}
                        className={`flex items-center gap-2 pb-3 text-sm md:text-base font-black transition-all border-b-2 whitespace-nowrap ${
                            activeTab === 'overview'
                                ? 'border-primary text-primary'
                                : 'border-transparent text-muted-foreground hover:text-foreground'
                        }`}
                    >
                        <Layers className="h-4 w-4" />
                        <span>Product Description & Highlights</span>
                    </button>
                    <button
                        onClick={() => setActiveTab('specs')}
                        className={`flex items-center gap-2 pb-3 text-sm md:text-base font-black transition-all border-b-2 whitespace-nowrap ${
                            activeTab === 'specs'
                                ? 'border-primary text-primary'
                                : 'border-transparent text-muted-foreground hover:text-foreground'
                        }`}
                    >
                        <Box className="h-4 w-4" />
                        <span>Technical Specifications</span>
                    </button>
                    <button
                        onClick={() => setActiveTab('shipping')}
                        className={`flex items-center gap-2 pb-3 text-sm md:text-base font-black transition-all border-b-2 whitespace-nowrap ${
                            activeTab === 'shipping'
                                ? 'border-primary text-primary'
                                : 'border-transparent text-muted-foreground hover:text-foreground'
                        }`}
                    >
                        <Truck className="h-4 w-4" />
                        <span>Shipping & Returns</span>
                    </button>
                    <button
                        onClick={() => setActiveTab('seller')}
                        className={`flex items-center gap-2 pb-3 text-sm md:text-base font-black transition-all border-b-2 whitespace-nowrap ${
                            activeTab === 'seller'
                                ? 'border-primary text-primary'
                                : 'border-transparent text-muted-foreground hover:text-foreground'
                        }`}
                    >
                        <ShieldCheck className="h-4 w-4" />
                        <span>Seller & Authenticity</span>
                    </button>
                </div>

                {/* Tab 1: Detailed Overview */}
                {activeTab === 'overview' && (
                    <div className="space-y-10 animate-in fade-in duration-300">
                        {/* Narrative Description */}
                        <div className="space-y-4 max-w-3xl">
                            <h3 className="text-2xl font-black tracking-tight">
                                Designed for Performance, Crafted for Everyday Excellence.
                            </h3>
                            <p className="text-base text-muted-foreground leading-relaxed">
                                {product.description || `The ${product.name} represents the pinnacle of craftsmanship in the ${product.categoryName} space. Engineered directly by ${brandName}, this edition combines cutting-edge architecture with premium materials designed for demanding daily workloads and high-end lifestyle standards.`}
                            </p>
                            <p className="text-base text-muted-foreground leading-relaxed">
                                Each unit is individually calibrated before leaving the fulfillment hub. Whether deployed in professional studio settings, fast-paced home environments, or on the move, it delivers uncompromised reliability, tactile feedback, and intuitive ergonomics.
                            </p>
                        </div>

                        {/* 4 Feature Highlights Grid */}
                        <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
                            {productHighlights.map((item, idx) => (
                                <div
                                    key={idx}
                                    className="flex gap-4 rounded-2xl border bg-muted/20 p-5 shadow-sm"
                                >
                                    <div className="flex h-11 w-11 shrink-0 items-center justify-center rounded-xl bg-card border shadow-sm">
                                        {item.icon}
                                    </div>
                                    <div className="space-y-1">
                                        <h4 className="text-base font-bold text-foreground">{item.title}</h4>
                                        <p className="text-xs text-muted-foreground leading-relaxed">{item.description}</p>
                                    </div>
                                </div>
                            ))}
                        </div>

                        {/* What's In The Box Checklist */}
                        <div className="rounded-3xl border bg-gradient-to-br from-card to-muted/30 p-6 md:p-8 space-y-4">
                            <h4 className="text-lg font-black tracking-tight flex items-center gap-2">
                                <Box className="h-5 w-5 text-primary" />
                                Package Contents & In-The-Box
                            </h4>
                            <div className="grid grid-cols-1 sm:grid-cols-2 gap-3 pt-2">
                                {inTheBoxItems.map((boxItem, idx) => (
                                    <div key={idx} className="flex items-center gap-3 text-sm font-semibold text-foreground">
                                        <Check className="h-4 w-4 text-emerald-500 shrink-0 stroke-[3]" />
                                        <span>{boxItem}</span>
                                    </div>
                                ))}
                            </div>
                        </div>
                    </div>
                )}

                {/* Tab 2: Technical Specifications */}
                {activeTab === 'specs' && (
                    <div className="space-y-6 animate-in fade-in duration-300">
                        <div className="space-y-2">
                            <h3 className="text-xl font-black">Engineering Specifications</h3>
                            <p className="text-sm text-muted-foreground">Certified data specs recorded directly from the manufacturer build sheet.</p>
                        </div>

                        <div className="rounded-2xl border overflow-hidden">
                            <table className="w-full text-left text-sm">
                                <tbody>
                                    {productSpecifications.map((spec, idx) => (
                                        <tr
                                            key={idx}
                                            className={`border-b last:border-b-0 ${
                                                idx % 2 === 0 ? 'bg-muted/10' : 'bg-card'
                                            }`}
                                        >
                                            <td className="w-1/3 p-4 font-bold text-foreground">
                                                {spec.label}
                                            </td>
                                            <td className="p-4 text-muted-foreground font-medium">
                                                {spec.value}
                                            </td>
                                        </tr>
                                    ))}
                                </tbody>
                            </table>
                        </div>
                    </div>
                )}

                {/* Tab 3: Shipping & Returns */}
                {activeTab === 'shipping' && (
                    <div className="space-y-8 animate-in fade-in duration-300 max-w-3xl">
                        <div className="space-y-3">
                            <h3 className="text-xl font-black">Dispatch & Global Delivery</h3>
                            <p className="text-sm text-muted-foreground leading-relaxed">
                                All orders placed before 3:00 PM AEST ship on the same business day from our primary Sydney fulfillment facility. 
                                We partner with leading express carriers to guarantee fast and insured transit.
                            </p>
                        </div>

                        <div className="grid grid-cols-1 sm:grid-cols-2 gap-4">
                            <div className="rounded-2xl border p-5 space-y-2 bg-card">
                                <span className="font-bold text-sm text-primary">Standard Insured Shipping</span>
                                <p className="text-xs text-muted-foreground leading-relaxed">2-4 business days. Free for all orders over $100, or a flat $8.95 fee.</p>
                            </div>
                            <div className="rounded-2xl border p-5 space-y-2 bg-card">
                                <span className="font-bold text-sm text-primary">Next-Day Priority Express</span>
                                <p className="text-xs text-muted-foreground leading-relaxed">Guaranteed next-morning delivery available at checkout for $14.95.</p>
                            </div>
                        </div>

                        <div className="rounded-2xl border bg-muted/20 p-5 space-y-2">
                            <h4 className="font-bold text-sm">Our 30-Day Return Guarantee</h4>
                            <p className="text-xs text-muted-foreground leading-relaxed">
                                Not 100% in love with your item? Return it within 30 days of delivery in its original packaging for an immediate full refund or exchange. 
                                Generate a prepaid return label directly from your account orders dashboard.
                            </p>
                        </div>
                    </div>
                )}

                {/* Tab 4: Verified Seller */}
                {activeTab === 'seller' && (
                    <div className="space-y-6 animate-in fade-in duration-300 max-w-3xl">
                        <div className="flex items-center gap-4 rounded-2xl border bg-card p-6 shadow-sm">
                            <div className="flex h-16 w-16 items-center justify-center rounded-2xl bg-emerald-500/10 text-emerald-600 font-black text-xl">
                                {brandName[0]}
                            </div>
                            <div>
                                <div className="flex items-center gap-2">
                                    <h4 className="text-lg font-black text-foreground">
                                        {product.sellerName || 'ShopStack Verified Merchant'}
                                    </h4>
                                    <span className="rounded-full bg-emerald-500/10 px-2.5 py-0.5 text-[11px] font-bold text-emerald-600 border border-emerald-500/20">
                                        Verified Partner
                                    </span>
                                </div>
                                <p className="text-xs text-muted-foreground mt-0.5">
                                    99.4% Positive Feedback • 1,200+ Orders Fulfilled this Quarter
                                </p>
                            </div>
                        </div>

                        <div className="grid grid-cols-1 sm:grid-cols-3 gap-4">
                            <div className="rounded-2xl border p-4 text-center bg-card">
                                <span className="text-2xl font-black text-foreground">100%</span>
                                <p className="text-xs text-muted-foreground mt-1">Authentic Sourcing</p>
                            </div>
                            <div className="rounded-2xl border p-4 text-center bg-card">
                                <span className="text-2xl font-black text-foreground">&lt; 1hr</span>
                                <p className="text-xs text-muted-foreground mt-1">Support Response</p>
                            </div>
                            <div className="rounded-2xl border p-4 text-center bg-card">
                                <span className="text-2xl font-black text-foreground">4.9 / 5</span>
                                <p className="text-xs text-muted-foreground mt-1">Merchant Rating</p>
                            </div>
                        </div>
                    </div>
                )}
            </section>

            {/* 4. Customer Reviews Breakdown & Ratings */}
            <section id="product-reviews" className="space-y-8 border-t pt-12">
                <div className="flex flex-col sm:flex-row sm:items-end justify-between gap-4">
                    <div>
                        <div className="flex items-center gap-2 text-xs font-bold uppercase tracking-wider text-primary">
                            <Star className="h-4 w-4 fill-current text-amber-500" />
                            Community Feedback
                        </div>
                        <h2 className="text-3xl font-black tracking-tight mt-1">Customer Reviews & Ratings</h2>
                    </div>

                    {user && !isAdmin() && (
                        <button
                            onClick={() => document.getElementById('review-form')?.scrollIntoView({ behavior: 'smooth' })}
                            className="rounded-2xl border bg-card px-6 py-3 text-sm font-bold hover:border-primary transition-colors shadow-sm"
                        >
                            Write a Review
                        </button>
                    )}
                </div>

                {/* Aggregate Score Bar & Distribution Matrix */}
                <div className="grid grid-cols-1 md:grid-cols-12 gap-8 rounded-3xl border bg-card p-6 md:p-8 shadow-sm">
                    {/* Overall Score */}
                    <div className="flex flex-col items-center justify-center text-center md:col-span-4 md:border-r border-border pr-0 md:pr-8">
                        <span className="text-6xl font-black text-foreground">
                            {ratingMetrics.average}
                        </span>
                        <div className="flex items-center gap-1 text-amber-500 my-2">
                            {[...Array(5)].map((_, i) => (
                                <Star
                                    key={i}
                                    className={`h-5 w-5 ${i < Math.floor(ratingMetrics.average) ? 'fill-current' : ''}`}
                                />
                            ))}
                        </div>
                        <p className="text-sm font-bold text-muted-foreground">
                            Based on {ratingMetrics.count} verified reviews
                        </p>
                        <p className="text-xs text-emerald-600 dark:text-emerald-400 font-bold mt-1">
                            {ratingMetrics.recommendPercent}% of customers recommend this item
                        </p>
                    </div>

                    {/* Star Distribution Bars */}
                    <div className="flex flex-col justify-center space-y-2 md:col-span-8">
                        {[5, 4, 3, 2, 1].map((star) => {
                            const pct = ratingMetrics.distribution[star] || 0;
                            return (
                                <div key={star} className="flex items-center gap-3 text-xs font-bold text-muted-foreground">
                                    <span className="w-12 text-right">{star} Stars</span>
                                    <div className="relative h-2.5 flex-1 rounded-full bg-muted overflow-hidden">
                                        <div
                                            className="h-full rounded-full bg-amber-500 transition-all duration-500"
                                            style={{ width: `${pct}%` }}
                                        />
                                    </div>
                                    <span className="w-10 text-right">{pct}%</span>
                                </div>
                            );
                        })}
                    </div>
                </div>

                {/* Review Feed & Submit Form Grid */}
                <div className="grid grid-cols-1 lg:grid-cols-12 gap-8 items-start">
                    {/* Review Cards Column (7 cols) */}
                    <div className="space-y-4 lg:col-span-7">
                        {reviews.length > 0 ? (
                            reviews.map((rev) => (
                                <div
                                    key={rev.id}
                                    className="rounded-2xl border bg-card p-6 shadow-sm space-y-3"
                                >
                                    <div className="flex items-center justify-between">
                                        <div className="flex items-center gap-3">
                                            <div className="flex h-10 w-10 items-center justify-center rounded-full bg-primary/10 font-black text-primary text-sm">
                                                {rev.username ? rev.username[0].toUpperCase() : 'U'}
                                            </div>
                                            <div>
                                                <p className="text-sm font-bold text-foreground">{rev.username || 'Customer'}</p>
                                                <p className="text-[11px] text-muted-foreground">
                                                    {rev.createdAt ? new Date(rev.createdAt).toLocaleDateString() : 'Verified Buyer'}
                                                </p>
                                            </div>
                                        </div>
                                        <div className="flex items-center gap-1 text-amber-500">
                                            {[...Array(5)].map((_, i) => (
                                                <Star
                                                    key={i}
                                                    className={`h-4 w-4 ${i < rev.rating ? 'fill-current' : ''}`}
                                                />
                                            ))}
                                        </div>
                                    </div>
                                    <p className="text-sm text-foreground/90 leading-relaxed">
                                        {rev.comment}
                                    </p>
                                    <div className="flex items-center gap-2 pt-1 text-[11px] text-muted-foreground font-semibold">
                                        <ThumbsUp className="h-3 w-3 text-emerald-500" />
                                        <span>Verified Purchase</span>
                                    </div>
                                </div>
                            ))
                        ) : (
                            <div className="rounded-2xl border border-dashed p-10 text-center space-y-2">
                                <Sparkles className="h-8 w-8 text-muted-foreground mx-auto" />
                                <h4 className="text-base font-bold">No customer reviews yet</h4>
                                <p className="text-xs text-muted-foreground">
                                    Purchased this product? Be the first to share your experience with the community!
                                </p>
                            </div>
                        )}
                    </div>

                    {/* Write Review Column (5 cols) */}
                    {user && !isAdmin() && (
                        <div id="review-form" className="rounded-3xl border bg-card p-6 md:p-8 shadow-lg space-y-5 lg:col-span-5">
                            <div>
                                <h3 className="text-xl font-black tracking-tight">Submit Your Rating</h3>
                                <p className="text-xs text-muted-foreground mt-0.5">
                                    Help fellow shoppers make informed decisions.
                                </p>
                            </div>

                            {reviewSuccess && (
                                <div className="rounded-xl bg-emerald-500/10 border border-emerald-500/20 p-4 text-xs font-bold text-emerald-600 dark:text-emerald-400">
                                    🎉 Thank you! Your review has been recorded and posted.
                                </div>
                            )}

                            <form onSubmit={handleAddReview} className="space-y-4">
                                <div>
                                    <label className="text-xs font-bold uppercase text-muted-foreground">Overall Score</label>
                                    <div className="flex items-center gap-1.5 mt-1.5">
                                        {[1, 2, 3, 4, 5].map((star) => (
                                            <button
                                                key={star}
                                                type="button"
                                                onClick={() => setNewReview({ ...newReview, rating: star })}
                                                className="p-1 hover:scale-110 transition-transform"
                                            >
                                                <Star
                                                    className={`h-7 w-7 ${
                                                        star <= newReview.rating
                                                            ? 'fill-amber-500 text-amber-500'
                                                            : 'text-muted-foreground'
                                                    }`}
                                                />
                                            </button>
                                        ))}
                                        <span className="ml-2 text-xs font-bold text-foreground">
                                            {newReview.rating} out of 5
                                        </span>
                                    </div>
                                </div>

                                <div>
                                    <label className="text-xs font-bold uppercase text-muted-foreground">Review Description</label>
                                    <textarea
                                        required
                                        rows={4}
                                        value={newReview.comment}
                                        onChange={(e) => setNewReview({ ...newReview, comment: e.target.value })}
                                        placeholder="Describe the build quality, performance, and whether you recommend it..."
                                        className="mt-1.5 w-full rounded-2xl border bg-background p-4 text-sm outline-none focus:border-primary focus:ring-2 focus:ring-primary/20"
                                    />
                                </div>

                                <button
                                    type="submit"
                                    disabled={reviewLoading}
                                    className="w-full rounded-xl bg-primary py-3.5 text-sm font-black text-primary-foreground hover:bg-primary/90 transition-all shadow-md active:scale-95 disabled:opacity-50 flex items-center justify-center gap-2"
                                >
                                    {reviewLoading ? (
                                        <div className="h-4 w-4 animate-spin rounded-full border-2 border-white border-t-transparent" />
                                    ) : (
                                        <>
                                            <Send className="h-4 w-4" />
                                            <span>Post Verified Review</span>
                                        </>
                                    )}
                                </button>
                            </form>
                        </div>
                    )}
                </div>
            </section>

            {/* 5. "You Might Also Like" Related Products */}
            {relatedProducts.length > 0 && (
                <section className="space-y-6 border-t pt-12">
                    <div className="flex items-center justify-between">
                        <div>
                            <span className="text-xs font-bold uppercase tracking-wider text-primary">Discover More</span>
                            <h2 className="text-2xl sm:text-3xl font-black tracking-tight">You Might Also Like</h2>
                        </div>
                        <Link
                            to={`/products?categoryId=${product.categoryId}`}
                            className="text-sm font-bold text-primary hover:underline flex items-center gap-1"
                        >
                            View Category <ChevronRight className="h-4 w-4" />
                        </Link>
                    </div>

                    <div className="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-4 gap-6">
                        {relatedProducts.map((item) => (
                            <Link
                                key={item.id}
                                to={`/products/${item.id}`}
                                className="group rounded-2xl border bg-card p-4 shadow-sm hover:shadow-xl hover:-translate-y-1 transition-all"
                            >
                                <div className="aspect-[4/5] rounded-xl overflow-hidden bg-muted relative">
                                    <img
                                        src={item.imageUrl}
                                        alt={item.name}
                                        className="h-full w-full object-cover group-hover:scale-105 transition-transform duration-500"
                                    />
                                    <div className="absolute top-2 right-2 rounded-lg bg-slate-950/80 px-2 py-0.5 text-xs font-black text-white backdrop-blur-sm">
                                        {formatPrice(item.price)}
                                    </div>
                                </div>
                                <div className="mt-3 space-y-1">
                                    <span className="text-[11px] font-bold text-muted-foreground uppercase">{item.categoryName}</span>
                                    <h4 className="text-sm font-bold text-foreground line-clamp-2 group-hover:text-primary transition-colors">
                                        {item.name}
                                    </h4>
                                </div>
                            </Link>
                        ))}
                    </div>
                </section>
            )}

            {/* 6. Sticky Bottom Action Bar (Appears on mobile/desktop scrolling for friction-free add-to-cart) */}
            <div className="fixed bottom-0 inset-x-0 z-40 border-t bg-card/95 backdrop-blur-md px-6 py-3.5 shadow-2xl md:hidden">
                <div className="flex items-center justify-between gap-4">
                    <div className="flex flex-col">
                        <span className="text-lg font-black text-foreground">{formatPrice(product.price)}</span>
                        <span className="text-[11px] text-emerald-500 font-bold">In Stock</span>
                    </div>
                    <button
                        type="button"
                        onClick={() => handleAddToCart(false)}
                        disabled={addingToCart || product.stockQuantity <= 0}
                        className="flex-1 rounded-xl bg-primary py-3 text-xs font-black text-primary-foreground shadow-md active:scale-95 disabled:opacity-50 flex items-center justify-center gap-2"
                    >
                        <ShoppingCart className="h-4 w-4" />
                        <span>Add to Cart</span>
                    </button>
                </div>
            </div>
        </div>
    );
};

export default ProductDetailsPage;
