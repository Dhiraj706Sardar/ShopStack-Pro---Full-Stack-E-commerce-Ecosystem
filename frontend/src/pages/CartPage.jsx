import React, { useState, useEffect } from 'react';
import { Link, useNavigate } from 'react-router-dom';
import api from '../api/axios';
import { Trash2, Plus, Minus, ArrowRight, ShoppingBag } from 'lucide-react';

const CartPage = () => {
    const [cart, setCart] = useState(null);
    const [loading, setLoading] = useState(true);
    const navigate = useNavigate();

    useEffect(() => {
        fetchCart();
    }, []);

    const fetchCart = async () => {
        try {
            const response = await api.get('/user/cart');
            setCart(response.data);
        } catch (error) {
            console.error('Error fetching cart:', error);
        } finally {
            setLoading(false);
        }
    };

    const updateQuantity = async (productId, newQuantity) => {
        if (newQuantity < 1) return;
        try {
            await api.put(`/user/cart/update?productId=${productId}&quantity=${newQuantity}`);
            fetchCart();
        } catch (error) {
            console.error('Error updating quantity:', error);
        }
    };

    const removeItem = async (productId) => {
        try {
            await api.delete(`/user/cart/remove/${productId}`);
            fetchCart();
        } catch (error) {
            console.error('Error removing item:', error);
        }
    };

    if (loading) return (
        <div className="flex h-96 items-center justify-center">
            <div className="h-12 w-12 animate-spin rounded-full border-4 border-primary border-t-transparent"></div>
        </div>
    );

    if (!cart || cart.items.length === 0) return (
        <div className="flex flex-col items-center justify-center py-20 text-center">
            <div className="rounded-full bg-muted p-8 mb-6">
                <ShoppingBag className="h-16 w-16 text-muted-foreground" />
            </div>
            <h2 className="text-3xl font-bold">Your cart is empty</h2>
            <p className="mt-2 text-muted-foreground">Looks like you haven't added anything to your cart yet.</p>
            <Link
                to="/products"
                className="mt-8 rounded-full bg-primary px-8 py-4 font-bold text-primary-foreground transition-all hover:opacity-90"
            >
                Start Shopping
            </Link>
        </div>
    );

    return (
        <div className="flex flex-col gap-8">
            <h1 className="text-3xl font-bold tracking-tight">Shopping Cart</h1>

            <div className="grid grid-cols-1 gap-12 lg:grid-cols-3">
                {/* Cart Items */}
                <div className="lg:col-span-2 space-y-6">
                    {cart.items.map((item) => (
                        <div key={item.id} className="flex gap-6 rounded-2xl border bg-card p-6 transition-all hover:shadow-md">
                            <div className="h-24 w-24 flex-shrink-0 overflow-hidden rounded-xl bg-muted">
                                <img
                                    src={item.productImageUrl || 'https://via.placeholder.com/200'}
                                    alt={item.productName}
                                    className="h-full w-full object-cover"
                                />
                            </div>

                            <div className="flex flex-1 flex-col justify-between">
                                <div className="flex justify-between">
                                    <div>
                                        <h3 className="font-bold text-lg">{item.productName}</h3>
                                        <p className="text-primary font-bold">${item.price.toFixed(2)}</p>
                                    </div>
                                    <button
                                        onClick={() => removeItem(item.productId)}
                                        className="text-muted-foreground hover:text-destructive transition-colors"
                                    >
                                        <Trash2 className="h-5 w-5" />
                                    </button>
                                </div>

                                <div className="flex items-center justify-between mt-4">
                                    <div className="flex items-center rounded-lg border bg-background p-1">
                                        <button
                                            onClick={() => updateQuantity(item.productId, item.quantity - 1)}
                                            className="p-1 hover:bg-accent rounded"
                                        >
                                            <Minus className="h-4 w-4" />
                                        </button>
                                        <span className="w-8 text-center text-sm font-bold">{item.quantity}</span>
                                        <button
                                            onClick={() => updateQuantity(item.productId, item.quantity + 1)}
                                            className="p-1 hover:bg-accent rounded"
                                        >
                                            <Plus className="h-4 w-4" />
                                        </button>
                                    </div>
                                    <p className="font-bold text-lg">
                                        ${(item.price * item.quantity).toFixed(2)}
                                    </p>
                                </div>
                            </div>
                        </div>
                    ))}
                </div>

                {/* Summary */}
                <div className="h-fit space-y-6 rounded-3xl border bg-card p-8 shadow-xl">
                    <h2 className="text-xl font-bold">Order Summary</h2>
                    <div className="space-y-4">
                        <div className="flex justify-between text-muted-foreground">
                            <span>Subtotal</span>
                            <span>${cart.totalPrice.toFixed(2)}</span>
                        </div>
                        <div className="flex justify-between text-muted-foreground">
                            <span>Shipping</span>
                            <span className="text-green-600 font-medium">Free</span>
                        </div>
                        <div className="flex justify-between text-muted-foreground">
                            <span>Tax</span>
                            <span>$0.00</span>
                        </div>
                        <div className="border-t pt-4 flex justify-between text-xl font-bold">
                            <span>Total</span>
                            <span>${cart.totalPrice.toFixed(2)}</span>
                        </div>
                    </div>
                    <button
                        onClick={() => navigate('/checkout')}
                        className="group flex w-full items-center justify-center gap-2 rounded-xl bg-primary py-4 font-bold text-primary-foreground transition-all hover:opacity-90"
                    >
                        Checkout <ArrowRight className="ml-2 h-5 w-5 transition-transform group-hover:translate-x-1" />
                    </button>
                </div>
            </div>
        </div>
    );
};

export default CartPage;
