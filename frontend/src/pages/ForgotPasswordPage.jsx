import React, { useState } from 'react';
import { Link } from 'react-router-dom';
import api from '../api/axios';
import { Mail, ArrowLeft, Loader2, CheckCircle2 } from 'lucide-react';

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
            // In a real app, the token would be in the email.
            // For this demo/dev environment, we might show it or just tell the user to check their email.
            console.log("Reset Token:", response.data.token);
        } catch (err) {
            setError(err.response?.data?.message || 'Something went wrong. Please try again.');
        } finally {
            setLoading(false);
        }
    };

    return (
        <div className="flex min-h-[80vh] items-center justify-center px-4">
            <div className="w-full max-w-md space-y-8 rounded-3xl border bg-card p-10 shadow-2xl">
                <div className="text-center">
                    <h2 className="text-3xl font-extrabold tracking-tight">Forgot Password?</h2>
                    <p className="mt-2 text-muted-foreground">
                        {submitted
                            ? "Check your email for the reset link"
                            : "Enter your email to receive a password reset link"}
                    </p>
                </div>

                {error && (
                    <div className="rounded-xl bg-destructive/10 p-4 text-center text-sm font-medium text-destructive">
                        {error}
                    </div>
                )}

                {submitted ? (
                    <div className="space-y-6 text-center">
                        <div className="flex justify-center">
                            <CheckCircle2 className="h-16 w-16 text-green-500" />
                        </div>
                        <p className="text-sm text-muted-foreground">
                            We've sent a password reset link to <span className="font-bold text-foreground">{email}</span>.
                            Please check your inbox and follow the instructions.
                        </p>
                        <div className="pt-4">
                            <Link
                                to="/login"
                                className="inline-flex items-center gap-2 font-bold text-primary hover:underline"
                            >
                                <ArrowLeft className="h-4 w-4" /> Back to Login
                            </Link>
                        </div>
                    </div>
                ) : (
                    <form className="mt-8 space-y-6" onSubmit={handleSubmit}>
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

                        <button
                            type="submit"
                            disabled={loading}
                            className="flex w-full justify-center rounded-xl bg-primary py-4 text-sm font-bold text-primary-foreground transition-all hover:opacity-90 disabled:opacity-50"
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
                                <ArrowLeft className="h-4 w-4" /> Back to Login
                            </Link>
                        </div>
                    </form>
                )}
            </div>
        </div>
    );
};

export default ForgotPasswordPage;
