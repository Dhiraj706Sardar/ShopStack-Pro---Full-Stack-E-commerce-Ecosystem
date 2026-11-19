import React, { useState } from 'react';
import { useNavigate, Link } from 'react-router-dom';
import { useAuth } from '../context/AuthContext';
import { Mail, Lock, User, ArrowRight, Loader2, Store, ShoppingBag, Shield, Zap, Star } from 'lucide-react';

const RegisterPage = () => {
    const [formData, setFormData] = useState({
        username: '',
        email: '',
        password: '',
        role: ['user']
    });
    const [selectedRole, setSelectedRole] = useState('user');
    const [error, setError] = useState('');
    const [loading, setLoading] = useState(false);
    const { signup } = useAuth();
    const navigate = useNavigate();

    const handleRoleSelect = (roleName) => {
        setSelectedRole(roleName);
        setFormData({ ...formData, role: [roleName] });
    };

    const handleChange = (e) => {
        setFormData({ ...formData, [e.target.name]: e.target.value });
    };

    const handleSubmit = async (e) => {
        e.preventDefault();
        setError('');
        setLoading(true);
        try {
            const data = await signup(formData.username, formData.email, formData.password, [selectedRole]);
            const roles = data?.roles || [];
            if (roles.includes('ROLE_ADMIN')) {
                navigate('/admin');
            } else if (roles.includes('ROLE_SELLER')) {
                navigate('/seller');
            } else {
                navigate('/');
            }
        } catch (err) {
            setError(err.response?.data?.message || 'Registration failed. Please try again.');
        } finally {
            setLoading(false);
        }
    };

    const passwordStrong = formData.password.length >= 8;

    const roleOptions = [
        {
            key: 'user',
            label: 'Customer',
            description: 'Shop & discover products',
            icon: ShoppingBag,
            activeColor: 'border-blue-500 bg-blue-500/10 text-blue-600',
            iconBg: 'bg-blue-100',
            iconColor: 'text-blue-600',
        },
        {
            key: 'seller',
            label: 'Merchant',
            description: 'Sell & manage your store',
            icon: Store,
            activeColor: 'border-purple-500 bg-purple-500/10 text-purple-600',
            iconBg: 'bg-purple-100',
            iconColor: 'text-purple-600',
        },
    ];

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
                            Start selling or shopping today
                        </h2>
                        <p className="text-slate-400 text-base leading-relaxed">
                            Join thousands of merchants and customers on the platform built for modern commerce.
                        </p>
                    </div>

                    {/* Trust badges */}
                    <div className="w-full space-y-3">
                        <div className="flex items-center gap-4 rounded-2xl bg-white/5 border border-white/10 px-5 py-4">
                            <div className="flex items-center justify-center w-10 h-10 rounded-xl bg-blue-600/20">
                                <Shield className="h-5 w-5 text-blue-400" />
                            </div>
                            <div className="text-left">
                                <p className="text-white text-sm font-semibold">Free to get started</p>
                                <p className="text-slate-400 text-xs">No credit card required to register</p>
                            </div>
                        </div>
                        <div className="flex items-center gap-4 rounded-2xl bg-white/5 border border-white/10 px-5 py-4">
                            <div className="flex items-center justify-center w-10 h-10 rounded-xl bg-indigo-600/20">
                                <Zap className="h-5 w-5 text-indigo-400" />
                            </div>
                            <div className="text-left">
                                <p className="text-white text-sm font-semibold">Set up in minutes</p>
                                <p className="text-slate-400 text-xs">Your store or shopping account, instantly</p>
                            </div>
                        </div>
                        <div className="flex items-center gap-4 rounded-2xl bg-white/5 border border-white/10 px-5 py-4">
                            <div className="flex items-center justify-center w-10 h-10 rounded-xl bg-emerald-600/20">
                                <Star className="h-5 w-5 text-emerald-400" />
                            </div>
                            <div className="text-left">
                                <p className="text-white text-sm font-semibold">Trusted by thousands</p>
                                <p className="text-slate-400 text-xs">Join a growing community of users</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            {/* Right Form Panel */}
            <div className="flex flex-1 items-center justify-center bg-background px-6 py-12">
                <div className="w-full max-w-md space-y-6">
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
                            <h1 className="text-4xl font-black tracking-tight text-foreground">Create account</h1>
                            <p className="text-muted-foreground text-sm">Choose your account type and get started</p>
                        </div>

                        {error && (
                            <div className="rounded-xl bg-destructive/10 p-4 text-center text-sm font-medium text-destructive">
                                {error}
                            </div>
                        )}

                        {/* Role selection */}
                        <div className="space-y-2">
                            <label className="text-xs font-semibold uppercase tracking-wider text-muted-foreground">
                                I want to
                            </label>
                            <div className="grid grid-cols-2 gap-3">
                                {roleOptions.map((opt) => {
                                    const RoleIcon = opt.icon;
                                    return (
                                        <button
                                            key={opt.key}
                                            type="button"
                                            onClick={() => handleRoleSelect(opt.key)}
                                            className={`flex flex-col items-center gap-2 rounded-2xl border-2 p-4 text-center transition-all ${
                                                selectedRole === opt.key
                                                    ? opt.activeColor + ' shadow-sm'
                                                    : 'border-border bg-background hover:bg-muted text-muted-foreground'
                                            }`}
                                        >
                                            <div className={`flex items-center justify-center w-10 h-10 rounded-xl ${selectedRole === opt.key ? opt.iconBg : 'bg-muted'}`}>
                                                <RoleIcon className={`h-5 w-5 ${selectedRole === opt.key ? opt.iconColor : 'text-muted-foreground'}`} />
                                            </div>
                                            <div>
                                                <p className="text-sm font-bold leading-tight">{opt.label}</p>
                                                <p className="text-xs opacity-70 mt-0.5">{opt.description}</p>
                                            </div>
                                        </button>
                                    );
                                })}
                            </div>
                        </div>

                        <form className="space-y-4" onSubmit={handleSubmit}>
                            {/* Username */}
                            <div className="relative">
                                <User className="absolute left-3 top-1/2 h-5 w-5 -translate-y-1/2 text-muted-foreground" />
                                <input
                                    name="username"
                                    type="text"
                                    required
                                    value={formData.username}
                                    onChange={handleChange}
                                    className="block w-full rounded-2xl border bg-background py-4 pl-11 pr-4 text-sm transition-all focus:ring-2 focus:ring-primary/20 outline-none"
                                    placeholder="Username"
                                />
                            </div>

                            {/* Email */}
                            <div className="relative">
                                <Mail className="absolute left-3 top-1/2 h-5 w-5 -translate-y-1/2 text-muted-foreground" />
                                <input
                                    name="email"
                                    type="email"
                                    required
                                    value={formData.email}
                                    onChange={handleChange}
                                    className="block w-full rounded-2xl border bg-background py-4 pl-11 pr-4 text-sm transition-all focus:ring-2 focus:ring-primary/20 outline-none"
                                    placeholder="Email address"
                                />
                            </div>

                            {/* Password + strength bar */}
                            <div className="space-y-2">
                                <div className="relative">
                                    <Lock className="absolute left-3 top-1/2 h-5 w-5 -translate-y-1/2 text-muted-foreground" />
                                    <input
                                        name="password"
                                        type="password"
                                        required
                                        value={formData.password}
                                        onChange={handleChange}
                                        className="block w-full rounded-2xl border bg-background py-4 pl-11 pr-4 text-sm transition-all focus:ring-2 focus:ring-primary/20 outline-none"
                                        placeholder="Password"
                                    />
                                </div>
                                {/* Strength indicator */}
                                {formData.password.length > 0 && (
                                    <div className="space-y-1">
                                        <div className="h-1.5 w-full rounded-full bg-muted overflow-hidden">
                                            <div
                                                className={`h-full rounded-full transition-all duration-300 ${
                                                    passwordStrong ? 'w-full bg-emerald-500' : 'w-1/3 bg-orange-400'
                                                }`}
                                            />
                                        </div>
                                        <p className={`text-xs font-medium ${passwordStrong ? 'text-emerald-600' : 'text-orange-500'}`}>
                                            {passwordStrong ? 'Strong password' : 'Use at least 8 characters'}
                                        </p>
                                    </div>
                                )}
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
                                        Create {selectedRole === 'seller' ? 'Merchant' : 'Customer'} Account
                                        <ArrowRight className="h-5 w-5 transition-transform group-hover:translate-x-1" />
                                    </>
                                )}
                            </button>
                        </form>

                        <div className="text-center text-sm">
                            <span className="text-muted-foreground">Already have an account? </span>
                            <Link to="/login" className="font-bold text-primary hover:underline">
                                Sign in
                            </Link>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    );
};

export default RegisterPage;
