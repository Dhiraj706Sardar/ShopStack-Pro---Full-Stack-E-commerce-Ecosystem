import React, { useState, useEffect } from 'react';
import { useParams, useNavigate } from 'react-router-dom';
import api from '../api/axios';
import { ShoppingCart, ArrowLeft, Star, Shield, Truck, RotateCcw, Heart } from 'lucide-react';
import { useAuth } from '../context/AuthContext';

const ProductDetailsPage = () => {
    const { id } = useParams();
    const [product, setProduct] = useState(null);
    const [loading, setLoading] = useState(true);
    const [quantity, setQuantity] = useState(1);
    const [reviews, setReviews] = useState([]);
    const [isWishlisted, setIsWishlisted] = useState(false);
    const [newReview, setNewReview] = useState({ comment: '', rating: 5 });
    const [reviewLoading, setReviewLoading] = useState(false);
    const { user, isAdmin } = useAuth();
    const navigate = useNavigate();

    useEffect(() => {
        fetchProduct();
        fetchReviews();
        if (user && !isAdmin()) {
            checkWishlistStatus();
        }
    }, [id, user]);

    const checkWishlistStatus = async () => {
        try {
            const response = await api.get(`/user/wishlist/check/${id}`);
            setIsWishlisted(response.data);
        } catch (error) {
            console.error('Error checking wishlist status:', error);
        }
    };

    const fetchProduct = async () => {
        try {
            const response = await api.get(`/public/products/${id}`);
            setProduct(response.data);
        } catch (error) {
            console.error('Error fetching product:', error);
        } finally {
            setLoading(false);
        }
    };

    const fetchReviews = async () => {
        try {
            const response = await api.get(`/public/reviews/product/${id}`);
            setReviews(response.data);
        } catch (error) {
            console.error('Error fetching reviews:', error);
        }
    };

    const handleAddReview = async (e) => {
        e.preventDefault();
        if (!user) {
            navigate('/login');
            return;
        }
        setReviewLoading(true);
        try {
            await api.post(`/user/reviews/${id}`, newReview);
            setNewReview({ comment: '', rating: 5 });
            fetchReviews();
        } catch (error) {
            alert(error.response?.data?.message || 'Failed to add review');
        } finally {
            setReviewLoading(false);
        }
    };

    const toggleWishlist = async () => {
        if (!user) {
            navigate('/login');
            return;
        }
        try {
            const wishlistCheckResponse = await api.get(`/user/wishlist/check/${id}`);
            const currentlyInWishlist = wishlistCheckResponse.data;

            if (currentlyInWishlist) {
                await api.delete(`/user/wishlist/remove/${id}`);
                setIsWishlisted(false);
            } else {
                await api.post(`/user/wishlist/add/${id}`);
                setIsWishlisted(true);
            }
        } catch (error) {
            console.error('Error toggling wishlist:', error);
        }
    };

    const addToCart = async () => {
        try {
            await api.post(`/user/cart/add?productId=${id}&quantity=${quantity}`);
            navigate('/cart');
        } catch (error) {
            console.error('Error adding to cart:', error);
            if (error.response?.status === 401) {
                navigate('/login');
            }
        }
    };

    if (loading) return (
        <div className="flex h-96 items-center justify-center">
            <div className="h-12 w-12 animate-spin rounded-full border-4 border-primary border-t-transparent"></div>
        </div>
    );

    if (!product) return <div>Product not found</div>;

    const averageRating = reviews.length > 0
        ? Math.round(reviews.reduce((acc, r) => acc + r.rating, 0) / reviews.length)
        : 0;

    return (
        <div className="flex flex-col gap-12 pb-20">
            <button
                onClick={() => navigate(-1)}
                className="flex w-fit items-center gap-2 text-sm font-medium text-muted-foreground hover:text-primary transition-colors"
            >
                <ArrowLeft className="h-4 w-4" /> Back to products
            </button>

            <div className="grid grid-cols-1 gap-12 lg:grid-cols-2">
                {/* Image Gallery */}
                <div className="space-y-4">
                    <div className="aspect-square overflow-hidden rounded-3xl border bg-muted">
                        <img
                            src={product.imageUrl || 'https://via.placeholder.com/800'}
                            alt={product.name}
                            className="h-full w-full object-cover"
                        />
                    </div>
                </div>

                {/* Product Info */}
                <div className="flex flex-col gap-8">
                    <div className="space-y-2">
                        <span className="text-sm font-bold uppercase tracking-widest text-primary/60">
                            {product.categoryName}
                        </span>
                        <h1 className="text-4xl font-extrabold tracking-tight md:text-5xl">
                            {product.name}
                        </h1>
                        <div className="flex items-center gap-4">
                            <div className="flex items-center gap-1 text-yellow-500">
                                {[...Array(5)].map((_, i) => (
                                    <Star key={i} className={`h-5 w-5 ${i < averageRating ? 'fill-current' : ''}`} />
                                ))}
                            </div>
                            <span className="text-sm text-muted-foreground">({reviews.length} reviews)</span>
                        </div>
                    </div>

                    <p className="text-3xl font-bold text-primary">
                        ${product.price.toFixed(2)}
                    </p>

                    <p className="text-lg leading-relaxed text-muted-foreground">
                        {product.description}
                    </p>

                    {!isAdmin() ? (
                        <div className="flex flex-col gap-4">
                            <div className="flex items-center gap-4">
                                <div className="flex items-center rounded-xl border bg-background p-1">
                                    <button
                                        onClick={() => setQuantity(Math.max(1, quantity - 1))}
                                        className="h-10 w-10 rounded-lg hover:bg-accent"
                                    >
                                        -
                                    </button>
                                    <span className="w-12 text-center font-bold">{quantity}</span>
                                    <button
                                        onClick={() => setQuantity(quantity + 1)}
                                        className="h-10 w-10 rounded-lg hover:bg-accent"
                                    >
                                        +
                                    </button>
                                </div>
                                <button
                                    onClick={addToCart}
                                    className="flex flex-1 items-center justify-center gap-2 rounded-xl bg-primary py-4 text-lg font-bold text-primary-foreground transition-all hover:opacity-90"
                                >
                                    <ShoppingCart className="h-5 w-5" /> Add to Cart
                                </button>
                                <button
                                    onClick={toggleWishlist}
                                    className="flex h-14 w-14 items-center justify-center rounded-xl border bg-background text-muted-foreground transition-all hover:bg-accent hover:text-primary"
                                >
                                    <Heart className={`h-6 w-6 ${isWishlisted ? 'fill-red-500 text-red-500' : ''}`} />
                                </button>
                            </div>
                            <p className="text-sm text-muted-foreground">
                                {product.stockQuantity > 0 ? (
                                    <span className="text-green-600 font-medium">In Stock ({product.stockQuantity} available)</span>
                                ) : (
                                    <span className="text-destructive font-medium">Out of Stock</span>
                                )}
                            </p>
                        </div>
                    ) : (
                        <div className="rounded-2xl bg-slate-950 p-6 text-white shadow-xl">
                            <div className="flex items-center gap-3 mb-4">
                                <div className="h-2 w-2 rounded-full bg-blue-500 animate-pulse" />
                                <span className="text-xs font-bold uppercase tracking-widest text-slate-400">Admin View</span>
                            </div>
                            <h3 className="text-xl font-bold mb-2">Inventory Management</h3>
                            <p className="text-slate-400 text-sm mb-6">You are viewing this product as an administrator. Customer actions are disabled.</p>
                            <div className="grid grid-cols-2 gap-4 mb-6">
                                <div className="rounded-xl bg-white/5 p-4">
                                    <p className="text-xs text-slate-500 font-bold uppercase">Stock Level</p>
                                    <p className={`text-xl font-bold ${product.stockQuantity < 10 ? 'text-red-400' : 'text-green-400'}`}>{product.stockQuantity} Units</p>
                                </div>
                                <div className="rounded-xl bg-white/5 p-4">
                                    <p className="text-xs text-slate-500 font-bold uppercase">Total Sales</p>
                                    <p className="text-xl font-bold">--</p>
                                </div>
                            </div>
                            <button
                                onClick={() => navigate('/admin')}
                                className="w-full rounded-xl bg-white py-3 font-bold text-slate-950 transition-transform hover:scale-[1.02]"
                            >
                                Back to Dashboard
                            </button>
                        </div>
                    )}

                    <div className="grid grid-cols-1 gap-4 border-t pt-8 md:grid-cols-3">
                        <div className="flex flex-col items-center gap-2 text-center">
                            <Truck className="h-6 w-6 text-primary" />
                            <span className="text-xs font-bold">Free Shipping</span>
                        </div>
                        <div className="flex flex-col items-center gap-2 text-center">
                            <RotateCcw className="h-6 w-6 text-primary" />
                            <span className="text-xs font-bold">30-Day Returns</span>
                        </div>
                        <div className="flex flex-col items-center gap-2 text-center">
                            <Shield className="h-6 w-6 text-primary" />
                            <span className="text-xs font-bold">2-Year Warranty</span>
                        </div>
                    </div>
                </div>
            </div>

            {/* Reviews Section */}
            <div className="flex flex-col gap-12 border-t pt-12">
                <div className="flex flex-col gap-4 md:flex-row md:items-center md:justify-between">
                    <h2 className="text-3xl font-bold">Customer Reviews</h2>
                    {user && !isAdmin() && (
                        <button
                            onClick={() => document.getElementById('review-form').scrollIntoView({ behavior: 'smooth' })}
                            className="rounded-full border bg-background px-6 py-2 text-sm font-bold hover:bg-accent"
                        >
                            Write a Review
                        </button>
                    )}
                </div>

                <div className={`grid grid-cols-1 gap-8 ${!isAdmin() ? 'lg:grid-cols-3' : ''}`}>
                    {/* Review List */}
                    <div className={`${!isAdmin() ? 'lg:col-span-2' : ''} space-y-6`}>
                        {reviews.length > 0 ? (
                            reviews.map((review) => (
                                <div key={review.id} className="flex flex-col gap-4 rounded-2xl border bg-card p-6 shadow-sm">
                                    <div className="flex items-center justify-between">
                                        <div className="flex items-center gap-3">
                                            <div className="h-10 w-10 rounded-full bg-primary/10 flex items-center justify-center font-bold text-primary">
                                                {review.username[0].toUpperCase()}
                                            </div>
                                            <div>
                                                <p className="font-bold">{review.username}</p>
                                                <p className="text-xs text-muted-foreground">{new Date(review.createdAt).toLocaleDateString()}</p>
                                            </div>
                                        </div>
                                        <div className="flex items-center gap-1 text-yellow-500">
                                            {[...Array(5)].map((_, i) => (
                                                <Star key={i} className={`h-4 w-4 ${i < review.rating ? 'fill-current' : ''}`} />
                                            ))}
                                        </div>
                                    </div>
                                    <p className="text-muted-foreground">{review.comment}</p>
                                </div>
                            ))
                        ) : (
                            <div className="flex flex-col items-center justify-center py-12 text-center border rounded-2xl bg-muted/10">
                                <p className="text-muted-foreground">No reviews yet. Be the first to review this product!</p>
                            </div>
                        )}
                    </div>

                    {/* Add Review Form - Only for non-admins */}
                    {user && !isAdmin() && (
                        <div id="review-form" className="h-fit space-y-6 rounded-3xl border bg-card p-8 shadow-xl">
                            <h3 className="text-xl font-bold">Add a Review</h3>
                            <p className="text-xs text-muted-foreground">Only users who purchased this product can leave a review.</p>
                            <form onSubmit={handleAddReview} className="space-y-4">
                                <div className="space-y-2">
                                    <label className="text-sm font-bold">Rating</label>
                                    <div className="flex items-center gap-2">
                                        {[1, 2, 3, 4, 5].map((star) => (
                                            <button
                                                key={star}
                                                type="button"
                                                onClick={() => setNewReview({ ...newReview, rating: star })}
                                                className={`p-1 transition-colors ${star <= newReview.rating ? 'text-yellow-500' : 'text-muted-foreground'}`}
                                            >
                                                <Star className={`h-6 w-6 ${star <= newReview.rating ? 'fill-current' : ''}`} />
                                            </button>
                                        ))}
                                    </div>
                                </div>
                                <div className="space-y-2">
                                    <label className="text-sm font-bold">Comment</label>
                                    <textarea
                                        required
                                        value={newReview.comment}
                                        onChange={(e) => setNewReview({ ...newReview, comment: e.target.value })}
                                        className="min-h-[100px] w-full rounded-xl border bg-background p-4 text-sm focus:ring-2 focus:ring-primary/20 outline-none"
                                        placeholder="Share your thoughts about the product..."
                                    />
                                </div>
                                <button
                                    type="submit"
                                    disabled={reviewLoading}
                                    className="w-full rounded-xl bg-primary py-3 text-sm font-bold text-primary-foreground transition-all hover:opacity-90 disabled:opacity-50"
                                >
                                    {reviewLoading ? 'Submitting...' : 'Submit Review'}
                                </button>
                            </form>
                        </div>
                    )}
                </div>
            </div>
        </div>
    );
};

export default ProductDetailsPage;
