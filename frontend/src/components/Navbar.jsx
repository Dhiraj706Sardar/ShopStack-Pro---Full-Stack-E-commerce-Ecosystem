import React, { useState, useEffect } from 'react';
import { Link, useNavigate, useLocation } from 'react-router-dom';
import { useAuth } from '../context/AuthContext';
import api from '../api/axios';
import {
    ShoppingCart,
    User,
    LogOut,
    Menu,
    X,
    Search,
    Heart,
    ShoppingBag,
    Store,
    Shield,
    Package
} from 'lucide-react';

const Navbar = () => {
    const { user, logout, isAdmin, isSeller } = useAuth();
    const [cartCount, setCartCount] = useState(0);
    const [mobileMenuOpen, setMobileMenuOpen] = useState(false);
    const [searchQuery, setSearchQuery] = useState('');
    const navigate = useNavigate();
    const location = useLocation();

    // Close mobile menu on route change
    useEffect(() => {
        setMobileMenuOpen(false);
    }, [location.pathname]);

    // Fetch cart item count for customers
    useEffect(() => {
        if (user && !isAdmin() && !isSeller()) {
            fetchCartCount();
        } else {
            setCartCount(0);
        }
    }, [user, location.pathname]);

    const fetchCartCount = async () => {
        try {
            const res = await api.get('/user/cart');
            const items = res.data?.items || [];
            const count = items.reduce((sum, item) => sum + (item.quantity || 1), 0);
            setCartCount(count);
        } catch {
            // Cart might be empty or 404 for new users
            setCartCount(0);
        }
    };

    const handleLogout = () => {
        logout();
        navigate('/login');
    };

    const handleSearchSubmit = (e) => {
        e.preventDefault();
        if (searchQuery.trim()) {
            navigate(`/products?search=${encodeURIComponent(searchQuery.trim())}`);
        }
    };

    const roles = user?.roles || [];
    let roleBadge = null;
    if (roles.includes('ROLE_ADMIN')) {
        roleBadge = { label: 'Admin', color: 'bg-red-500/10 text-red-600 border-red-500/20' };
    } else if (roles.includes('ROLE_SELLER')) {
        roleBadge = { label: 'Merchant', color: 'bg-purple-500/10 text-purple-600 border-purple-500/20' };
    } else if (user) {
        roleBadge = { label: 'Customer', color: 'bg-blue-500/10 text-blue-600 border-blue-500/20' };
    }

    return (
        <nav className="sticky top-0 z-50 w-full border-b bg-background/95 backdrop-blur supports-[backdrop-filter]:bg-background/80 shadow-sm">
            <div className="container mx-auto px-4 flex h-16 items-center justify-between">
                {/* Left: Brand Logo & Main Navigation */}
                <div className="flex items-center gap-8">
                    <Link to="/" className="flex items-center gap-2 group">
                        <div className="flex h-9 w-9 items-center justify-center rounded-xl bg-blue-600 text-white shadow-md shadow-blue-600/30 transition-transform group-hover:scale-105">
                            <ShoppingBag className="h-5 w-5" />
                        </div>
                        <div className="flex items-baseline">
                            <span className="text-xl font-black tracking-tight text-foreground">ShopStack</span>
                            <span className="text-xl font-black bg-gradient-to-r from-blue-500 to-indigo-600 bg-clip-text text-transparent ml-0.5">Pro</span>
                        </div>
                    </Link>

                    <div className="hidden md:flex items-center gap-6">
                        {(!user || (!isAdmin() && !isSeller())) && (
                            <Link to="/products" className="text-sm font-semibold text-muted-foreground hover:text-foreground transition-colors">
                                Products
                            </Link>
                        )}
                        {user && !isAdmin() && !isSeller() && (
                            <>
                                <Link to="/wishlist" className="text-sm font-semibold text-muted-foreground hover:text-foreground transition-colors flex items-center gap-1.5">
                                    <Heart className="h-4 w-4" /> Wishlist
                                </Link>
                                <Link to="/orders" className="text-sm font-semibold text-muted-foreground hover:text-foreground transition-colors">
                                    Orders
                                </Link>
                            </>
                        )}
                        {isAdmin() && (
                            <Link to="/admin" className="text-sm font-semibold text-red-600 hover:text-red-700 transition-colors flex items-center gap-1.5">
                                <Shield className="h-4 w-4" /> Admin Portal
                            </Link>
                        )}
                        {isSeller() && (
                            <Link to="/seller" className="text-sm font-semibold text-purple-600 hover:text-purple-700 transition-colors flex items-center gap-1.5">
                                <Store className="h-4 w-4" /> Merchant Hub
                            </Link>
                        )}
                    </div>
                </div>

                {/* Right: Search, Cart, Profile, Menu Toggle */}
                <div className="flex items-center gap-3">
                    <form onSubmit={handleSearchSubmit} className="relative hidden md:block">
                        <Search className="absolute left-3 top-1/2 -translate-y-1/2 h-4 w-4 text-muted-foreground" />
                        <input
                            type="search"
                            value={searchQuery}
                            onChange={(e) => setSearchQuery(e.target.value)}
                            placeholder="Search products..."
                            className="h-9 w-60 rounded-xl border border-input bg-muted/40 px-9 py-1 text-xs focus:bg-background focus:ring-2 focus:ring-primary/20 outline-none transition-all"
                        />
                    </form>

                    {/* Cart Icon with Counter */}
                    {(!user || (!isAdmin() && !isSeller())) && (
                        <Link
                            to="/cart"
                            className="relative p-2 hover:bg-muted rounded-xl transition-colors text-foreground"
                            aria-label="Shopping Cart"
                        >
                            <ShoppingCart className="h-5 w-5" />
                            {cartCount > 0 && (
                                <span className="absolute -top-1 -right-1 flex h-5 w-5 items-center justify-center rounded-full bg-blue-600 text-[10px] font-bold text-white shadow-md animate-in zoom-in-50">
                                    {cartCount > 99 ? '99+' : cartCount}
                                </span>
                            )}
                        </Link>
                    )}

                    {/* User profile / Auth actions */}
                    {user ? (
                        <div className="flex items-center gap-2 sm:gap-3">
                            {roleBadge && (
                                <span className={`hidden sm:inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-bold border ${roleBadge.color}`}>
                                    {roleBadge.label}
                                </span>
                            )}
                            <Link
                                to="/profile"
                                className="flex items-center gap-2 p-1 hover:bg-muted rounded-xl transition-colors"
                                title="My Profile"
                            >
                                <div className="h-8 w-8 rounded-full overflow-hidden bg-primary/10 border border-primary/20 flex items-center justify-center">
                                    {user.profileImageUrl ? (
                                        <img src={user.profileImageUrl} alt="avatar" className="h-full w-full object-cover" />
                                    ) : (
                                        <User className="h-4 w-4 text-primary" />
                                    )}
                                </div>
                            </Link>

                            <button
                                onClick={handleLogout}
                                title="Sign Out"
                                className="p-2 hover:bg-red-50 text-red-500 hover:text-red-600 rounded-xl transition-colors"
                            >
                                <LogOut className="h-5 w-5" />
                            </button>
                        </div>
                    ) : (
                        <div className="flex items-center gap-2">
                            <Link
                                to="/login"
                                className="rounded-xl px-4 py-2 text-xs font-bold text-foreground hover:bg-muted transition-colors"
                            >
                                Sign In
                            </Link>
                            <Link
                                to="/register"
                                className="hidden sm:inline-flex rounded-xl bg-primary px-4 py-2 text-xs font-bold text-primary-foreground hover:opacity-90 transition-opacity shadow-sm"
                            >
                                Get Started
                            </Link>
                        </div>
                    )}

                    {/* Mobile Hamburger Button */}
                    <button
                        onClick={() => setMobileMenuOpen(!mobileMenuOpen)}
                        className="p-2 md:hidden hover:bg-muted rounded-xl text-foreground transition-colors"
                        aria-label="Toggle Navigation Menu"
                    >
                        {mobileMenuOpen ? <X className="h-6 w-6" /> : <Menu className="h-6 w-6" />}
                    </button>
                </div>
            </div>

            {/* Mobile Navigation Drawer */}
            {mobileMenuOpen && (
                <div className="md:hidden border-t bg-background px-4 py-6 space-y-4 animate-in slide-in-from-top-2">
                    <form onSubmit={handleSearchSubmit} className="relative">
                        <Search className="absolute left-3 top-1/2 -translate-y-1/2 h-4 w-4 text-muted-foreground" />
                        <input
                            type="search"
                            value={searchQuery}
                            onChange={(e) => setSearchQuery(e.target.value)}
                            placeholder="Search products..."
                            className="h-10 w-full rounded-xl border border-input bg-muted/40 px-9 py-2 text-sm focus:bg-background outline-none"
                        />
                    </form>

                    <div className="flex flex-col space-y-2 pt-2">
                        {(!user || (!isAdmin() && !isSeller())) && (
                            <Link
                                to="/products"
                                className="flex items-center gap-3 px-3 py-2.5 rounded-xl font-medium text-foreground hover:bg-muted transition-colors"
                            >
                                <Package className="h-4 w-4 text-blue-500" /> Products
                            </Link>
                        )}
                        {user && !isAdmin() && !isSeller() && (
                            <>
                                <Link
                                    to="/wishlist"
                                    className="flex items-center gap-3 px-3 py-2.5 rounded-xl font-medium text-foreground hover:bg-muted transition-colors"
                                >
                                    <Heart className="h-4 w-4 text-rose-500" /> Wishlist
                                </Link>
                                <Link
                                    to="/orders"
                                    className="flex items-center gap-3 px-3 py-2.5 rounded-xl font-medium text-foreground hover:bg-muted transition-colors"
                                >
                                    <ShoppingBag className="h-4 w-4 text-emerald-500" /> Orders
                                </Link>
                            </>
                        )}
                        {isAdmin() && (
                            <Link
                                to="/admin"
                                className="flex items-center gap-3 px-3 py-2.5 rounded-xl font-medium text-red-600 hover:bg-red-50 transition-colors"
                            >
                                <Shield className="h-4 w-4" /> Admin Portal
                            </Link>
                        )}
                        {isSeller() && (
                            <Link
                                to="/seller"
                                className="flex items-center gap-3 px-3 py-2.5 rounded-xl font-medium text-purple-600 hover:bg-purple-50 transition-colors"
                            >
                                <Store className="h-4 w-4" /> Merchant Hub
                            </Link>
                        )}
                        {user && (
                            <Link
                                to="/profile"
                                className="flex items-center gap-3 px-3 py-2.5 rounded-xl font-medium text-foreground hover:bg-muted transition-colors"
                            >
                                <User className="h-4 w-4 text-slate-500" /> My Profile
                            </Link>
                        )}
                    </div>
                </div>
            )}
        </nav>
    );
};

export default Navbar;
