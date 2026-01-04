import React, { useState, useEffect } from 'react';
import { useNavigate, useSearchParams, Link } from 'react-router-dom';
import api from '../api/axios';
import { Lock, ArrowRight, Loader2, CheckCircle2, AlertCircle } from 'lucide-react';

const ResetPasswordPage = () => {
    const [searchParams] = useSearchParams();
    const token = searchParams.get('token');
    const [password, setPassword] = useState('');
    const [confirmPassword, setConfirmPassword] = useState('');
    const [loading, setLoading] = useState(false);
    const [error, setError] = useState('');
    const [success, setSuccess] = useState(false);
    const navigate = useNavigate();

    useEffect(() => {
        if (!token) {
            setError('Invalid or missing reset token.');
        }
    }, [token]);

    const handleSubmit = async (e) => {
        e.preventDefault();
        if (password !== confirmPassword) {
            setError('Passwords do not match');
            return;
        }
        if (password.length < 6) {
            setError('Password must be at least 6 characters long');
            return;
        }

        setLoading(true);
        setError('');
        try {
            await api.post('/auth/reset-password', {
                token,
                newPassword: password
            });
            setSuccess(true);
            setTimeout(() => {
                navigate('/login');
            }, 3000);
        } catch (err) {
            setError(err.response?.data?.message || 'Failed to reset password. The link may have expired.');
        } finally {
            setLoading(false);
        }
    };

    if (success) {
        return (
            <div className="flex min-h-[80vh] items-center justify-center px-4">
                <div className="w-full max-w-md space-y-6 rounded-3xl border bg-card p-10 shadow-2xl text-center">
                    <div className="flex justify-center">
                        <CheckCircle2 className="h-16 w-16 text-green-500" />
                    </div>
                    <h2 className="text-3xl font-extrabold tracking-tight">Password Reset!</h2>
                    <p className="text-muted-foreground">
                        Your password has been successfully updated. Redirecting you to login...
                    </p>
                    <div className="pt-4">
                        <Link to="/login" className="admin-btn-primary w-full justify-center">
                            Go to Login Now
                        </Link>
                    </div>
                </div>
            </div>
        );
    }

    return (
        <div className="flex min-h-[80vh] items-center justify-center px-4">
            <div className="w-full max-w-md space-y-8 rounded-3xl border bg-card p-10 shadow-2xl">
                <div className="text-center">
                    <h2 className="text-3xl font-extrabold tracking-tight">Reset Password</h2>
                    <p className="mt-2 text-muted-foreground">Enter your new secure password</p>
                </div>

                {error && (
                    <div className="flex items-center gap-2 rounded-xl bg-destructive/10 p-4 text-sm font-medium text-destructive">
                        <AlertCircle className="h-4 w-4 shrink-0" />
                        <p>{error}</p>
                    </div>
                )}

                <form className="mt-8 space-y-6" onSubmit={handleSubmit}>
                    <div className="space-y-4">
                        <div className="relative">
                            <Lock className="absolute left-3 top-1/2 h-5 w-5 -translate-y-1/2 text-muted-foreground" />
                            <input
                                type="password"
                                required
                                value={password}
                                onChange={(e) => setPassword(e.target.value)}
                                className="block w-full rounded-xl border bg-background py-4 pl-11 pr-4 text-sm transition-all focus:ring-2 focus:ring-primary/20 outline-none"
                                placeholder="New Password"
                            />
                        </div>
                        <div className="relative">
                            <Lock className="absolute left-3 top-1/2 h-5 w-5 -translate-y-1/2 text-muted-foreground" />
                            <input
                                type="password"
                                required
                                value={confirmPassword}
                                onChange={(e) => setConfirmPassword(e.target.value)}
                                className="block w-full rounded-xl border bg-background py-4 pl-11 pr-4 text-sm transition-all focus:ring-2 focus:ring-primary/20 outline-none"
                                placeholder="Confirm New Password"
                            />
                        </div>
                    </div>

                    <button
                        type="submit"
                        disabled={loading || !token}
                        className="group relative flex w-full justify-center rounded-xl bg-primary py-4 text-sm font-bold text-primary-foreground transition-all hover:opacity-90 disabled:opacity-50"
                    >
                        {loading ? (
                            <Loader2 className="h-5 w-5 animate-spin" />
                        ) : (
                            <>
                                Reset Password <ArrowRight className="ml-2 h-5 w-5 transition-transform group-hover:translate-x-1" />
                            </>
                        )}
                    </button>
                </form>
            </div>
        </div>
    );
};

export default ResetPasswordPage;
