import React, { useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import api from '../api/axios';
import { CreditCard, MapPin, Truck, CheckCircle2, Loader2, ArrowLeft, ShoppingBag, DollarSign } from 'lucide-react';
import { loadStripe } from '@stripe/stripe-js';
import { Elements } from '@stripe/react-stripe-js';
import StripePaymentForm from '../components/StripePaymentForm';

const stripePromise = loadStripe(import.meta.env.VITE_STRIPE_PUBLISHABLE_KEY);

const CheckoutPage = () => {
    const [shippingAddress, setShippingAddress] = useState('');
    const [loading, setLoading] = useState(false);
    const [success, setSuccess] = useState(false);
    const [orderData, setOrderData] = useState(null);
    const [cartTotal, setCartTotal] = useState(0);
    const [step, setStep] = useState('address'); // 'address' or 'payment'
    const [paymentMethod, setPaymentMethod] = useState('card'); // 'card' or 'cod'
    const navigate = useNavigate();

    useEffect(() => {
        fetchCartTotal();
    }, []);

    const fetchCartTotal = async () => {
        try {
            const response = await api.get('/user/cart');
            setCartTotal(response.data.totalPrice);
        } catch (error) {
            console.error('Error fetching cart:', error);
        }
    };

    const handleCreateOrder = async (e) => {
        e.preventDefault();
        setLoading(true);
        try {
            const response = await api.post(`/user/orders?shippingAddress=${encodeURIComponent(shippingAddress)}`);
            setOrderData(response.data);
            setStep('payment');
        } catch (error) {
            console.error('Order creation failed:', error);
        } finally {
            setLoading(false);
        }
    };

    const handlePaymentSuccess = async (paymentIntent) => {
        setSuccess(true);
        // Update order status to PAID on backend
        try {
            await api.put(`/user/orders/${orderData.id}/confirm-payment`);
        } catch (error) {
            console.error('Failed to update order status:', error);
        }
        setTimeout(() => navigate('/orders'), 3000);
    };

    const handleCODPayment = () => {
        setSuccess(true);
        setTimeout(() => navigate('/orders'), 3000);
    };

    if (success) return (
        <div className="flex min-h-[60vh] flex-col items-center justify-center text-center animate-in fade-in duration-700">
            <div className="rounded-full bg-green-100 p-8 text-green-600 mb-8 animate-bounce shadow-xl">
                <CheckCircle2 className="h-20 w-20" />
            </div>
            <h2 className="text-5xl font-black tracking-tight">Order Placed!</h2>
            <p className="mt-4 text-xl text-muted-foreground max-w-md">
                {paymentMethod === 'card'
                    ? 'Your payment was successful and your order is confirmed.'
                    : 'Your order has been placed successfully. Please keep the cash ready for delivery.'}
            </p>
            <button
                onClick={() => navigate('/orders')}
                className="mt-10 rounded-full bg-primary px-8 py-4 font-bold text-primary-foreground transition-transform hover:scale-105"
            >
                View My Orders
            </button>
        </div>
    );

    return (
        <div className="flex flex-col gap-10 pb-20">
            <div className="flex items-center justify-between">
                <h1 className="text-4xl font-black tracking-tight">Checkout</h1>
                <div className="flex items-center gap-2 text-sm font-bold text-muted-foreground">
                    <span className={step === 'address' ? 'text-primary' : ''}>Shipping</span>
                    <div className="h-px w-8 bg-muted" />
                    <span className={step === 'payment' ? 'text-primary' : ''}>Payment</span>
                </div>
            </div>

            <div className="grid grid-cols-1 gap-12 lg:grid-cols-3">
                <div className="lg:col-span-2 space-y-8">
                    {step === 'address' ? (
                        <form onSubmit={handleCreateOrder} className="space-y-8 animate-in slide-in-from-left duration-500">
                            <div className="space-y-6 rounded-[2.5rem] border bg-card p-10 shadow-xl">
                                <div className="flex items-center gap-4 text-2xl font-bold">
                                    <div className="rounded-2xl bg-primary/10 p-3 text-primary">
                                        <MapPin className="h-7 w-7" />
                                    </div>
                                    <h2>Where should we send it?</h2>
                                </div>
                                <p className="text-muted-foreground">Please provide your full delivery address below.</p>
                                <textarea
                                    required
                                    value={shippingAddress}
                                    onChange={(e) => setShippingAddress(e.target.value)}
                                    className="min-h-[150px] w-full rounded-2xl border bg-muted/30 p-6 text-lg focus:ring-2 focus:ring-primary/20 outline-none transition-all placeholder:text-muted-foreground/50"
                                    placeholder="Street address, Apartment, City, State, Zip Code..."
                                />
                                <button
                                    type="submit"
                                    disabled={loading || !shippingAddress}
                                    className="flex w-full items-center justify-center gap-3 rounded-2xl bg-primary py-5 text-xl font-bold text-primary-foreground transition-all hover:opacity-90 disabled:opacity-50 shadow-lg"
                                >
                                    {loading ? (
                                        <Loader2 className="h-7 w-7 animate-spin" />
                                    ) : (
                                        <>Continue to Payment <ArrowLeft className="h-6 w-6 rotate-180" /></>
                                    )}
                                </button>
                            </div>
                        </form>
                    ) : (
                        <div className="space-y-8 animate-in slide-in-from-right duration-500">
                            <div className="space-y-6 rounded-[2.5rem] border bg-card p-10 shadow-xl">
                                <div className="flex items-center justify-between">
                                    <div className="flex items-center gap-4 text-2xl font-bold">
                                        <div className="rounded-2xl bg-primary/10 p-3 text-primary">
                                            <CreditCard className="h-7 w-7" />
                                        </div>
                                        <h2>Payment Method</h2>
                                    </div>
                                    <button
                                        onClick={() => setStep('address')}
                                        className="text-sm font-bold text-primary hover:underline"
                                    >
                                        Change Address
                                    </button>
                                </div>

                                <div className="grid grid-cols-1 gap-4 sm:grid-cols-2">
                                    <button
                                        onClick={() => setPaymentMethod('card')}
                                        className={`flex items-center gap-4 rounded-2xl border p-6 transition-all ${paymentMethod === 'card'
                                            ? 'border-primary bg-primary/5 ring-2 ring-primary/20'
                                            : 'hover:bg-muted/50'
                                            }`}
                                    >
                                        <div className={`rounded-full p-2 ${paymentMethod === 'card' ? 'bg-primary text-white' : 'bg-muted text-muted-foreground'}`}>
                                            <CreditCard className="h-6 w-6" />
                                        </div>
                                        <div className="text-left">
                                            <p className="font-bold">Card Payment</p>
                                            <p className="text-xs text-muted-foreground">Secure with Stripe</p>
                                        </div>
                                    </button>
                                    <button
                                        onClick={() => setPaymentMethod('cod')}
                                        className={`flex items-center gap-4 rounded-2xl border p-6 transition-all ${paymentMethod === 'cod'
                                            ? 'border-primary bg-primary/5 ring-2 ring-primary/20'
                                            : 'hover:bg-muted/50'
                                            }`}
                                    >
                                        <div className={`rounded-full p-2 ${paymentMethod === 'cod' ? 'bg-primary text-white' : 'bg-muted text-muted-foreground'}`}>
                                            <DollarSign className="h-6 w-6" />
                                        </div>
                                        <div className="text-left">
                                            <p className="font-bold">Cash on Delivery</p>
                                            <p className="text-xs text-muted-foreground">Pay when you receive</p>
                                        </div>
                                    </button>
                                </div>

                                <div className="rounded-2xl bg-muted/30 p-6">
                                    <div className="flex items-start gap-4">
                                        <MapPin className="h-5 w-5 text-muted-foreground mt-1" />
                                        <div>
                                            <p className="text-xs font-bold text-muted-foreground uppercase tracking-wider">Shipping to:</p>
                                            <p className="font-medium">{shippingAddress}</p>
                                        </div>
                                    </div>
                                </div>

                                {paymentMethod === 'card' ? (
                                    <Elements stripe={stripePromise}>
                                        <StripePaymentForm
                                            amount={orderData.totalAmount}
                                            orderId={orderData.id}
                                            onPaymentSuccess={handlePaymentSuccess}
                                            onPaymentError={(err) => console.error(err)}
                                        />
                                    </Elements>
                                ) : (
                                    <button
                                        onClick={handleCODPayment}
                                        className="flex w-full items-center justify-center gap-3 rounded-2xl bg-primary py-5 text-xl font-bold text-primary-foreground transition-all hover:opacity-90 shadow-lg"
                                    >
                                        Confirm Order (COD)
                                    </button>
                                )}
                            </div>
                        </div>
                    )}
                </div>

                <div className="space-y-8">
                    <div className="rounded-[2.5rem] border bg-card p-8 shadow-xl sticky top-24">
                        <div className="flex items-center gap-3 text-xl font-bold mb-8">
                            <ShoppingBag className="h-6 w-6 text-primary" />
                            <h2>Order Summary</h2>
                        </div>

                        <div className="space-y-4 border-b pb-6">
                            <div className="flex justify-between text-muted-foreground">
                                <span>Subtotal</span>
                                <span className="font-bold text-foreground">${cartTotal.toFixed(2)}</span>
                            </div>
                            <div className="flex justify-between text-muted-foreground">
                                <span>Shipping</span>
                                <span className="font-bold text-green-600 text-sm uppercase">Free</span>
                            </div>
                            <div className="flex justify-between text-muted-foreground">
                                <span>Tax</span>
                                <span className="font-bold text-foreground">$0.00</span>
                            </div>
                        </div>

                        <div className="pt-6">
                            <div className="flex justify-between items-center">
                                <span className="text-lg font-bold">Total Amount</span>
                                <span className="text-3xl font-black text-primary">${cartTotal.toFixed(2)}</span>
                            </div>
                        </div>

                        <div className="mt-8 rounded-2xl bg-blue-50 p-4 flex items-center gap-3 text-blue-700 text-sm font-medium">
                            <Truck className="h-5 w-5" />
                            Estimated delivery: 3-5 business days
                        </div>
                    </div>
                </div>
            </div>
        </div>
    );
};

export default CheckoutPage;
