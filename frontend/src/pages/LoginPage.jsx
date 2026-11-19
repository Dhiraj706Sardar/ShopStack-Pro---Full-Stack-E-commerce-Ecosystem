import React, { useState } from 'react';
import { useNavigate, useLocation, Link } from 'react-router-dom';
import { useAuth } from '../context/AuthContext';
import { Mail, Lock, ArrowRight, Loader2, Eye, EyeOff, ShoppingBag, Shield, Zap, Star } from 'lucide-react';

const LoginPage = () => {
    const [email, setEmail] = useState('');
    const [password, setPassword] = useState('');
    const [error, setError] = useState('');
    const [loading, setLoading] = useState(false);
    const [showPassword, setShowPassword] = useState(false);
    const { login } = useAuth();
    const navigate = useNavigate();
    const location = useLocation();

    const handleSubmit = async (e) => {
        e.preventDefault();
        setError('');
        setLoading(true);
        try {
            const userData = await login(email, password);
            const redirectPath = location.state?.from?.pathname;
            if (redirectPath && redirectPath !== '/') {
                navigate(redirectPath);
            } else if (userData?.roles?.includes('ROLE_ADMIN')) {
                navigate('/admin');
            } else if (userData?.roles?.includes('ROLE_SELLER')) {
                navigate('/seller');
            } else {
                navigate('/');
            }
        } catch (err) {
            setError(err.response?.data?.message || 'Invalid email or password');
        } finally {
            setLoading(false);
        }
    };

    return (
        <div className="flex min-h-[calc(100vh-4rem)]">
            {/* Left Brand Panel — hidden on mobile */}
            <div className="hidden lg:flex lg:w-1/2 flex-col items-center justify-center bg-slate-950 px-16 py-12 relative overflow-hidden">
                {/* Background decorative circles */}
                <div className="absolute top-[-80px] left-[-80px] w-80 h-80 rounded-full bg-blue-600/10 blur-3xl" />
                <div className="absolute bottom-[-60px] right-[-60px] w-96 h-96 rounded-full bg-indigo-600/10 blur-3xl" />

                <div className="relative z-10 flex flex-col items-center text-center space-y-10 max-w-sm">
                    {/* Logo */}
                    <div className="flex items-center gap-3">
                        <div className="flex items-center justify-center w-14 h-14 rounded-2xl bg-blue-600 shadow-lg shadow-blue-600/30">
                            <ShoppingBag className="h-8 w-8 text-white" />
                        </div>
                        <div className="flex items-baseline gap-1">
                            <span className="text-4xl font-black text-white tracking-tight">ShopStack</span>
                            <span className="text-4xl font-black bg-gradient-to-r from-blue-400 to-indigo-400 bg-clip-text text-transparent">Pro</span>
                        </div>
                    </div>

                    {/* Tagline */}
                    <div className="space-y-3">
                        <h2 className="text-2xl font-bold text-white leading-snug">
                            Your complete e-commerce ecosystem
                        </h2>
                        <p className="text-slate-400 text-base leading-relaxed">
                            Manage products, orders, and customers from one powerful platform built for growth.
                        </p>
                    </div>

                    {/* Trust badges */}
                    <div className="w-full space-y-3">
                        <div className="flex items-center gap-4 rounded-2xl bg-white/5 border border-white/10 px-5 py-4">
                            <div className="flex items-center justify-center w-10 h-10 rounded-xl bg-blue-600/20">
                                <Shield className="h-5 w-5 text-blue-400" />
                            </div>
                            <div className="text-left">
                                <p className="text-white text-sm font-semibold">Enterprise-grade Security</p>
                                <p className="text-slate-400 text-xs">JWT-secured, role-based access control</p>
                            </div>
                        </div>
                        <div className="flex items-center gap-4 rounded-2xl bg-white/5 border border-white/10 px-5 py-4">
                            <div className="flex items-center justify-center w-10 h-10 rounded-xl bg-indigo-600/20">
                                <Zap className="h-5 w-5 text-indigo-400" />
                            </div>
                            <div className="text-left">
                                <p className="text-white text-sm font-semibold">Lightning Fast Performance</p>
                                <p className="text-slate-400 text-xs">Optimized for speed at every step</p>
                            </div>
                        </div>
                        <div className="flex items-center gap-4 rounded-2xl bg-white/5 border border-white/10 px-5 py-4">
                            <div className="flex items-center justify-center w-10 h-10 rounded-xl bg-emerald-600/20">
                                <Star className="h-5 w-5 text-emerald-400" />
                            </div>
                            <div className="text-left">
                                <p className="text-white text-sm font-semibold">Trusted by Merchants</p>
                                <p className="text-slate-400 text-xs">Powering stores of all sizes globally</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            {/* Right Form Panel */}
            <div className="flex flex-1 items-center justify-center bg-background px-6 py-12">
                <div className="w-full max-w-md space-y-8">
                    {/* Mobile logo */}
                    <div className="flex lg:hidden items-center justify-center gap-2 mb-2">
                        <div className="flex items-center justify-center w-10 h-10 rounded-xl bg-blue-600 shadow-md">
                            <ShoppingBag className="h-6 w-6 text-white" />
                        </div>
                        <div className="flex items-baseline gap-1">
                            <span className="text-2xl font-black text-foreground">ShopStack</span>
                            <span className="text-2xl font-black bg-gradient-to-r from-blue-500 to-indigo-500 bg-clip-text text-transparent">Pro</span>
                        </div>
                    </div>

                    {/* Card */}
                    <div className="rounded-3xl bg-card border shadow-2xl px-8 py-10 space-y-6">
                        <div className="text-center space-y-1">
                            <h1 className="text-4xl font-black tracking-tight text-foreground">Welcome back</h1>
                            <p className="text-muted-foreground text-sm">Sign in to your account to continue</p>
                        </div>

                        {error && (
                            <div className="rounded-xl bg-destructive/10 p-4 text-center text-sm font-medium text-destructive">
                                {error}
                            </div>
                        )}

                        <form className="space-y-4" onSubmit={handleSubmit}>
                            {/* Email */}
                            <div className="relative">
                                <Mail className="absolute left-3 top-1/2 h-5 w-5 -translate-y-1/2 text-muted-foreground" />
                                <input
                                    type="email"
                                    required
                                    value={email}
                                    onChange={(e) => setEmail(e.target.value)}
                                    className="block w-full rounded-2xl border bg-background py-4 pl-11 pr-4 text-sm transition-all focus:ring-2 focus:ring-primary/20 outline-none"
                                    placeholder="Email address"
                                />
                            </div>

                            {/* Password */}
                            <div className="relative">
                                <Lock className="absolute left-3 top-1/2 h-5 w-5 -translate-y-1/2 text-muted-foreground" />
                                <input
                                    type={showPassword ? 'text' : 'password'}
                                    required
                                    value={password}
                                    onChange={(e) => setPassword(e.target.value)}
                                    className="block w-full rounded-2xl border bg-background py-4 pl-11 pr-11 text-sm transition-all focus:ring-2 focus:ring-primary/20 outline-none"
                                    placeholder="Password"
                                />
                                <button
                                    type="button"
                                    onClick={() => setShowPassword(!showPassword)}
                                    className="absolute right-3 top-1/2 -translate-y-1/2 text-muted-foreground hover:text-foreground transition-colors"
                                >
                                    {showPassword ? <EyeOff className="h-5 w-5" /> : <Eye className="h-5 w-5" />}
                                </button>
                            </div>

                            {/* Forgot password */}
                            <div className="flex justify-end">
                                <Link
                                    to="/forgot-password"
                                    className="text-sm font-bold text-primary hover:underline"
                                >
                                    Forgot password?
                                </Link>
                            </div>

                            {/* Submit */}
                            <button
                                type="submit"
                                disabled={loading}
                                className="group relative flex w-full items-center justify-center gap-2 rounded-2xl bg-primary py-4 text-sm font-bold text-primary-foreground transition-all hover:opacity-90 disabled:opacity-50"
                            >
                                {loading ? (
                                    <Loader2 className="h-5 w-5 animate-spin" />
                                ) : (
                                    <>
                                        Sign In
                                        <ArrowRight className="h-5 w-5 transition-transform group-hover:translate-x-1" />
                                    </>
                                )}
                            </button>
                        </form>

                        <div className="text-center text-sm">
                            <span className="text-muted-foreground">Don't have an account? </span>
                            <Link to="/register" className="font-bold text-primary hover:underline">
                                Sign up for free
                            </Link>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    );
};

export default LoginPage;
