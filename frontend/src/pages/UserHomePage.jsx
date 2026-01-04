import React, { useState, useEffect } from 'react';
import { Link } from 'react-router-dom';
import api from '../api/axios';
import {
    ShoppingBag,
    ArrowRight,
    Star,
    Truck,
    ShieldCheck,
    Zap,
    LayoutGrid,
    Flame,
    Sparkles
} from 'lucide-react';

const UserHomePage = () => {
    const [featuredProducts, setFeaturedProducts] = useState([]);
    const [categories, setCategories] = useState([]);
    const [loading, setLoading] = useState(true);

    useEffect(() => {
        fetchHomeData();
    }, []);

    const fetchHomeData = async () => {
        try {
            const [productsRes, categoriesRes] = await Promise.all([
                api.get('/public/products'),
                api.get('/public/categories')
            ]);
            setFeaturedProducts(productsRes.data.content.slice(0, 4));
            setCategories(categoriesRes.data.slice(0, 6));
        } catch (error) {
            console.error('Error fetching home data:', error);
        } finally {
            setLoading(false);
        }
    };

    if (loading) {
        return (
            <div className="flex h-[80vh] items-center justify-center">
                <div className="h-12 w-12 animate-spin rounded-full border-4 border-primary border-t-transparent"></div>
            </div>
        );
    }

    return (
        <div className="flex flex-col gap-20 pb-20">
            {/* Hero Section */}
            <section className="relative overflow-hidden rounded-[3rem] bg-slate-950 px-8 py-24 text-white md:px-20">
                <div className="relative z-10 grid grid-cols-1 items-center gap-12 lg:grid-cols-2">
                    <div className="flex flex-col gap-8">
                        <div className="inline-flex w-fit items-center gap-2 rounded-full bg-white/10 px-4 py-2 text-sm font-medium backdrop-blur-md">
                            <Sparkles className="h-4 w-4 text-yellow-400" />
                            New Season Arrivals
                        </div>
                        <h1 className="text-5xl font-black tracking-tight md:text-7xl">
                            Elevate Your <span className="bg-gradient-to-r from-blue-400 to-emerald-400 bg-clip-text text-transparent">Lifestyle</span>
                        </h1>
                        <p className="max-w-lg text-lg text-slate-400 md:text-xl">
                            Discover our curated collection of premium products designed for the modern individual.
                            Quality meets style in every detail.
                        </p>
                        <div className="flex flex-wrap gap-4">
                            <Link
                                to="/products"
                                className="group flex items-center gap-2 rounded-full bg-white px-8 py-4 text-lg font-bold text-slate-950 transition-all hover:scale-105 hover:bg-blue-50"
                            >
                                Shop Catalog <ArrowRight className="h-5 w-5 transition-transform group-hover:translate-x-1" />
                            </Link>
                            <Link
                                to="/products"
                                className="flex items-center gap-2 rounded-full border border-white/20 bg-white/5 px-8 py-4 text-lg font-bold text-white backdrop-blur-md transition-all hover:bg-white/10"
                            >
                                View Trends
                            </Link>
                        </div>
                    </div>
                    <div className="relative hidden lg:block">
                        <div className="aspect-square rounded-[3rem] bg-gradient-to-br from-blue-600/20 to-emerald-600/20 p-8">
                            <div className="h-full w-full rounded-[2rem] bg-slate-900 shadow-2xl overflow-hidden relative group">
                                <img
                                    src="https://images.unsplash.com/photo-1523275335684-37898b6baf30?auto=format&fit=crop&q=80&w=1000"
                                    alt="Featured"
                                    className="h-full w-full object-cover transition-transform duration-700 group-hover:scale-110"
                                />
                                <div className="absolute inset-0 bg-gradient-to-t from-slate-950/80 to-transparent flex flex-col justify-end p-8">
                                    <p className="text-sm font-bold text-blue-400">Featured Product</p>
                                    <h3 className="text-2xl font-bold">Premium Smart Watch</h3>
                                    <p className="text-slate-300">$299.00</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                {/* Background Blobs */}
                <div className="absolute -right-20 -top-20 h-96 w-96 rounded-full bg-blue-600/20 blur-[100px]" />
                <div className="absolute -left-20 -bottom-20 h-96 w-96 rounded-full bg-emerald-600/20 blur-[100px]" />
            </section>

            {/* Features */}
            <section className="grid grid-cols-1 gap-8 md:grid-cols-3">
                <FeatureCard
                    icon={<Truck className="h-8 w-8" />}
                    title="Free Shipping"
                    description="On all orders over $100. Fast and reliable delivery to your doorstep."
                />
                <FeatureCard
                    icon={<ShieldCheck className="h-8 w-8" />}
                    title="Secure Payment"
                    description="Your data is protected by industry-leading encryption and Stripe security."
                />
                <FeatureCard
                    icon={<Zap className="h-8 w-8" />}
                    title="Instant Support"
                    description="24/7 customer service ready to help you with any questions or issues."
                />
            </section>

            {/* Categories */}
            <section className="space-y-8">
                <div className="flex items-center justify-between">
                    <div>
                        <h2 className="text-3xl font-black tracking-tight">Shop by Category</h2>
                        <p className="text-muted-foreground">Find exactly what you're looking for</p>
                    </div>
                    <Link to="/products" className="group flex items-center gap-2 font-bold text-primary">
                        View All <ArrowRight className="h-4 w-4 transition-transform group-hover:translate-x-1" />
                    </Link>
                </div>
                <div className="grid grid-cols-2 gap-4 md:grid-cols-3 lg:grid-cols-6">
                    {categories.map((category) => (
                        <Link
                            key={category.id}
                            to={`/products?category=${category.id}`}
                            className="group flex flex-col items-center gap-4 rounded-3xl border bg-card p-6 transition-all hover:border-primary hover:shadow-xl hover:-translate-y-1"
                        >
                            <div className="rounded-2xl bg-muted p-4 transition-colors group-hover:bg-primary/10 group-hover:text-primary">
                                <LayoutGrid className="h-8 w-8" />
                            </div>
                            <span className="text-center font-bold">{category.name}</span>
                        </Link>
                    ))}
                </div>
            </section>

            {/* Featured Products */}
            <section className="space-y-8">
                <div className="flex items-center justify-between">
                    <div className="flex items-center gap-3">
                        <Flame className="h-8 w-8 text-orange-500" />
                        <h2 className="text-3xl font-black tracking-tight">Trending Now</h2>
                    </div>
                    <Link to="/products" className="group flex items-center gap-2 font-bold text-primary">
                        Shop All <ArrowRight className="h-4 w-4 transition-transform group-hover:translate-x-1" />
                    </Link>
                </div>
                <div className="grid grid-cols-1 gap-8 sm:grid-cols-2 lg:grid-cols-4">
                    {featuredProducts.map((product) => (
                        <Link key={product.id} to={`/products/${product.id}`} className="group">
                            <div className="relative aspect-[4/5] overflow-hidden rounded-[2rem] border bg-card shadow-sm transition-all group-hover:shadow-2xl group-hover:-translate-y-2">
                                <img
                                    src={product.imageUrl}
                                    alt={product.name}
                                    className="h-full w-full object-cover transition-transform duration-500 group-hover:scale-110"
                                />
                                <div className="absolute top-4 right-4 rounded-full bg-white/90 px-3 py-1 text-xs font-bold text-slate-950 backdrop-blur-sm">
                                    ${product.price}
                                </div>
                                <div className="absolute inset-0 bg-gradient-to-t from-slate-950/60 to-transparent opacity-0 transition-opacity group-hover:opacity-100 flex flex-col justify-end p-6">
                                    <button className="w-full rounded-xl bg-white py-3 font-bold text-slate-950 shadow-lg">
                                        Quick View
                                    </button>
                                </div>
                            </div>
                            <div className="mt-4 px-2">
                                <h3 className="font-bold text-lg group-hover:text-primary transition-colors">{product.name}</h3>
                                <div className="flex items-center gap-1 text-yellow-500">
                                    <Star className="h-4 w-4 fill-current" />
                                    <Star className="h-4 w-4 fill-current" />
                                    <Star className="h-4 w-4 fill-current" />
                                    <Star className="h-4 w-4 fill-current" />
                                    <Star className="h-4 w-4 fill-current" />
                                    <span className="ml-1 text-xs font-bold text-muted-foreground">(48 reviews)</span>
                                </div>
                            </div>
                        </Link>
                    ))}
                </div>
            </section>

            {/* Newsletter / CTA */}
            <section className="rounded-[3rem] bg-blue-600 px-8 py-16 text-center text-white md:px-20">
                <div className="mx-auto max-w-2xl space-y-8">
                    <h2 className="text-4xl font-black">Don't miss out on the best deals</h2>
                    <p className="text-blue-100 text-lg">
                        Subscribe to our newsletter and get 10% off your first purchase.
                        Stay updated with new arrivals and exclusive offers.
                    </p>
                    <div className="flex flex-col gap-4 sm:flex-row">
                        <input
                            type="email"
                            placeholder="Enter your email"
                            className="flex-1 rounded-full border-none bg-white/20 px-8 py-4 text-white placeholder:text-blue-200 outline-none focus:ring-2 focus:ring-white/50 backdrop-blur-md"
                        />
                        <button className="rounded-full bg-white px-10 py-4 font-bold text-blue-600 transition-transform hover:scale-105 active:scale-95 shadow-xl">
                            Subscribe
                        </button>
                    </div>
                </div>
            </section>
        </div>
    );
};

const FeatureCard = ({ icon, title, description }) => (
    <div className="rounded-[2rem] border bg-card p-8 shadow-sm transition-all hover:shadow-md">
        <div className="mb-6 rounded-2xl bg-primary/5 p-4 text-primary w-fit">
            {icon}
        </div>
        <h3 className="mb-2 text-xl font-bold">{title}</h3>
        <p className="text-muted-foreground leading-relaxed">{description}</p>
    </div>
);

export default UserHomePage;
