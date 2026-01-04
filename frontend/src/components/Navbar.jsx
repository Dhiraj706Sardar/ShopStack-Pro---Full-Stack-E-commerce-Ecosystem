import React from 'react';
import { Link, useNavigate } from 'react-router-dom';
import { useAuth } from '../context/AuthContext';
import { ShoppingCart, User, LogOut, Menu, Search, Heart } from 'lucide-react';

const Navbar = () => {
    const { user, logout, isAdmin, isSeller } = useAuth();
    const navigate = useNavigate();

    const handleLogout = () => {
        logout();
        navigate('/login');
    };

    return (
        <nav className="sticky top-0 z-50 w-full border-b bg-background/95 backdrop-blur supports-[backdrop-filter]:bg-background/60">
            <div className="container flex h-16 items-center justify-between">
                <div className="flex items-center gap-8">
                    <Link to="/" className="text-2xl font-bold tracking-tighter text-primary">
                        E-SHOP
                    </Link>
                    <div className="hidden md:flex gap-6">
                        {(!user || (!isAdmin() && !isSeller())) && (
                            <Link to="/products" className="text-sm font-medium hover:text-primary transition-colors">Products</Link>
                        )}
                        {user && !isAdmin() && !isSeller() && (
                            <>
                                <Link to="/wishlist" className="text-sm font-medium hover:text-primary transition-colors flex items-center gap-1">
                                    <Heart className="h-4 w-4" /> Wishlist
                                </Link>
                                <Link to="/orders" className="text-sm font-medium hover:text-primary transition-colors">Orders</Link>
                            </>
                        )}
                        {isAdmin() && (
                            <Link to="/admin" className="text-sm font-medium transition-colors hover:text-primary/80">
                                Admin Dashboard
                            </Link>
                        )}
                        {isSeller() && (
                            <Link to="/seller" className="text-sm font-medium transition-colors hover:text-primary/80">
                                Seller Hub
                            </Link>
                        )}
                    </div>
                </div>

                <div className="flex items-center gap-4">
                    <div className="relative hidden md:block">
                        <Search className="absolute left-2.5 top-2.5 h-4 w-4 text-muted-foreground" />
                        <input
                            type="search"
                            placeholder="Search products..."
                            className="h-9 w-64 rounded-md border border-input bg-transparent px-9 py-1 text-sm shadow-sm transition-colors focus-visible:outline-none focus-visible:ring-1 focus-visible:ring-ring"
                        />
                    </div>

                    {(!user || (!isAdmin() && !isSeller())) && (
                        <Link to="/cart" className="relative p-2 hover:bg-accent rounded-full transition-colors">
                            <ShoppingCart className="h-5 w-5" />
                        </Link>
                    )}

                    {user ? (
                        <div className="flex items-center gap-4">
                            {!isAdmin() && !isSeller() && (
                                <Link to="/orders" className="hidden md:block text-sm font-medium hover:underline underline-offset-4">
                                    My Orders
                                </Link>
                            )}
                            <Link to="/profile" className="flex items-center gap-2 p-1 hover:bg-accent rounded-full transition-colors border border-transparent hover:border-primary/20">
                                <div className="h-8 w-8 rounded-full overflow-hidden bg-muted flex items-center justify-center border border-primary/10">
                                    {user.profileImageUrl ? (
                                        <img src={user.profileImageUrl} alt="" className="h-full w-full object-cover" />
                                    ) : (
                                        <User className="h-4 w-4 text-muted-foreground" />
                                    )}
                                </div>
                            </Link>
                            <button
                                onClick={handleLogout}
                                className="flex items-center gap-2 p-2 hover:bg-accent rounded-full transition-colors text-red-500"
                            >
                                <LogOut className="h-5 w-5" />
                            </button>
                        </div>
                    ) : (
                        <Link to="/login" className="flex items-center gap-2 p-2 hover:bg-accent rounded-full transition-colors">
                            <User className="h-5 w-5" />
                        </Link>
                    )}
                </div>
            </div>
        </nav>
    );
};

export default Navbar;
