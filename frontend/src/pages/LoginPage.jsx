import React, { useState } from 'react';
import { useNavigate, Link } from 'react-router-dom';
import { useAuth } from '../context/AuthContext';
import { Mail, Lock, ArrowRight, Loader2 } from 'lucide-react';

const LoginPage = () => {
    const [email, setEmail] = useState('');
    const [password, setPassword] = useState('');
    const [error, setError] = useState('');
    const [loading, setLoading] = useState(false);
    const { login } = useAuth();
    const navigate = useNavigate();

    const handleSubmit = async (e) => {
        e.preventDefault();
        setError('');
        setLoading(true);
        try {
            await login(email, password);
            navigate('/');
        } catch (err) {
            setError(err.response?.data?.message || 'Invalid email or password');
        } finally {
            setLoading(false);
        }
    };

    return (
        <div className="flex min-h-[80vh] items-center justify-center">
            <div className="w-full max-w-md space-y-8 rounded-3xl border bg-card p-10 shadow-2xl">
                <div className="text-center">
                    <h2 className="text-3xl font-extrabold tracking-tight">Welcome Back</h2>
                    <p className="mt-2 text-muted-foreground">Please enter your details to sign in</p>
                </div>

                {error && (
                    <div className="rounded-xl bg-destructive/10 p-4 text-center text-sm font-medium text-destructive">
                        {error}
                    </div>
                )}

                <form className="mt-8 space-y-6" onSubmit={handleSubmit}>
                    <div className="space-y-4">
                        <div className="relative">
                            <Mail className="absolute left-3 top-1/2 h-5 w-5 -translate-y-1/2 text-muted-foreground" />
                            <input
                                type="email"
                                required
                                value={email}
                                onChange={(e) => setEmail(e.target.value)}
                                className="block w-full rounded-xl border bg-background py-4 pl-11 pr-4 text-sm transition-all focus:ring-2 focus:ring-primary/20 outline-none"
                                placeholder="Email Address"
                            />
                        </div>
                        <div className="relative">
                            <Lock className="absolute left-3 top-1/2 h-5 w-5 -translate-y-1/2 text-muted-foreground" />
                            <input
                                type="password"
                                required
                                value={password}
                                onChange={(e) => setPassword(e.target.value)}
                                className="block w-full rounded-xl border bg-background py-4 pl-11 pr-4 text-sm transition-all focus:ring-2 focus:ring-primary/20 outline-none"
                                placeholder="Password"
                            />
                        </div>
                        <div className="flex justify-end">
                            <Link
                                to="/forgot-password"
                                className="text-sm font-bold text-primary hover:underline"
                            >
                                Forgot Password?
                            </Link>
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
                                Sign In <ArrowRight className="ml-2 h-5 w-5 transition-transform group-hover:translate-x-1" />
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
    );
};

// Helper component for the icon
const User = ({ className }) => (
    <svg
        xmlns="http://www.w3.org/2000/svg"
        viewBox="0 0 24 24"
        fill="none"
        stroke="currentColor"
        strokeWidth="2"
        strokeLinecap="round"
        strokeLinejoin="round"
        className={className}
    >
        <path d="M19 21v-2a4 4 0 0 0-4-4H9a4 4 0 0 0-4 4v2" />
        <circle cx="12" cy="7" r="4" />
    </svg>
);

export default LoginPage;
