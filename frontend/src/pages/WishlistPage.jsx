import React, { useState, useEffect } from 'react';
import { Link } from 'react-router-dom';
import api from '../api/axios';
import { Heart, Trash2, ShoppingCart, ShoppingBag } from 'lucide-react';

const WishlistPage = () => {
    const [wishlist, setWishlist] = useState([]);
    const [loading, setLoading] = useState(true);

    useEffect(() => {
        fetchWishlist();
    }, []);

    const fetchWishlist = async () => {
        try {
            const response = await api.get('/user/wishlist');
            setWishlist(response.data);
        } catch (error) {
            console.error('Error fetching wishlist:', error);
        } finally {
            setLoading(false);
        }
    };

    const removeFromWishlist = async (productId) => {
        try {
            await api.delete(`/user/wishlist/remove/${productId}`);
            setWishlist(wishlist.filter(item => item.id !== productId));
        } catch (error) {
            console.error('Error removing from wishlist:', error);
        }
    };

    const addToCart = async (productId) => {
        try {
            await api.post(`/user/cart/add?productId=${productId}&quantity=1`);
            // Optionally remove from wishlist after adding to cart
            // await removeFromWishlist(productId);
            alert('Added to cart!');
        } catch (error) {
            console.error('Error adding to cart:', error);
        }
    };

    if (loading) return (
        <div className="flex h-96 items-center justify-center">
            <div className="h-12 w-12 animate-spin rounded-full border-4 border-primary border-t-transparent"></div>
        </div>
    );

    if (wishlist.length === 0) return (
        <div className="flex flex-col items-center justify-center py-20 text-center">
            <div className="rounded-full bg-muted p-8 mb-6">
                <Heart className="h-16 w-16 text-muted-foreground" />
            </div>
            <h2 className="text-3xl font-bold">Your wishlist is empty</h2>
            <p className="mt-2 text-muted-foreground">Save items you love to your wishlist.</p>
            <Link
                to="/products"
                className="mt-8 rounded-full bg-primary px-8 py-4 font-bold text-primary-foreground transition-all hover:opacity-90"
            >
                Explore Products
            </Link>
        </div>
    );

    return (
        <div className="flex flex-col gap-8 pb-20">
            <h1 className="text-3xl font-bold tracking-tight">My Wishlist</h1>

            <div className="grid grid-cols-1 gap-6 sm:grid-cols-2 lg:grid-cols-4">
                {wishlist.map((product) => (
                    <div
                        key={product.id}
                        className="group relative flex flex-col gap-4 overflow-hidden rounded-2xl border bg-card p-4 transition-all hover:shadow-xl"
                    >
                        <Link to={`/products/${product.id}`} className="aspect-square overflow-hidden rounded-xl bg-muted">
                            <img
                                src={product.imageUrl || 'https://via.placeholder.com/400'}
                                alt={product.name}
                                className="h-full w-full object-cover transition-transform duration-500 group-hover:scale-110"
                            />
                        </Link>

                        <button
                            onClick={() => removeFromWishlist(product.id)}
                            className="absolute right-6 top-6 rounded-full bg-background/80 p-2 text-destructive shadow-sm backdrop-blur-sm transition-all hover:bg-destructive hover:text-white"
                        >
                            <Trash2 className="h-4 w-4" />
                        </button>

                        <div className="flex flex-col gap-1">
                            <span className="text-xs font-medium text-muted-foreground uppercase tracking-wider">
                                {product.categoryName}
                            </span>
                            <h3 className="font-bold text-lg group-hover:text-primary transition-colors">
                                {product.name}
                            </h3>
                            <p className="text-xl font-extrabold text-primary">
                                ${product.price.toFixed(2)}
                            </p>
                        </div>

                        <button
                            onClick={() => addToCart(product.id)}
                            className="mt-2 flex w-full items-center justify-center gap-2 rounded-xl bg-primary py-3 text-sm font-bold text-primary-foreground transition-all hover:opacity-90"
                        >
                            <ShoppingCart className="h-4 w-4" /> Add to Cart
                        </button>
                    </div>
                ))}
            </div>
        </div>
    );
};

export default WishlistPage;
