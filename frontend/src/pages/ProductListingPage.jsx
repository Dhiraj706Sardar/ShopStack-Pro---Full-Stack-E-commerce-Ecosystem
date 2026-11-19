import React, { useState, useEffect, useMemo, useRef } from 'react';
import { Link, useSearchParams, useNavigate } from 'react-router-dom';
import api from '../api/axios';
import { useAuth } from '../context/AuthContext';
import {
    Search,
    Filter,
    ChevronLeft,
    ChevronRight,
    ChevronsLeft,
    ChevronsRight,
    ShoppingBag,
    Heart,
    Star,
    X,
    Sparkles,
    Check,
    SlidersHorizontal,
    ArrowUpDown
} from 'lucide-react';

const PAGE_SIZE_OPTIONS = [12, 24, 48];

const ProductListingPage = () => {
    const [searchParams, setSearchParams] = useSearchParams();
    const navigate = useNavigate();
    const { user } = useAuth();
    const listTopRef = useRef(null);

    // Initial state from URL search params
    const initialCategory = searchParams.get('categoryId') || searchParams.get('category') || '';
    const initialSearch = searchParams.get('name') || '';
    const initialPage = parseInt(searchParams.get('page') || '0', 10);
    const initialSize = parseInt(searchParams.get('size') || '12', 10);

    // State
    const [products, setProducts] = useState([]);
    const [categories, setCategories] = useState([]);
    const [selectedCategory, setSelectedCategory] = useState(initialCategory);
    const [searchTerm, setSearchTerm] = useState(initialSearch);
    const [debouncedSearch, setDebouncedSearch] = useState(initialSearch);
    const [page, setPage] = useState(isNaN(initialPage) ? 0 : initialPage);
    const [pageSize, setPageSize] = useState(PAGE_SIZE_OPTIONS.includes(initialSize) ? initialSize : 12);
    const [totalPages, setTotalPages] = useState(0);
    const [totalElements, setTotalElements] = useState(0);
    const [loading, setLoading] = useState(true);
    const [sortBy, setSortBy] = useState('default');
    const [jumpPageInput, setJumpPageInput] = useState('');

    // Cart & Wishlist interactive states
    const [addingToCart, setAddingToCart] = useState({});
    const [addedSuccess, setAddedSuccess] = useState({});
    const [wishlistMap, setWishlistMap] = useState({});
    const [wishlistLoading, setWishlistLoading] = useState({});

    // Debounce search input typing
    useEffect(() => {
        const handler = setTimeout(() => {
            setDebouncedSearch(searchTerm);
            setPage(0); // Reset to first page on new search
        }, 400);
        return () => clearTimeout(handler);
    }, [searchTerm]);

    // Fetch category list once
    useEffect(() => {
        fetchCategories();
        if (user) {
            fetchWishlist();
        }
    }, [user]);

    // Update URL params when filters change
    useEffect(() => {
        const params = new URLSearchParams();
        if (debouncedSearch) params.set('name', debouncedSearch);
        if (selectedCategory) params.set('categoryId', selectedCategory);
        if (page > 0) params.set('page', String(page));
        if (pageSize !== 12) params.set('size', String(pageSize));
        setSearchParams(params, { replace: true });
    }, [debouncedSearch, selectedCategory, page, pageSize, setSearchParams]);

    // Fetch products whenever filters or pagination change
    useEffect(() => {
        fetchProducts();
    }, [page, pageSize, debouncedSearch, selectedCategory]);

    const fetchCategories = async () => {
        try {
            const response = await api.get('/public/categories');
            setCategories(response.data || []);
        } catch (error) {
            console.error('Error fetching categories:', error);
        }
    };

    const fetchWishlist = async () => {
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

    const fetchProducts = async () => {
        setLoading(true);
        try {
            let url = `/public/products?page=${page}&size=${pageSize}`;
            if (debouncedSearch.trim()) {
                url += `&name=${encodeURIComponent(debouncedSearch.trim())}`;
            }
            if (selectedCategory) {
                url += `&categoryId=${selectedCategory}`;
            }

            const response = await api.get(url);
            const data = response.data;
            setProducts(data.content || []);
            setTotalPages(data.totalPages || 0);
            setTotalElements(data.totalElements || (data.content ? data.content.length : 0));
        } catch (error) {
            console.error('Error fetching products:', error);
        } finally {
            setLoading(false);
        }
    };

    const handlePageChange = (newPage) => {
        if (newPage >= 0 && newPage < totalPages && newPage !== page) {
            setPage(newPage);
            if (listTopRef.current) {
                listTopRef.current.scrollIntoView({ behavior: 'smooth', block: 'start' });
            } else {
                window.scrollTo({ top: 0, behavior: 'smooth' });
            }
        }
    };

    const handleJumpPageSubmit = (e) => {
        e.preventDefault();
        const targetPage = parseInt(jumpPageInput, 10);
        if (!isNaN(targetPage) && targetPage >= 1 && targetPage <= totalPages) {
            handlePageChange(targetPage - 1);
            setJumpPageInput('');
        }
    };

    const handleCategoryChange = (catId) => {
        setSelectedCategory(catId);
        setPage(0);
    };

    const handlePageSizeChange = (newSize) => {
        setPageSize(newSize);
        setPage(0);
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
            alert('Could not add product to cart.');
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

    // Client-side sort options on current page items
    const sortedProducts = useMemo(() => {
        if (!products || products.length === 0) return [];
        const items = [...products];
        if (sortBy === 'price-low') {
            return items.sort((a, b) => a.price - b.price);
        }
        if (sortBy === 'price-high') {
            return items.sort((a, b) => b.price - a.price);
        }
        if (sortBy === 'name-asc') {
            return items.sort((a, b) => a.name.localeCompare(b.name));
        }
        return items;
    }, [products, sortBy]);

    // Truncated Windowed Pagination Algorithm
    const paginationItems = useMemo(() => {
        if (totalPages <= 7) {
            return Array.from({ length: totalPages }, (_, i) => i);
        }

        const items = [];
        const showLeftEllipsis = page > 3;
        const showRightEllipsis = page < totalPages - 4;

        if (!showLeftEllipsis && showRightEllipsis) {
            // Near start: 0, 1, 2, 3, 4, 'ellipsis-right', totalPages - 1
            for (let i = 0; i < 5; i++) items.push(i);
            items.push('ellipsis-right');
            items.push(totalPages - 1);
        } else if (showLeftEllipsis && !showRightEllipsis) {
            // Near end: 0, 'ellipsis-left', totalPages - 5 .. totalPages - 1
            items.push(0);
            items.push('ellipsis-left');
            for (let i = totalPages - 5; i < totalPages; i++) items.push(i);
        } else {
            // Middle: 0, 'ellipsis-left', page - 1, page, page + 1, 'ellipsis-right', totalPages - 1
            items.push(0);
            items.push('ellipsis-left');
            items.push(page - 1);
            items.push(page);
            items.push(page + 1);
            items.push('ellipsis-right');
            items.push(totalPages - 1);
        }

        return items;
    }, [page, totalPages]);

    const formatPrice = (price) => {
        return Number(price || 0).toLocaleString('en-US', {
            style: 'currency',
            currency: 'USD'
        });
    };

    const startItemIndex = totalElements === 0 ? 0 : page * pageSize + 1;
    const endItemIndex = Math.min((page + 1) * pageSize, totalElements);

    return (
        <div ref={listTopRef} className="flex flex-col gap-8 pb-24">
            {/* 1. Header & Filter Toolbar */}
            <div className="flex flex-col gap-6 border-b pb-6">
                <div className="flex flex-col md:flex-row md:items-center justify-between gap-4">
                    <div>
                        <div className="flex items-center gap-2 text-xs font-bold uppercase tracking-wider text-primary">
                            <Sparkles className="h-4 w-4" />
                            Live Catalog Explorer
                        </div>
                        <h1 className="text-3xl sm:text-4xl font-black tracking-tight mt-1">
                            {selectedCategory
                                ? `${categories.find(c => c.id === selectedCategory)?.name || 'Filtered'} Department`
                                : 'All Products'}
                        </h1>
                        <p className="text-sm text-muted-foreground mt-0.5">
                            Showing <strong className="text-foreground">{startItemIndex}–{endItemIndex}</strong> of <strong className="text-foreground">{totalElements.toLocaleString()}</strong> verified items
                        </p>
                    </div>

                    {/* Search & Sort Controls */}
                    <div className="flex flex-wrap items-center gap-3">
                        {/* Search Input */}
                        <div className="relative flex-1 sm:w-64">
                            <Search className="absolute left-3.5 top-1/2 h-4 w-4 -translate-y-1/2 text-muted-foreground" />
                            <input
                                type="text"
                                placeholder="Search by name, brand, spec..."
                                value={searchTerm}
                                onChange={(e) => setSearchTerm(e.target.value)}
                                className="h-11 w-full rounded-2xl border bg-card pl-10 pr-9 text-sm outline-none focus:border-primary focus:ring-2 focus:ring-primary/20 shadow-sm"
                            />
                            {searchTerm && (
                                <button
                                    onClick={() => setSearchTerm('')}
                                    className="absolute right-3 top-1/2 -translate-y-1/2 text-muted-foreground hover:text-foreground p-1"
                                    aria-label="Clear search"
                                >
                                    <X className="h-3.5 w-3.5" />
                                </button>
                            )}
                        </div>

                        {/* Sort Selector */}
                        <div className="relative">
                            <select
                                value={sortBy}
                                onChange={(e) => setSortBy(e.target.value)}
                                className="h-11 rounded-2xl border bg-card px-4 text-xs sm:text-sm font-bold text-foreground outline-none focus:border-primary focus:ring-2 focus:ring-primary/20 shadow-sm cursor-pointer"
                            >
                                <option value="default">Sort: Default</option>
                                <option value="price-low">Price: Low to High</option>
                                <option value="price-high">Price: High to Low</option>
                                <option value="name-asc">Name: A to Z</option>
                            </select>
                        </div>

                        {/* Items Per Page Selector */}
                        <div className="flex items-center gap-1.5 rounded-2xl border bg-card px-3 h-11 text-xs font-bold text-muted-foreground shadow-sm">
                            <span className="hidden sm:inline">Per page:</span>
                            {PAGE_SIZE_OPTIONS.map((size) => (
                                <button
                                    key={size}
                                    onClick={() => handlePageSizeChange(size)}
                                    className={`px-2 py-1 rounded-lg transition-colors ${pageSize === size
                                            ? 'bg-primary text-primary-foreground font-black'
                                            : 'hover:bg-muted text-foreground'
                                        }`}
                                >
                                    {size}
                                </button>
                            ))}
                        </div>
                    </div>
                </div>

                {/* Category Pills Filter Bar */}
                <div className="flex gap-2 overflow-x-auto pb-1 pt-1 no-scrollbar">
                    <button
                        onClick={() => handleCategoryChange('')}
                        className={`shrink-0 rounded-xl px-4 py-2 text-xs font-bold transition-all ${!selectedCategory
                                ? 'bg-primary text-primary-foreground shadow-sm'
                                : 'border bg-card text-muted-foreground hover:text-foreground hover:border-primary/50'
                            }`}
                    >
                        All Categories
                    </button>
                    {categories.map((cat) => {
                        const isSelected = selectedCategory === cat.id;
                        return (
                            <button
                                key={cat.id}
                                onClick={() => handleCategoryChange(cat.id)}
                                className={`shrink-0 rounded-xl px-4 py-2 text-xs font-bold transition-all ${isSelected
                                        ? 'bg-primary text-primary-foreground shadow-sm'
                                        : 'border bg-card text-muted-foreground hover:text-foreground hover:border-primary/50'
                                    }`}
                            >
                                {cat.name}
                            </button>
                        );
                    })}
                </div>
            </div>

            {/* 2. Products Grid & Loading Matrix */}
            {loading ? (
                <div className="grid grid-cols-1 gap-6 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4">
                    {[...Array(pageSize)].map((_, i) => (
                        <div key={i} className="animate-pulse rounded-3xl border bg-card p-4 space-y-4">
                            <div className="aspect-square rounded-2xl bg-muted" />
                            <div className="h-4 w-2/3 rounded bg-muted" />
                            <div className="h-5 w-full rounded bg-muted" />
                            <div className="h-10 rounded-xl bg-muted" />
                        </div>
                    ))}
                </div>
            ) : sortedProducts.length === 0 ? (
                /* Empty State */
                <div className="flex flex-col items-center justify-center rounded-[2.5rem] border border-dashed py-20 px-6 text-center">
                    <div className="rounded-3xl bg-muted p-6 mb-4 text-muted-foreground">
                        <Search className="h-10 w-10" />
                    </div>
                    <h3 className="text-2xl font-black">No products matched your criteria</h3>
                    <p className="mt-1 text-sm text-muted-foreground max-w-sm">
                        Try adjusting your keywords, clearing category filters, or resetting search terms.
                    </p>
                    <button
                        onClick={() => {
                            setSearchTerm('');
                            setSelectedCategory('');
                            setPage(0);
                        }}
                        className="mt-6 rounded-2xl bg-primary px-7 py-3 text-sm font-bold text-primary-foreground shadow-md hover:bg-primary/90"
                    >
                        Reset All Filters
                    </button>
                </div>
            ) : (
                /* Active Products Grid */
                <div className="grid grid-cols-1 gap-6 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4">
                    {sortedProducts.map((product) => {
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
                                {/* Image Container */}
                                <div className="relative aspect-square overflow-hidden rounded-[1.5rem] bg-muted">
                                    <img
                                        src={product.imageUrl || 'https://via.placeholder.com/400'}
                                        alt={product.name}
                                        className="h-full w-full object-cover transition-transform duration-500 group-hover:scale-105"
                                        loading="lazy"
                                    />

                                    {/* Stock Badge Top Left */}
                                    <div className="absolute top-3 left-3 flex flex-col gap-1">
                                        {isLowStock ? (
                                            <span className="rounded-full bg-amber-500/90 px-2.5 py-0.5 text-[11px] font-bold text-white backdrop-blur-sm shadow-sm">
                                                Only {product.stockQuantity} left
                                            </span>
                                        ) : (
                                            <span className="rounded-full bg-emerald-600/90 px-2.5 py-0.5 text-[11px] font-bold text-white backdrop-blur-sm shadow-sm">
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

                                    {/* Quick View Button Hover Action */}
                                    <Link
                                        to={`/products/${product.id}`}
                                        className="absolute inset-x-4 bottom-3 hidden group-hover:flex items-center justify-center rounded-xl bg-white/90 py-2.5 text-xs font-bold text-slate-950 backdrop-blur-md shadow-lg transition-transform hover:bg-white"
                                    >
                                        View Details
                                    </Link>
                                </div>

                                {/* Body Information */}
                                <div className="mt-4 flex flex-1 flex-col justify-between">
                                    <div>
                                        <div className="flex items-center justify-between text-xs text-muted-foreground font-semibold">
                                            <span>{product.categoryName || 'Catalog'}</span>
                                            <div className="flex items-center gap-1 text-amber-500">
                                                <Star className="h-3.5 w-3.5 fill-current" />
                                                <span className="font-bold text-foreground">4.8</span>
                                            </div>
                                        </div>

                                        <Link to={`/products/${product.id}`}>
                                            <h3 className="mt-1 font-bold text-base leading-snug line-clamp-2 hover:text-primary transition-colors">
                                                {product.name}
                                            </h3>
                                        </Link>
                                    </div>

                                    {/* Price and 1-Click Buy Action */}
                                    <div className="mt-4 pt-3 border-t flex items-center justify-between gap-2">
                                        <div className="flex flex-col">
                                            <span className="text-xl font-black text-foreground">
                                                {formatPrice(product.price)}
                                            </span>
                                            <span className="text-xs text-muted-foreground line-through">
                                                {formatPrice(product.price * 1.18)}
                                            </span>
                                        </div>

                                        {/* Direct Add to Cart Action */}
                                        <button
                                            type="button"
                                            onClick={(e) => handleAddToCart(e, product)}
                                            disabled={isAdding}
                                            className={`flex items-center gap-1.5 rounded-xl px-4 py-2 text-xs font-bold transition-all shadow-sm ${isAdded
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

            {/* 3. Production-Grade Windowed Pagination (Fixes the Endless Numbers Blowout) */}
            {totalPages > 1 && (
                <div className="flex flex-col sm:flex-row items-center justify-between gap-4 rounded-3xl border bg-card p-4 sm:p-6 shadow-sm mt-4">
                    {/* Left: Summary Note */}
                    <div className="text-xs sm:text-sm font-semibold text-muted-foreground">
                        Page <strong className="text-foreground">{page + 1}</strong> of <strong className="text-foreground">{totalPages}</strong>
                    </div>

                    {/* Middle: Windowed Controls with Ellipsis */}
                    <div className="flex items-center gap-1 sm:gap-1.5 flex-wrap justify-center">
                        {/* First Page Button */}
                        <button
                            disabled={page === 0}
                            onClick={() => handlePageChange(0)}
                            title="First Page"
                            className="flex h-9 w-9 sm:h-10 sm:w-10 items-center justify-center rounded-xl border hover:bg-muted disabled:opacity-30 disabled:hover:bg-transparent transition-colors"
                        >
                            <ChevronsLeft className="h-4 w-4" />
                        </button>

                        {/* Previous Page Button */}
                        <button
                            disabled={page === 0}
                            onClick={() => handlePageChange(page - 1)}
                            title="Previous Page"
                            className="flex h-9 w-9 sm:h-10 sm:w-10 items-center justify-center rounded-xl border hover:bg-muted disabled:opacity-30 disabled:hover:bg-transparent transition-colors"
                        >
                            <ChevronLeft className="h-4 w-4" />
                        </button>

                        {/* Numbered Page Buttons with Truncated Ellipsis */}
                        {paginationItems.map((item, idx) => {
                            if (typeof item === 'string') {
                                return (
                                    <span
                                        key={`ellipsis-${idx}`}
                                        className="flex h-9 w-8 sm:h-10 sm:w-9 items-center justify-center text-xs font-bold text-muted-foreground tracking-widest select-none"
                                    >
                                        ...
                                    </span>
                                );
                            }

                            const isCurrent = page === item;
                            return (
                                <button
                                    key={item}
                                    onClick={() => handlePageChange(item)}
                                    className={`h-9 w-9 sm:h-10 sm:w-10 rounded-xl text-xs sm:text-sm font-black transition-all ${isCurrent
                                            ? 'bg-primary text-primary-foreground shadow-md scale-105'
                                            : 'border hover:bg-muted text-foreground'
                                        }`}
                                >
                                    {item + 1}
                                </button>
                            );
                        })}

                        {/* Next Page Button */}
                        <button
                            disabled={page === totalPages - 1}
                            onClick={() => handlePageChange(page + 1)}
                            title="Next Page"
                            className="flex h-9 w-9 sm:h-10 sm:w-10 items-center justify-center rounded-xl border hover:bg-muted disabled:opacity-30 disabled:hover:bg-transparent transition-colors"
                        >
                            <ChevronRight className="h-4 w-4" />
                        </button>

                        {/* Last Page Button */}
                        <button
                            disabled={page === totalPages - 1}
                            onClick={() => handlePageChange(totalPages - 1)}
                            title="Last Page"
                            className="flex h-9 w-9 sm:h-10 sm:w-10 items-center justify-center rounded-xl border hover:bg-muted disabled:opacity-30 disabled:hover:bg-transparent transition-colors"
                        >
                            <ChevronsRight className="h-4 w-4" />
                        </button>
                    </div>

                    {/* Right: Quick Jump To Page Form */}
                    <form onSubmit={handleJumpPageSubmit} className="flex items-center gap-2 text-xs font-bold">
                        <span className="text-muted-foreground hidden lg:inline">Go to:</span>
                        <input
                            type="number"
                            min="1"
                            max={totalPages}
                            value={jumpPageInput}
                            onChange={(e) => setJumpPageInput(e.target.value)}
                            placeholder={`${page + 1}`}
                            className="h-9 w-16 rounded-xl border bg-background text-center text-xs font-bold outline-none focus:border-primary focus:ring-1 focus:ring-primary/20"
                        />
                        <button
                            type="submit"
                            className="h-9 rounded-xl border bg-muted px-3 font-bold hover:bg-primary hover:text-primary-foreground transition-colors"
                        >
                            Go
                        </button>
                    </form>
                </div>
            )}
        </div>
    );
};

export default ProductListingPage;
