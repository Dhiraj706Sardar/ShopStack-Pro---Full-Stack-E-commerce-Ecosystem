import React, { useState } from 'react';
import { useNavigate, Link } from 'react-router-dom';
import { useAuth } from '../context/AuthContext';
import { Mail, Lock, User, ArrowRight, Loader2, Store, Shield } from 'lucide-react';

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

    return (
        <div className="flex min-h-[80vh] items-center justify-center py-6">
            <div className="w-full max-w-lg space-y-8 rounded-3xl border bg-card p-10 shadow-2xl">
                <div className="text-center">
                    <h2 className="text-3xl font-extrabold tracking-tight">Create Account</h2>
                    <p className="mt-2 text-muted-foreground">Choose your account type and get started</p>
                </div>

                {error && (
                    <div className="rounded-xl bg-destructive/10 p-4 text-center text-sm font-medium text-destructive">
                        {error}
                    </div>
                )}

                <div className="space-y-2">
                    <label className="text-xs font-semibold uppercase tracking-wider text-muted-foreground">
                        Register As
                    </label>
                    <div className="grid grid-cols-3 gap-2">
                        <button
                            type="button"
                            onClick={() => handleRoleSelect('user')}
                            className={`flex flex-col items-center gap-1.5 rounded-xl border p-3 text-center transition-all ${selectedRole === 'user'
                                    ? 'border-primary bg-primary/10 text-primary font-bold shadow-sm'
                                    : 'border-border bg-background hover:bg-muted text-muted-foreground'
                                }`}
                        >
                            <User className="h-5 w-5" />
                            <span className="text-xs">Customer</span>
                        </button>
                        <button
                            type="button"
                            onClick={() => handleRoleSelect('seller')}
                            className={`flex flex-col items-center gap-1.5 rounded-xl border p-3 text-center transition-all ${selectedRole === 'seller'
                                    ? 'border-primary bg-primary/10 text-primary font-bold shadow-sm'
                                    : 'border-border bg-background hover:bg-muted text-muted-foreground'
                                }`}
                        >
                            <Store className="h-5 w-5" />
                            <span className="text-xs">Merchant</span>
                        </button>
                        <button
                            type="button"
                            onClick={() => handleRoleSelect('admin')}
                            className={`flex flex-col items-center gap-1.5 rounded-xl border p-3 text-center transition-all ${selectedRole === 'admin'
                                    ? 'border-primary bg-primary/10 text-primary font-bold shadow-sm'
                                    : 'border-border bg-background hover:bg-muted text-muted-foreground'
                                }`}
                        >
                            <Shield className="h-5 w-5" />
                            <span className="text-xs">Admin</span>
                        </button>
                    </div>
                </div>

                <form className="mt-6 space-y-6" onSubmit={handleSubmit}>
                    <div className="space-y-4">
                        <div className="relative">
                            <User className="absolute left-3 top-1/2 h-5 w-5 -translate-y-1/2 text-muted-foreground" />
                            <input
                                name="username"
                                type="text"
                                required
                                value={formData.username}
                                onChange={handleChange}
                                className="block w-full rounded-xl border bg-background py-4 pl-11 pr-4 text-sm transition-all focus:ring-2 focus:ring-primary/20 outline-none"
                                placeholder="Username"
                            />
                        </div>
                        <div className="relative">
                            <Mail className="absolute left-3 top-1/2 h-5 w-5 -translate-y-1/2 text-muted-foreground" />
                            <input
                                name="email"
                                type="email"
                                required
                                value={formData.email}
                                onChange={handleChange}
                                className="block w-full rounded-xl border bg-background py-4 pl-11 pr-4 text-sm transition-all focus:ring-2 focus:ring-primary/20 outline-none"
                                placeholder="Email Address"
                            />
                        </div>
                        <div className="relative">
                            <Lock className="absolute left-3 top-1/2 h-5 w-5 -translate-y-1/2 text-muted-foreground" />
                            <input
                                name="password"
                                type="password"
                                required
                                value={formData.password}
                                onChange={handleChange}
                                className="block w-full rounded-xl border bg-background py-4 pl-11 pr-4 text-sm transition-all focus:ring-2 focus:ring-primary/20 outline-none"
                                placeholder="Password"
                            />
                        </div>
                    </div>

                    <button
                        type="submit"
                        disabled={loading}
                        className="group relative flex w-full justify-center rounded-xl bg-primary py-4 text-sm font-bold text-primary-foreground transition-all hover:opacity-90 disabled:opacity-50"
                    >
                        {loading ? (
                            <Loader2 className="h-5 w-5 animate-spin" />
                        ) : (
                            <>
                                Create {selectedRole === 'seller' ? 'Merchant' : selectedRole === 'admin' ? 'Admin' : 'Customer'} Account <ArrowRight className="ml-2 h-5 w-5 transition-transform group-hover:translate-x-1" />
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
    );
}


export default RegisterPage;
