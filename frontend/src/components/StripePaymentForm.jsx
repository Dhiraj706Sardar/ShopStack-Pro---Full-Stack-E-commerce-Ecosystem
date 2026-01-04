import React, { useState } from 'react';
import { CardElement, useStripe, useElements } from '@stripe/react-stripe-js';
import { Loader2, ShieldCheck, AlertCircle } from 'lucide-react';
import api from '../api/axios';

const StripePaymentForm = ({ amount, orderId, onPaymentSuccess, onPaymentError }) => {
    const stripe = useStripe();
    const elements = useElements();
    const [isProcessing, setIsProcessing] = useState(false);
    const [errorMessage, setErrorMessage] = useState('');

    const handleSubmit = async (event) => {
        event.preventDefault();

        if (!stripe || !elements) {
            return;
        }

        setIsProcessing(true);
        setErrorMessage('');

        try {
            // 1. Create Payment Intent on the backend
            const { data } = await api.post('/user/payments/create-intent', {
                amount: Math.round(amount * 100), // Convert to cents
                currency: 'usd',
                orderId: orderId
            });

            const clientSecret = data.clientSecret;

            // 2. Confirm the payment on the frontend
            const result = await stripe.confirmCardPayment(clientSecret, {
                payment_method: {
                    card: elements.getElement(CardElement),
                },
            });

            if (result.error) {
                setErrorMessage(result.error.message);
                onPaymentError(result.error.message);
            } else {
                if (result.paymentIntent.status === 'succeeded') {
                    onPaymentSuccess(result.paymentIntent);
                }
            }
        } catch (error) {
            console.error('Payment error:', error);
            setErrorMessage('An unexpected error occurred during payment.');
            onPaymentError('An unexpected error occurred.');
        } finally {
            setIsProcessing(false);
        }
    };

    return (
        <form onSubmit={handleSubmit} className="space-y-6">
            <div className="rounded-xl border bg-muted/30 p-6">
                <div className="mb-4 flex items-center justify-between">
                    <label className="text-sm font-bold">Card Details</label>
                    <div className="flex items-center gap-1 text-[10px] font-bold text-muted-foreground uppercase tracking-wider">
                        <ShieldCheck className="h-3 w-3 text-green-500" />
                        Secure SSL Encryption
                    </div>
                </div>

                <div className="rounded-lg bg-background p-4 border shadow-sm">
                    <CardElement
                        options={{
                            style: {
                                base: {
                                    fontSize: '16px',
                                    color: '#0f172a',
                                    '::placeholder': {
                                        color: '#94a3b8',
                                    },
                                },
                                invalid: {
                                    color: '#ef4444',
                                },
                            },
                        }}
                    />
                </div>

                {errorMessage && (
                    <div className="mt-4 flex items-center gap-2 rounded-lg bg-red-50 p-3 text-sm font-medium text-red-600">
                        <AlertCircle className="h-4 w-4" />
                        {errorMessage}
                    </div>
                )}
            </div>

            <button
                type="submit"
                disabled={!stripe || isProcessing}
                className="group relative flex w-full justify-center rounded-xl bg-primary py-4 text-lg font-bold text-primary-foreground transition-all hover:opacity-90 disabled:opacity-50 shadow-lg"
            >
                {isProcessing ? (
                    <Loader2 className="h-6 w-6 animate-spin" />
                ) : (
                    `Pay $${amount.toFixed(2)}`
                )}
            </button>

            <p className="text-center text-xs text-muted-foreground">
                By completing this purchase, you agree to our Terms of Service.
            </p>
        </form>
    );
};

export default StripePaymentForm;
