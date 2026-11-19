import React, { useState } from 'react';
import { Link } from 'react-router-dom';
import {
    ShoppingBag,
    Mail,
    ArrowRight,
    ShieldCheck,
    CreditCard,
    Truck,
    CheckCircle2,
    Store,
    Heart,
    Package
} from 'lucide-react';

const Footer = () => {
    const [email, setEmail] = useState('');
    const [subscribed, setSubscribed] = useState(false);

    const handleSubscribe = (e) => {
        e.preventDefault();
        if (email.trim()) {
            setSubscribed(true);
            setEmail('');
            setTimeout(() => setSubscribed(false), 5000);
        }
    };

    return (
        <footer className="mt-24 border-t bg-slate-950 text-slate-400">
            {/* Top Perks Bar */}
            <div className="border-b border-slate-800/80 bg-slate-900/50">
                <div className="container mx-auto px-4 py-8">
                    <div className="grid grid-cols-1 gap-6 sm:grid-cols-2 lg:grid-cols-4">
                        <div className="flex items-center gap-4">
                            <div className="flex h-12 w-12 items-center justify-center rounded-2xl bg-blue-600/10 text-blue-400">
                                <Truck className="h-6 w-6" />
                            </div>
                            <div>
                                <h4 className="font-bold text-white text-sm">Free Express Delivery</h4>
                                <p className="text-xs text-slate-400">On all orders above $100</p>
                            </div>
                        </div>

                        <div className="flex items-center gap-4">
                            <div className="flex h-12 w-12 items-center justify-center rounded-2xl bg-emerald-600/10 text-emerald-400">
                                <ShieldCheck className="h-6 w-6" />
                            </div>
                            <div>
                                <h4 className="font-bold text-white text-sm">Secure Checkout</h4>
                                <p className="text-xs text-slate-400">256-bit SSL & Stripe Protection</p>
                            </div>
                        </div>

                        <div className="flex items-center gap-4">
                            <div className="flex h-12 w-12 items-center justify-center rounded-2xl bg-purple-600/10 text-purple-400">
                                <Store className="h-6 w-6" />
                            </div>
                            <div>
                                <h4 className="font-bold text-white text-sm">Verified Merchants</h4>
                                <p className="text-xs text-slate-400">100% authentic curated brands</p>
                            </div>
                        </div>

                        <div className="flex items-center gap-4">
                            <div className="flex h-12 w-12 items-center justify-center rounded-2xl bg-amber-600/10 text-amber-400">
                                <CreditCard className="h-6 w-6" />
                            </div>
                            <div>
                                <h4 className="font-bold text-white text-sm">Flexible Payments</h4>
                                <p className="text-xs text-slate-400">Cards & Cash on Delivery</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div className="container mx-auto px-4 py-16">
                <div className="grid grid-cols-1 gap-12 lg:grid-cols-5">
                    {/* Brand column (2 spans on desktop) */}
                    <div className="space-y-6 lg:col-span-2">
                        <Link to="/" className="flex items-center gap-2.5">
                            <div className="flex h-10 w-10 items-center justify-center rounded-xl bg-blue-600 shadow-md shadow-blue-600/20">
                                <ShoppingBag className="h-5 w-5 text-white" />
                            </div>
                            <span className="text-2xl font-black text-white tracking-tight">ShopStack</span>
                            <span className="text-2xl font-black bg-gradient-to-r from-blue-400 to-emerald-400 bg-clip-text text-transparent">Pro</span>
                        </Link>
                        <p className="max-w-sm text-sm leading-relaxed text-slate-400">
                            Enterprise-grade full-stack e-commerce ecosystem empowering global shoppers and independent merchants with seamless transactions and real-time inventory management.
                        </p>
                        <div className="pt-2 flex items-center gap-3">
                            <span className="inline-flex items-center gap-1.5 rounded-full bg-slate-900 border border-slate-800 px-3 py-1 text-xs font-semibold text-emerald-400">
                                <span className="h-1.5 w-1.5 rounded-full bg-emerald-400 animate-pulse" />
                                All Systems Operational
                            </span>
                        </div>
                    </div>

                    {/* Navigation Columns */}
                    <div className="space-y-4">
                        <h4 className="text-sm font-bold uppercase tracking-wider text-white">Explore Shop</h4>
                        <ul className="space-y-2.5 text-sm">
                            <li>
                                <Link to="/products" className="transition-colors hover:text-white">All Products</Link>
                            </li>
                            <li>
                                <Link to="/products" className="transition-colors hover:text-white">Featured Collections</Link>
                            </li>
                            <li>
                                <Link to="/products" className="transition-colors hover:text-white">New Arrivals</Link>
                            </li>
                            <li>
                                <Link to="/cart" className="transition-colors hover:text-white">Shopping Cart</Link>
                            </li>
                        </ul>
                    </div>

                    <div className="space-y-4">
                        <h4 className="text-sm font-bold uppercase tracking-wider text-white">My Account</h4>
                        <ul className="space-y-2.5 text-sm">
                            <li>
                                <Link to="/profile" className="transition-colors hover:text-white">Customer Profile</Link>
                            </li>
                            <li>
                                <Link to="/orders" className="transition-colors hover:text-white">Order History & Tracking</Link>
                            </li>
                            <li>
                                <Link to="/wishlist" className="transition-colors hover:text-white">Saved Wishlist</Link>
                            </li>
                            <li>
                                <Link to="/login" className="transition-colors hover:text-white">Sign In / Register</Link>
                            </li>
                        </ul>
                    </div>

                    <div className="space-y-4">
                        <h4 className="text-sm font-bold uppercase tracking-wider text-white">Business Portals</h4>
                        <ul className="space-y-2.5 text-sm">
                            <li>
                                <Link to="/register" className="transition-colors hover:text-white">Become a Merchant</Link>
                            </li>
                            <li>
                                <Link to="/seller" className="transition-colors hover:text-white">Merchant Seller Hub</Link>
                            </li>
                            <li>
                                <Link to="/admin" className="transition-colors hover:text-white">Administrator Portal</Link>
                            </li>
                            <li>
                                <a
                                    href="https://shopstack-api.duckdns.org/actuator/health"
                                    target="_blank"
                                    rel="noopener noreferrer"
                                    className="transition-colors hover:text-white"
                                >
                                    Platform API Status
                                </a>
                            </li>
                        </ul>
                    </div>
                </div>

                {/* Newsletter banner strip */}
                <div className="mt-16 rounded-3xl bg-gradient-to-r from-slate-900 via-slate-850 to-slate-900 border border-slate-800 p-8 sm:p-10 flex flex-col lg:flex-row items-center justify-between gap-8">
                    <div className="space-y-2 text-center lg:text-left">
                        <h3 className="text-xl sm:text-2xl font-bold text-white">
                            Get 10% off your first purchase
                        </h3>
                        <p className="text-sm text-slate-400 max-w-md">
                            Subscribe for early access to curated product drops, merchant discounts, and exclusive weekend sales.
                        </p>
                    </div>

                    <form onSubmit={handleSubscribe} className="flex w-full sm:w-auto items-center gap-2">
                        <div className="relative flex-1 sm:w-72">
                            <Mail className="absolute left-3.5 top-1/2 h-4 w-4 -translate-y-1/2 text-slate-500" />
                            <input
                                type="email"
                                required
                                value={email}
                                onChange={(e) => setEmail(e.target.value)}
                                placeholder="Enter your email address"
                                className="w-full rounded-xl border border-slate-700 bg-slate-950/80 py-3 pl-10 pr-4 text-sm text-white placeholder:text-slate-500 focus:border-blue-500 focus:outline-none focus:ring-1 focus:ring-blue-500"
                            />
                        </div>
                        <button
                            type="submit"
                            className="flex items-center gap-1.5 rounded-xl bg-blue-600 px-6 py-3 text-sm font-bold text-white transition-all hover:bg-blue-500 shadow-md shadow-blue-600/30"
                        >
                            Subscribe <ArrowRight className="h-4 w-4" />
                        </button>
                    </form>
                </div>

                {subscribed && (
                    <div className="mt-4 flex items-center justify-center gap-2 text-sm font-semibold text-emerald-400">
                        <CheckCircle2 className="h-4 w-4" />
                        Thank you for subscribing! Check your email for your 10% discount voucher.
                    </div>
                )}
            </div>

            {/* Bottom Bar */}
            <div className="border-t border-slate-850 bg-slate-950/90 py-6">
                <div className="container mx-auto px-4 flex flex-col sm:flex-row items-center justify-between gap-4 text-xs text-slate-500">
                    <p>© 2026 ShopStack Pro. All rights reserved.</p>
                    <div className="flex items-center gap-6">
                        <span className="hover:text-slate-400 cursor-pointer">Privacy Policy</span>
                        <span className="hover:text-slate-400 cursor-pointer">Terms of Service</span>
                        <span className="hover:text-slate-400 cursor-pointer">Security Standards</span>
                        <span className="hover:text-slate-400 cursor-pointer">Cookie Preferences</span>
                    </div>
                </div>
            </div>
        </footer>
    );
};

export default Footer;
