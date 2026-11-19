import React, { useState } from 'react';
import { Link } from 'react-router-dom';
import api from '../api/axios';
import { Mail, ArrowLeft, Loader2, CheckCircle2, ShoppingBag, Shield, Zap } from 'lucide-react';

const ForgotPasswordPage = () => {
    const [email, setEmail] = useState('');
    const [loading, setLoading] = useState(false);
    const [message, setMessage] = useState('');
    const [error, setError] = useState('');
    const [submitted, setSubmitted] = useState(false);

    const handleSubmit = async (e) => {
        e.preventDefault();
        setLoading(true);
        setError('');
        setMessage('');
        try {
            const response = await api.post('/auth/forgot-password', { email });
            setMessage(response.data.message);
            setSubmitted(true);
            console.log("Reset Token:", response.data.token);
        } catch (err) {
            setError(err.response?.data?.message || 'Something went wrong. Please try again.');
        } finally {
            setLoading(false);
        }
    };

    return (
        <div className="flex min-h-[calc(100vh-4rem)]">
            {/* Left Brand Panel — hidden on mobile */}
            <div className="hidden lg:flex lg:w-1/2 flex-col items-center justify-center bg-slate-950 px-16 py-12 relative overflow-hidden">
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
                            Account Recovery
                        </h2>
                        <p className="text-slate-400 text-base leading-relaxed">
                            Don't worry, reset instructions will be sent straight to your registered email address.
                        </p>
                    </div>

                    {/* Trust badges */}
                    <div className="w-full space-y-3">
                        <div className="flex items-center gap-4 rounded-2xl bg-white/5 border border-white/10 px-5 py-4">
                            <div className="flex items-center justify-center w-10 h-10 rounded-xl bg-blue-600/20">
                                <Shield className="h-5 w-5 text-blue-400" />
                            </div>
                            <div className="text-left">
                                <p className="text-sm font-bold text-white">Bank-Grade Security</p>
                                <p className="text-xs text-slate-400">Encrypted token reset links</p>
                            </div>
                        </div>
                        <div className="flex items-center gap-4 rounded-2xl bg-white/5 border border-white/10 px-5 py-4">
                            <div className="flex items-center justify-center w-10 h-10 rounded-xl bg-indigo-600/20">
                                <Zap className="h-5 w-5 text-indigo-400" />
                            </div>
                            <div className="text-left">
                                <p className="text-sm font-bold text-white">Instant Delivery</p>
                                <p className="text-xs text-slate-400">Reset email arrives in seconds</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            {/* Right Form Panel */}
            <div className="w-full lg:w-1/2 flex items-center justify-center px-6 py-12 bg-background">
                <div className="w-full max-w-md space-y-8">
                    {/* Mobile logo header */}
                    <div className="flex lg:hidden items-center justify-center gap-2 mb-4">
                        <div className="flex items-center justify-center w-10 h-10 rounded-xl bg-blue-600">
                            <ShoppingBag className="h-6 w-6 text-white" />
                        </div>
                        <span className="text-2xl font-black tracking-tight">ShopStack</span>
                        <span className="text-2xl font-black text-blue-600">Pro</span>
                    </div>

                    <div className="space-y-2">
                        <h2 className="text-3xl font-extrabold tracking-tight">Reset Password</h2>
                        <p className="text-sm text-muted-foreground">
                            {submitted
                                ? "Check your email for the reset instructions"
                                : "Enter your registered email address to receive a secure reset link"}
                        </p>
                    </div>

                    {error && (
                        <div className="rounded-2xl bg-destructive/10 border border-destructive/20 p-4 text-center text-sm font-medium text-destructive">
                            {error}
                        </div>
                    )}

                    {submitted ? (
                        <div className="space-y-6 text-center rounded-3xl border bg-card p-8 shadow-sm">
                            <div className="flex justify-center">
                                <div className="h-16 w-16 rounded-full bg-emerald-100 flex items-center justify-center">
                                    <CheckCircle2 className="h-10 w-10 text-emerald-600" />
                                </div>
                            </div>
                            <p className="text-sm text-muted-foreground leading-relaxed">
                                {message || `We've sent a password reset link to ${email}. Please check your inbox and spam folder.`}
                            </p>
                            <div className="pt-2">
                                <Link
                                    to="/login"
                                    className="inline-flex items-center gap-2 font-bold text-primary hover:underline text-sm"
                                >
                                    <ArrowLeft className="h-4 w-4" /> Back to Sign In
                                </Link>
                            </div>
                        </div>
                    ) : (
                        <form className="space-y-6" onSubmit={handleSubmit}>
                            <div className="relative">
                                <Mail className="absolute left-3 top-1/2 h-5 w-5 -translate-y-1/2 text-muted-foreground" />
                                <input
                                    type="email"
                                    required
                                    value={email}
                                    onChange={(e) => setEmail(e.target.value)}
                                    className="block w-full rounded-2xl border bg-background py-4 pl-11 pr-4 text-sm transition-all focus:ring-2 focus:ring-primary/20 outline-none"
                                    placeholder="Registered Email Address"
                                />
                            </div>

                            <button
                                type="submit"
                                disabled={loading}
                                className="group relative flex w-full items-center justify-center gap-2 rounded-2xl bg-primary py-4 text-sm font-bold text-primary-foreground transition-all hover:opacity-90 disabled:opacity-50 shadow-lg"
                            >
                                {loading ? (
                                    <Loader2 className="h-5 w-5 animate-spin" />
                                ) : (
                                    "Send Reset Link"
                                )}
                            </button>

                            <div className="text-center">
                                <Link
                                    to="/login"
                                    className="inline-flex items-center gap-2 text-sm font-bold text-muted-foreground hover:text-primary transition-colors"
                                >
                                    <ArrowLeft className="h-4 w-4" /> Back to Sign In
                                </Link>
                            </div>
                        </form>
                    )}
                </div>
            </div>
        </div>
    );
};

export default ForgotPasswordPage;
