import React, { useState, useEffect } from 'react';
import { Link, useNavigate } from 'react-router-dom';
import api from '../api/axios';
import { useAuth } from '../context/AuthContext';
import {
    ShoppingBag,
    ArrowRight,
    Star,
    Truck,
    ShieldCheck,
    Zap,
    LayoutGrid,
    Flame,
    Sparkles,
    Search,
    Heart,
    Check,
    Clock,
    RefreshCw,
    Award,
    Headphones,
    Store,
    Laptop,
    Shirt,
    Home,
    Dumbbell,
    BookOpen,
    Gamepad2,
    HeartPulse,
    Tag,
    ChevronRight,
    X
} from 'lucide-react';

const CATEGORY_ICON_MAP = {
    'Electronics': Laptop,
    'Fashion': Shirt,
    'Home & Living': Home,
    'Beauty & Personal Care': Sparkles,
    'Sports & Outdoors': Dumbbell,
    'Books & Stationery': BookOpen,
    'Toys & Gaming': Gamepad2,
    'Health & Wellness': HeartPulse,
};

const POPULAR_SEARCHES = ['AirPods', 'Sneakers', 'Espresso', 'Gaming', 'Desk Chair', 'Yoga Mat'];

const UserHomePage = () => {
    const { user } = useAuth();
    const navigate = useNavigate();

    // State
    const [products, setProducts] = useState([]);
    const [categories, setCategories] = useState([]);
    const [selectedCategory, setSelectedCategory] = useState(null);
    const [activeFilter, setActiveFilter] = useState('all'); // 'all', 'under100', 'topRated', 'inStock'
    const [loading, setLoading] = useState(true);
    const [loadingProducts, setLoadingProducts] = useState(false);
    const [heroSearch, setHeroSearch] = useState('');

    // Cart and Wishlist interactive states
    const [addingToCart, setAddingToCart] = useState({});
    const [addedSuccess, setAddedSuccess] = useState({});
    const [wishlistMap, setWishlistMap] = useState({});
    const [wishlistLoading, setWishlistLoading] = useState({});

    // Flash deal countdown timer
    const [timeLeft, setTimeLeft] = useState({ hours: 7, minutes: 24, seconds: 48 });

    // Newsletter state
    const [newsletterEmail, setNewsletterEmail] = useState('');
    const [newsletterSuccess, setNewsletterSuccess] = useState(false);

    useEffect(() => {
        fetchInitialData();
        if (user) {
            fetchWishlistStatus();
        }
    }, [user]);

    useEffect(() => {
        fetchProductsByCategory(selectedCategory);
    }, [selectedCategory]);

    // Countdown effect
    useEffect(() => {
        const timer = setInterval(() => {
            setTimeLeft(prev => {
                if (prev.seconds > 0) return { ...prev, seconds: prev.seconds - 1 };
                if (prev.minutes > 0) return { ...prev, minutes: 59, seconds: 59 };
                if (prev.hours > 0) return { hours: prev.hours - 1, minutes: 59, seconds: 59 };
                return { hours: 12, minutes: 0, seconds: 0 };
            });
        }, 1000);
        return () => clearInterval(timer);
    }, []);

    const fetchInitialData = async () => {
        setLoading(true);
        try {
            const [prodRes, catRes] = await Promise.all([
                api.get('/public/products?page=0&size=12'),
                api.get('/public/categories')
            ]);
            setProducts(prodRes.data?.content || []);
            setCategories(catRes.data || []);
        } catch (error) {
            console.error('Error fetching home data:', error);
        } finally {
            setLoading(false);
        }
    };

    const fetchProductsByCategory = async (catId) => {
        setLoadingProducts(true);
        try {
            let url = '/public/products?page=0&size=12';
            if (catId) {
                url += `&categoryId=${catId}`;
            }
            const res = await api.get(url);
            setProducts(res.data?.content || []);
        } catch (error) {
            console.error('Error filtering products:', error);
        } finally {
            setLoadingProducts(false);
        }
    };

    const fetchWishlistStatus = async () => {
        try {
            const res = await api.get('/user/wishlist');
            if (Array.isArray(res.data)) {
                const map = {};
                res.data.forEach(item => {
                    map[item.id] = true;
                });
                setWishlistMap(map);
            }
        } catch (err) {
            // Ignore wishlist error for unauthenticated/unseeded
        }
    };

    const handleHeroSearchSubmit = (e) => {
        e.preventDefault();
        if (heroSearch.trim()) {
            navigate(`/products?name=${encodeURIComponent(heroSearch.trim())}`);
        } else {
            navigate('/products');
        }
    };

    const handleAddToCart = async (e, product) => {
        e.preventDefault();
        e.stopPropagation();

        if (!user) {
            navigate('/login');
            return;
        }

        const pid = product.id;
        setAddingToCart(prev => ({ ...prev, [pid]: true }));

        try {
            await api.post(`/user/cart/add?productId=${pid}&quantity=1`);
            setAddedSuccess(prev => ({ ...prev, [pid]: true }));
            setTimeout(() => {
                setAddedSuccess(prev => ({ ...prev, [pid]: false }));
            }, 2500);
        } catch (error) {
            console.error('Failed to add to cart:', error);
            alert('Could not add product to cart. Please check your connection.');
        } finally {
            setAddingToCart(prev => ({ ...prev, [pid]: false }));
        }
    };

    const handleToggleWishlist = async (e, product) => {
        e.preventDefault();
        e.stopPropagation();

        if (!user) {
            navigate('/login');
            return;
        }

        const pid = product.id;
        const isFav = !!wishlistMap[pid];
        setWishlistLoading(prev => ({ ...prev, [pid]: true }));

        try {
            if (isFav) {
                await api.delete(`/user/wishlist/remove/${pid}`);
                setWishlistMap(prev => ({ ...prev, [pid]: false }));
            } else {
                await api.post(`/user/wishlist/add/${pid}`);
                setWishlistMap(prev => ({ ...prev, [pid]: true }));
            }
        } catch (err) {
            console.error('Wishlist toggle error:', err);
        } finally {
            setWishlistLoading(prev => ({ ...prev, [pid]: false }));
        }
    };

    const handleNewsletterSubmit = (e) => {
        e.preventDefault();
        if (newsletterEmail.trim()) {
            setNewsletterSuccess(true);
            setNewsletterEmail('');
        }
    };

    // Filter products by secondary active filter
    const displayedProducts = products.filter(product => {
        if (activeFilter === 'under100') return product.price < 100;
        if (activeFilter === 'inStock') return product.stockQuantity > 0;
        if (activeFilter === 'topRated') return product.price >= 80; // Proxy for premium
        return true;
    });

    const formatPrice = (price) => {
        return Number(price || 0).toLocaleString('en-US', {
            style: 'currency',
            currency: 'USD'
        });
    };

    return (
        <div className="flex flex-col gap-20 pb-20">
            {/* Top Announcement Bar */}
            <div className="flex items-center justify-between rounded-2xl bg-gradient-to-r from-blue-600 via-indigo-600 to-emerald-600 px-6 py-3 text-white shadow-md">
                <div className="flex items-center gap-2 text-xs font-bold md:text-sm">
                    <Sparkles className="h-4 w-4 animate-spin text-yellow-300" />
                    <span>FLASH PROMOTION: Use code <span className="underline decoration-yellow-300 decoration-2 font-black">STACK15</span> for 15% off all orders over $100!</span>
                </div>
                <Link to="/products" className="hidden sm:inline-flex items-center gap-1 text-xs font-bold text-white hover:underline">
                    Explore Drops <ArrowRight className="h-3.5 w-3.5" />
                </Link>
            </div>

            {/* 1. Hero Section */}
            <section className="relative overflow-hidden rounded-[2.5rem] bg-slate-950 px-6 py-16 text-white md:px-16 lg:py-20 shadow-2xl">
                <div className="relative z-10 grid grid-cols-1 items-center gap-12 lg:grid-cols-12">
                    {/* Left Hero Column */}
                    <div className="flex flex-col gap-7 lg:col-span-7">
                        <div className="inline-flex w-fit items-center gap-2 rounded-full border border-white/10 bg-white/5 px-4 py-1.5 text-xs font-semibold backdrop-blur-md">
                            <Flame className="h-4 w-4 text-orange-400" />
                            <span>1,000+ Verified Products • New Season Catalog</span>
                        </div>

                        <h1 className="text-4xl font-black tracking-tight sm:text-5xl md:text-6xl lg:text-7xl leading-[1.08]">
                            Smart Shopping, <br />
                            <span className="bg-gradient-to-r from-blue-400 via-indigo-300 to-emerald-400 bg-clip-text text-transparent">
                                Elevated For You.
                            </span>
                        </h1>

                        <p className="max-w-xl text-base text-slate-300 sm:text-lg leading-relaxed">
                            Discover designer fashion, next-gen electronics, home aesthetics, and certified wellness.
                            Curated directly from verified merchants with zero compromises on quality.
                        </p>

                        {/* Integrated Hero Search Box */}
                        <form onSubmit={handleHeroSearchSubmit} className="relative max-w-xl">
                            <div className="flex items-center rounded-2xl bg-white/10 p-2 border border-white/20 backdrop-blur-xl shadow-lg focus-within:border-blue-400 focus-within:ring-2 focus-within:ring-blue-400/30 transition-all">
                                <Search className="ml-3 h-5 w-5 text-slate-400" />
                                <input
                                    type="text"
                                    value={heroSearch}
                                    onChange={(e) => setHeroSearch(e.target.value)}
                                    placeholder="Search 1,000+ products (e.g. Headphones, Shoes, Espresso)..."
                                    className="w-full bg-transparent px-3 py-2 text-sm text-white placeholder-slate-400 outline-none"
                                />
                                {heroSearch && (
                                    <button
                                        type="button"
                                        onClick={() => setHeroSearch('')}
                                        className="p-1 text-slate-400 hover:text-white"
                                    >
                                        <X className="h-4 w-4" />
                                    </button>
                                )}
                                <button
                                    type="submit"
                                    className="rounded-xl bg-blue-600 px-5 py-2.5 text-sm font-bold text-white transition-all hover:bg-blue-500 hover:shadow-lg active:scale-95"
                                >
                                    Search
                                </button>
                            </div>

                            {/* Quick Popular Search Pills */}
                            <div className="mt-3 flex flex-wrap items-center gap-2">
                                <span className="text-xs text-slate-400">Popular:</span>
                                {POPULAR_SEARCHES.map((tag) => (
                                    <button
                                        type="button"
                                        key={tag}
                                        onClick={() => {
                                            setHeroSearch(tag);
                                            navigate(`/products?name=${encodeURIComponent(tag)}`);
                                        }}
                                        className="rounded-full border border-white/10 bg-white/5 px-3 py-1 text-xs text-slate-300 transition-colors hover:border-blue-400 hover:text-white"
                                    >
                                        {tag}
                                    </button>
                                ))}
                            </div>
                        </form>

                        {/* Dual CTAs & Key Trust Proof */}
                        <div className="flex flex-wrap items-center gap-4 pt-2">
                            <Link
                                to="/products"
                                className="group flex items-center gap-2 rounded-2xl bg-white px-7 py-3.5 text-base font-bold text-slate-950 transition-all hover:scale-105 hover:bg-slate-100 shadow-xl"
                            >
                                Shop All Products
                                <ArrowRight className="h-4 w-4 transition-transform group-hover:translate-x-1" />
                            </Link>
                            <a
                                href="#featured-products"
                                className="flex items-center gap-2 rounded-2xl border border-white/20 bg-white/5 px-6 py-3.5 text-base font-bold text-white backdrop-blur-md transition-all hover:bg-white/10"
                            >
                                <Zap className="h-4 w-4 text-yellow-400" />
                                View Featured
                            </a>
                        </div>

                        {/* Micro Trust Strip */}
                        <div className="mt-2 grid grid-cols-3 gap-4 border-t border-white/10 pt-6 max-w-lg">
                            <div>
                                <p className="text-xl font-black text-white">1,040+</p>
                                <p className="text-xs text-slate-400 font-medium">In-Stock Items</p>
                            </div>
                            <div>
                                <p className="text-xl font-black text-white">4.9 / 5</p>
                                <p className="text-xs text-slate-400 font-medium">Shopper Rating</p>
                            </div>
                            <div>
                                <p className="text-xl font-black text-white">100%</p>
                                <p className="text-xs text-slate-400 font-medium">Stripe Protected</p>
                            </div>
                        </div>
                    </div>

                    {/* Right Hero Column: Spotlight Feature Card */}
                    <div className="relative lg:col-span-5">
                        <div className="relative aspect-[4/5] rounded-[2rem] border border-white/10 bg-gradient-to-br from-slate-900 via-slate-900/90 to-slate-950 p-4 shadow-2xl overflow-hidden group">
                            <img
                                src="https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?auto=format&fit=crop&q=80&w=800"
                                alt="Spotlight Edition Headphones"
                                className="h-full w-full rounded-[1.5rem] object-cover transition-transform duration-700 group-hover:scale-105"
                            />

                            {/* Floating Top Pill */}
                            <div className="absolute top-7 left-7 rounded-full bg-slate-950/80 px-3.5 py-1.5 text-xs font-black text-white backdrop-blur-md border border-white/20 flex items-center gap-1.5 shadow-lg">
                                <span className="h-2 w-2 rounded-full bg-emerald-400 animate-pulse"></span>
                                Top Seller • Edition 01
                            </div>

                            {/* Floating Bottom Card Over Image */}
                            <div className="absolute inset-x-7 bottom-7 rounded-2xl bg-slate-950/90 p-5 backdrop-blur-md border border-white/15 shadow-2xl">
                                <div className="flex items-center justify-between">
                                    <span className="text-xs font-bold text-blue-400 uppercase tracking-wider">Electronics</span>
                                    <span className="text-xs font-semibold text-emerald-400 bg-emerald-500/10 px-2 py-0.5 rounded-full border border-emerald-500/20">
                                        Only 4 left
                                    </span>
                                </div>
                                <h3 className="mt-1 text-lg font-bold text-white">Apple Wireless Headphones</h3>
                                <div className="mt-2 flex items-center justify-between">
                                    <div className="flex items-baseline gap-2">
                                        <span className="text-2xl font-black text-white">$368.09</span>
                                        <span className="text-xs text-slate-400 line-through">$429.00</span>
                                    </div>
                                    <Link
                                        to="/products"
                                        className="rounded-xl bg-blue-600 px-3.5 py-2 text-xs font-bold text-white hover:bg-blue-500 transition-colors flex items-center gap-1"
                                    >
                                        Order Now <ArrowRight className="h-3 w-3" />
                                    </Link>
                                </div>
                            </div>
                        </div>

                        {/* Ambient Glowing Blobs */}
                        <div className="absolute -top-12 -right-12 h-64 w-64 rounded-full bg-blue-600/20 blur-[90px] -z-10" />
                        <div className="absolute -bottom-12 -left-12 h-64 w-64 rounded-full bg-emerald-600/20 blur-[90px] -z-10" />
                    </div>
                </div>
            </section>

            {/* 2. Interactive Category Filter Strip (The Category Explorer) */}
            <section className="space-y-6">
                <div className="flex flex-col sm:flex-row sm:items-end sm:justify-between gap-2">
                    <div>
                        <div className="flex items-center gap-2 text-xs font-bold uppercase tracking-wider text-primary">
                            <Tag className="h-4 w-4" />
                            Browse by Department
                        </div>
                        <h2 className="text-2xl sm:text-3xl font-black tracking-tight">Explore 8 Core Categories</h2>
                    </div>
                    <Link to="/products" className="group inline-flex items-center gap-1.5 text-sm font-bold text-primary hover:underline">
                        Full Catalog Directory <ArrowRight className="h-4 w-4 transition-transform group-hover:translate-x-1" />
                    </Link>
                </div>

                {/* Horizontal Scrollable Category Pills */}
                <div className="flex gap-3 overflow-x-auto pb-2 pt-1 no-scrollbar scroll-smooth">
                    {/* "All" Category Pill */}
                    <button
                        onClick={() => setSelectedCategory(null)}
                        className={`flex shrink-0 items-center gap-3 rounded-2xl border px-5 py-3.5 text-sm font-bold transition-all ${selectedCategory === null
                                ? 'border-primary bg-primary text-primary-foreground shadow-lg scale-105'
                                : 'border-border bg-card text-foreground hover:border-primary/50 hover:bg-muted/50'
                            }`}
                    >
                        <LayoutGrid className="h-5 w-5" />
                        <span>All Products</span>
                        <span className="ml-1 rounded-full bg-white/20 px-2 py-0.5 text-xs font-extrabold">
                            1,040
                        </span>
                    </button>

                    {/* Dynamic Categories */}
                    {categories.map((cat) => {
                        const IconComponent = CATEGORY_ICON_MAP[cat.name] || LayoutGrid;
                        const isSelected = selectedCategory === cat.id;
                        return (
                            <button
                                key={cat.id}
                                onClick={() => setSelectedCategory(cat.id)}
                                className={`flex shrink-0 items-center gap-2.5 rounded-2xl border px-5 py-3.5 text-sm font-bold transition-all ${isSelected
                                        ? 'border-primary bg-primary text-primary-foreground shadow-lg scale-105'
                                        : 'border-border bg-card text-foreground hover:border-primary/50 hover:bg-muted/50'
                                    }`}
                            >
                                <IconComponent className="h-5 w-5" />
                                <span>{cat.name}</span>
                            </button>
                        );
                    })}
                </div>
            </section>

            {/* 3. Flash Deal Countdown Banner */}
            <section className="relative overflow-hidden rounded-[2rem] border bg-gradient-to-r from-amber-500/10 via-orange-500/10 to-rose-500/10 p-6 md:p-8">
                <div className="flex flex-col md:flex-row items-center justify-between gap-6">
                    <div className="flex items-center gap-4">
                        <div className="flex h-14 w-14 shrink-0 items-center justify-center rounded-2xl bg-orange-500 text-white shadow-lg">
                            <Clock className="h-7 w-7 animate-pulse" />
                        </div>
                        <div>
                            <div className="flex items-center gap-2">
                                <span className="rounded-md bg-orange-500/20 px-2 py-0.5 text-xs font-black text-orange-600 dark:text-orange-400 uppercase">
                                    Limited Time Drop
                                </span>
                                <span className="text-xs text-muted-foreground font-semibold">Ends in:</span>
                            </div>
                            <h3 className="text-xl md:text-2xl font-black tracking-tight mt-0.5">
                                Mid-Season Flash Deals: Save up to 35% on Electronics
                            </h3>
                        </div>
                    </div>

                    {/* Clock Display */}
                    <div className="flex items-center gap-2">
                        <div className="flex flex-col items-center justify-center rounded-xl bg-card border px-3 py-2 shadow-sm min-w-[56px]">
                            <span className="text-xl font-black text-foreground">{String(timeLeft.hours).padStart(2, '0')}</span>
                            <span className="text-[10px] uppercase font-bold text-muted-foreground">Hours</span>
                        </div>
                        <span className="text-xl font-black text-muted-foreground">:</span>
                        <div className="flex flex-col items-center justify-center rounded-xl bg-card border px-3 py-2 shadow-sm min-w-[56px]">
                            <span className="text-xl font-black text-foreground">{String(timeLeft.minutes).padStart(2, '0')}</span>
                            <span className="text-[10px] uppercase font-bold text-muted-foreground">Mins</span>
                        </div>
                        <span className="text-xl font-black text-muted-foreground">:</span>
                        <div className="flex flex-col items-center justify-center rounded-xl bg-card border px-3 py-2 shadow-sm min-w-[56px]">
                            <span className="text-xl font-black text-orange-500">{String(timeLeft.seconds).padStart(2, '0')}</span>
                            <span className="text-[10px] uppercase font-bold text-muted-foreground">Secs</span>
                        </div>
                        <Link
                            to="/products"
                            className="ml-3 rounded-xl bg-orange-500 px-5 py-3 text-sm font-bold text-white hover:bg-orange-600 transition-colors shadow-md flex items-center gap-1.5"
                        >
                            Claim Deals <ArrowRight className="h-4 w-4" />
                        </Link>
                    </div>
                </div>
            </section>

            {/* 4. Curated Product Showcase */}
            <section id="featured-products" className="space-y-6">
                <div className="flex flex-col md:flex-row md:items-center justify-between gap-4">
                    <div>
                        <div className="flex items-center gap-2">
                            <Flame className="h-6 w-6 text-orange-500" />
                            <h2 className="text-2xl sm:text-3xl font-black tracking-tight">
                                {selectedCategory
                                    ? `${categories.find(c => c.id === selectedCategory)?.name || 'Filtered'} Collection`
                                    : 'Trending Products'}
                            </h2>
                        </div>
                        <p className="text-sm text-muted-foreground mt-0.5">
                            Showing {displayedProducts.length} of our top rated merchandise
                        </p>
                    </div>

                    {/* Secondary Filter Chips */}
                    <div className="flex flex-wrap items-center gap-2">
                        <button
                            onClick={() => setActiveFilter('all')}
                            className={`rounded-xl px-3.5 py-1.5 text-xs font-bold transition-colors ${activeFilter === 'all'
                                    ? 'bg-foreground text-background'
                                    : 'bg-muted text-muted-foreground hover:text-foreground'
                                }`}
                        >
                            All
                        </button>
                        <button
                            onClick={() => setActiveFilter('under100')}
                            className={`rounded-xl px-3.5 py-1.5 text-xs font-bold transition-colors ${activeFilter === 'under100'
                                    ? 'bg-foreground text-background'
                                    : 'bg-muted text-muted-foreground hover:text-foreground'
                                }`}
                        >
                            Under $100
                        </button>
                        <button
                            onClick={() => setActiveFilter('topRated')}
                            className={`rounded-xl px-3.5 py-1.5 text-xs font-bold transition-colors ${activeFilter === 'topRated'
                                    ? 'bg-foreground text-background'
                                    : 'bg-muted text-muted-foreground hover:text-foreground'
                                }`}
                        >
                            Premium Pick
                        </button>
                        <button
                            onClick={() => setActiveFilter('inStock')}
                            className={`rounded-xl px-3.5 py-1.5 text-xs font-bold transition-colors ${activeFilter === 'inStock'
                                    ? 'bg-foreground text-background'
                                    : 'bg-muted text-muted-foreground hover:text-foreground'
                                }`}
                        >
                            In Stock Only
                        </button>
                    </div>
                </div>

                {/* Loading Skeleton Matrix */}
                {(loading || loadingProducts) ? (
                    <div className="grid grid-cols-1 gap-6 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4">
                        {[...Array(8)].map((_, i) => (
                            <div key={i} className="animate-pulse rounded-[2rem] border bg-card p-4 space-y-4">
                                <div className="aspect-[4/5] rounded-2xl bg-muted" />
                                <div className="h-4 w-3/4 rounded bg-muted" />
                                <div className="h-4 w-1/2 rounded bg-muted" />
                                <div className="h-10 rounded-xl bg-muted" />
                            </div>
                        ))}
                    </div>
                ) : displayedProducts.length === 0 ? (
                    <div className="rounded-[2.5rem] border border-dashed p-16 text-center">
                        <div className="mx-auto flex h-16 w-16 items-center justify-center rounded-2xl bg-muted text-muted-foreground mb-4">
                            <ShoppingBag className="h-8 w-8" />
                        </div>
                        <h3 className="text-xl font-bold">No products match this selection</h3>
                        <p className="mt-1 text-sm text-muted-foreground">Try clearing filters or selecting another category.</p>
                        <button
                            onClick={() => {
                                setSelectedCategory(null);
                                setActiveFilter('all');
                            }}
                            className="mt-5 rounded-xl bg-primary px-6 py-2.5 text-sm font-bold text-primary-foreground hover:bg-primary/90"
                        >
                            Reset All Filters
                        </button>
                    </div>
                ) : (
                    /* Products Grid */
                    <div className="grid grid-cols-1 gap-6 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4">
                        {displayedProducts.map((product) => {
                            const isAdded = !!addedSuccess[product.id];
                            const isAdding = !!addingToCart[product.id];
                            const isFav = !!wishlistMap[product.id];
                            const isFavLoading = !!wishlistLoading[product.id];
                            const isLowStock = product.stockQuantity > 0 && product.stockQuantity <= 10;

                            return (
                                <div
                                    key={product.id}
                                    className="group relative flex flex-col justify-between rounded-[2rem] border bg-card p-4 shadow-sm transition-all duration-300 hover:shadow-xl hover:-translate-y-1"
                                >
                                    {/* Image Wrapper */}
                                    <div className="relative aspect-[4/5] overflow-hidden rounded-[1.5rem] bg-muted">
                                        <img
                                            src={product.imageUrl}
                                            alt={product.name}
                                            className="h-full w-full object-cover transition-transform duration-500 group-hover:scale-105"
                                            loading="lazy"
                                        />

                                        {/* Stock Tag Top Left */}
                                        <div className="absolute top-3 left-3 flex flex-col gap-1">
                                            {isLowStock ? (
                                                <span className="rounded-full bg-amber-500/90 px-2.5 py-1 text-[11px] font-bold text-white backdrop-blur-sm shadow-sm">
                                                    Only {product.stockQuantity} left
                                                </span>
                                            ) : (
                                                <span className="rounded-full bg-emerald-600/90 px-2.5 py-1 text-[11px] font-bold text-white backdrop-blur-sm shadow-sm">
                                                    In Stock
                                                </span>
                                            )}
                                        </div>

                                        {/* Wishlist Button Top Right */}
                                        <button
                                            type="button"
                                            onClick={(e) => handleToggleWishlist(e, product)}
                                            disabled={isFavLoading}
                                            aria-label="Save to wishlist"
                                            className={`absolute top-3 right-3 flex h-9 w-9 items-center justify-center rounded-full backdrop-blur-md transition-all shadow-md ${isFav
                                                    ? 'bg-rose-500 text-white'
                                                    : 'bg-white/80 dark:bg-slate-900/80 text-foreground hover:scale-110'
                                                }`}
                                        >
                                            <Heart className={`h-4 w-4 ${isFav ? 'fill-current' : ''}`} />
                                        </button>

                                        {/* Quick View Link Button Over Image on Hover */}
                                        <Link
                                            to={`/products/${product.id}`}
                                            className="absolute inset-x-4 bottom-3 hidden group-hover:flex items-center justify-center rounded-xl bg-white/90 py-2.5 text-xs font-bold text-slate-950 backdrop-blur-md shadow-lg transition-transform hover:bg-white"
                                        >
                                            Quick View
                                        </Link>
                                    </div>

                                    {/* Content Info */}
                                    <div className="mt-4 flex flex-1 flex-col justify-between">
                                        <div>
                                            <div className="flex items-center justify-between text-xs text-muted-foreground font-semibold">
                                                <span>{product.category?.name || 'Curated'}</span>
                                                <div className="flex items-center gap-1 text-amber-500">
                                                    <Star className="h-3.5 w-3.5 fill-current" />
                                                    <span className="font-bold text-foreground">4.8</span>
                                                    <span className="text-[10px] text-muted-foreground">(48)</span>
                                                </div>
                                            </div>

                                            <Link to={`/products/${product.id}`}>
                                                <h3 className="mt-1 font-bold text-base leading-snug line-clamp-2 hover:text-primary transition-colors">
                                                    {product.name}
                                                </h3>
                                            </Link>
                                        </div>

                                        {/* Price and Add to Cart Action */}
                                        <div className="mt-4 pt-3 border-t flex items-center justify-between gap-2">
                                            <div className="flex flex-col">
                                                <span className="text-xl font-black text-foreground">
                                                    {formatPrice(product.price)}
                                                </span>
                                                <span className="text-xs text-muted-foreground line-through">
                                                    {formatPrice(product.price * 1.18)}
                                                </span>
                                            </div>

                                            {/* 1-Click Direct Add to Cart Button */}
                                            <button
                                                type="button"
                                                onClick={(e) => handleAddToCart(e, product)}
                                                disabled={isAdding}
                                                className={`flex items-center gap-1.5 rounded-xl px-4 py-2.5 text-xs font-bold transition-all shadow-sm ${isAdded
                                                        ? 'bg-emerald-600 text-white'
                                                        : 'bg-primary text-primary-foreground hover:bg-primary/90 active:scale-95'
                                                    }`}
                                            >
                                                {isAdding ? (
                                                    <div className="h-4 w-4 animate-spin rounded-full border-2 border-white border-t-transparent" />
                                                ) : isAdded ? (
                                                    <>
                                                        <Check className="h-4 w-4 stroke-[3]" />
                                                        <span>Added</span>
                                                    </>
                                                ) : (
                                                    <>
                                                        <ShoppingBag className="h-4 w-4" />
                                                        <span>Add</span>
                                                    </>
                                                )}
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            );
                        })}
                    </div>
                )}

                {/* Bottom View All Link */}
                <div className="pt-4 text-center">
                    <Link
                        to="/products"
                        className="inline-flex items-center gap-2 rounded-2xl border px-8 py-4 text-base font-bold text-foreground transition-all hover:border-primary hover:bg-muted/50 hover:shadow-md"
                    >
                        Browse All 1,000+ Products <ArrowRight className="h-4 w-4" />
                    </Link>
                </div>
            </section>

            {/* 5. Trust Pillars Grid */}
            <section className="grid grid-cols-1 gap-6 sm:grid-cols-2 lg:grid-cols-4">
                <TrustCard
                    icon={<Truck className="h-7 w-7 text-blue-600 dark:text-blue-400" />}
                    title="Free Express Delivery"
                    description="Complimentary 2-3 business day shipping on all orders over $100."
                />
                <TrustCard
                    icon={<ShieldCheck className="h-7 w-7 text-emerald-600 dark:text-emerald-400" />}
                    title="Stripe Encrypted"
                    description="Bank-grade 256-bit encryption protecting every card transaction."
                />
                <TrustCard
                    icon={<RefreshCw className="h-7 w-7 text-indigo-600 dark:text-indigo-400" />}
                    title="30-Day Guarantees"
                    description="Zero-hassle returns and instant refunds with prepaid shipping labels."
                />
                <TrustCard
                    icon={<Headphones className="h-7 w-7 text-amber-600 dark:text-amber-400" />}
                    title="24/7 Verified Support"
                    description="Dedicated human support specialists ready via chat and email."
                />
            </section>

            {/* 6. Merchant / Seller Spotlight Callout */}
            <section className="relative overflow-hidden rounded-[2.5rem] bg-gradient-to-br from-slate-900 to-slate-950 p-8 text-white md:p-14 shadow-xl border border-white/10">
                <div className="relative z-10 grid grid-cols-1 lg:grid-cols-12 items-center gap-8">
                    <div className="space-y-4 lg:col-span-8">
                        <div className="inline-flex items-center gap-2 rounded-full bg-emerald-500/20 px-3.5 py-1 text-xs font-bold text-emerald-400 border border-emerald-500/30">
                            <Store className="h-3.5 w-3.5" />
                            Merchant Partnership Program
                        </div>
                        <h2 className="text-3xl font-black md:text-4xl tracking-tight">
                            Scale Your Business with ShopStack Pro
                        </h2>
                        <p className="max-w-2xl text-slate-300 text-sm md:text-base leading-relaxed">
                            Join over 500+ verified merchants. List products, track real-time revenue analytics,
                            manage orders with 1-click fulfillment, and receive automated payouts with zero upfront fees.
                        </p>
                        <div className="flex flex-wrap items-center gap-4 pt-2">
                            <Link
                                to="/register"
                                className="rounded-xl bg-emerald-500 px-6 py-3.5 text-sm font-bold text-slate-950 hover:bg-emerald-400 transition-colors shadow-lg active:scale-95"
                            >
                                Open Your Store Today
                            </Link>
                            <Link
                                to="/login"
                                className="rounded-xl border border-white/20 bg-white/5 px-6 py-3.5 text-sm font-bold text-white hover:bg-white/10 transition-colors"
                            >
                                Seller Portal Login
                            </Link>
                        </div>
                    </div>

                    <div className="lg:col-span-4 hidden lg:flex justify-center">
                        <div className="rounded-3xl border border-white/15 bg-white/5 p-6 backdrop-blur-xl space-y-3 w-full max-w-xs shadow-2xl">
                            <div className="flex items-center justify-between border-b border-white/10 pb-3">
                                <span className="text-xs font-bold text-slate-400">Merchant Dashboard</span>
                                <span className="text-xs font-bold text-emerald-400">Live Active</span>
                            </div>
                            <div>
                                <p className="text-xs text-slate-400">Monthly Revenue</p>
                                <p className="text-2xl font-black text-white">$42,850.00</p>
                            </div>
                            <div className="flex items-center justify-between text-xs text-slate-300 pt-2 border-t border-white/10">
                                <span>Fulfilled Orders</span>
                                <span className="font-bold text-white">1,248</span>
                            </div>
                        </div>
                    </div>
                </div>
            </section>

            {/* 7. Verified Shopper Reviews */}
            <section className="space-y-6">
                <div className="text-center max-w-xl mx-auto space-y-2">
                    <h2 className="text-3xl font-black tracking-tight">Loved by Over 50,000+ Shoppers</h2>
                    <p className="text-sm text-muted-foreground">Real reviews from verified purchases across our nationwide network</p>
                </div>

                <div className="grid grid-cols-1 gap-6 md:grid-cols-3">
                    <ReviewCard
                        name="Sophia Martinez"
                        city="San Francisco, CA"
                        avatar="https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&q=80&w=150"
                        item="Apple Wireless Headphones"
                        review="Delivery took less than 48 hours and the sound clarity is unreal. Checkout with card was seamless!"
                    />
                    <ReviewCard
                        name="Marcus Chen"
                        city="New York, NY"
                        avatar="https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&q=80&w=150"
                        item="Barista Espresso Machine"
                        review="Build quality is solid stainless steel. Exactly what was described. Customer support answered my questions instantly."
                    />
                    <ReviewCard
                        name="Elena Rostova"
                        city="Austin, TX"
                        avatar="https://images.unsplash.com/photo-1494790108377-be9c29b29330?auto=format&fit=crop&q=80&w=150"
                        item="Running Sneakers Pro"
                        review="Best e-commerce experience yet. The interactive tracking and return policy gave me complete confidence."
                    />
                </div>
            </section>

            {/* 8. Interactive Newsletter Subscription */}
            <section className="relative overflow-hidden rounded-[2.5rem] bg-gradient-to-r from-blue-600 via-indigo-600 to-blue-700 px-6 py-14 text-center text-white md:px-16 shadow-2xl">
                <div className="mx-auto max-w-2xl space-y-6">
                    <div className="inline-flex items-center gap-2 rounded-full bg-white/20 px-4 py-1 text-xs font-bold backdrop-blur-md">
                        <Award className="h-4 w-4 text-yellow-300" />
                        Exclusive Member Privileges
                    </div>

                    <h2 className="text-3xl font-black md:text-5xl tracking-tight">
                        Unlock 15% Off Your First Order
                    </h2>

                    <p className="text-blue-100 text-sm md:text-base leading-relaxed max-w-lg mx-auto">
                        Join our VIP member circle. Be the first to receive secret flash discounts, weekly new product drops, and seasonal vouchers.
                    </p>

                    {newsletterSuccess ? (
                        <div className="rounded-2xl bg-white/20 p-5 backdrop-blur-md border border-white/30 text-white font-bold">
                            🎉 Welcome to the club! Use coupon code <span className="underline font-black text-yellow-300">STACK15</span> at checkout.
                        </div>
                    ) : (
                        <form onSubmit={handleNewsletterSubmit} className="flex flex-col sm:flex-row gap-3 max-w-md mx-auto">
                            <input
                                type="email"
                                required
                                value={newsletterEmail}
                                onChange={(e) => setNewsletterEmail(e.target.value)}
                                placeholder="Enter your email address..."
                                className="flex-1 rounded-2xl border-none bg-white/20 px-5 py-3.5 text-sm text-white placeholder-blue-200 outline-none focus:ring-2 focus:ring-white/50 backdrop-blur-md"
                            />
                            <button
                                type="submit"
                                className="rounded-2xl bg-white px-7 py-3.5 text-sm font-bold text-blue-600 transition-all hover:bg-blue-50 active:scale-95 shadow-lg"
                            >
                                Claim 15% Off
                            </button>
                        </form>
                    )}

                    <p className="text-xs text-blue-200">
                        No spam ever. Unsubscribe at any time with a single click.
                    </p>
                </div>
            </section>
        </div>
    );
};

// Trust Card Component
const TrustCard = ({ icon, title, description }) => (
    <div className="rounded-[2rem] border bg-card p-6 shadow-sm transition-all hover:shadow-md hover:border-primary/30">
        <div className="mb-4 flex h-12 w-12 items-center justify-center rounded-2xl bg-muted">
            {icon}
        </div>
        <h3 className="text-base font-bold text-foreground">{title}</h3>
        <p className="mt-1 text-xs text-muted-foreground leading-relaxed">{description}</p>
    </div>
);

// Review Card Component
const ReviewCard = ({ name, city, avatar, item, review }) => (
    <div className="rounded-[2rem] border bg-card p-6 shadow-sm space-y-4 hover:shadow-md transition-shadow">
        <div className="flex items-center justify-between">
            <div className="flex items-center gap-1 text-amber-500">
                {[...Array(5)].map((_, i) => (
                    <Star key={i} className="h-4 w-4 fill-current" />
                ))}
            </div>
            {item && (
                <span className="text-[10px] font-bold text-muted-foreground bg-muted px-2 py-0.5 rounded-full truncate max-w-[150px]">
                    {item}
                </span>
            )}
        </div>
        <p className="text-sm text-foreground/90 leading-relaxed italic">
            "{review}"
        </p>
        <div className="flex items-center gap-3 pt-2 border-t">
            <img src={avatar} alt={name} className="h-10 w-10 rounded-full object-cover border" />
            <div className="flex flex-col">
                <span className="text-xs font-bold text-foreground">{name}</span>
                <span className="text-[11px] text-muted-foreground">{city} • Verified Buyer</span>
            </div>
        </div>
    </div>
);

export default UserHomePage;
