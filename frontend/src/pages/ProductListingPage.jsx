import React, { useState, useEffect } from 'react';
import { Link, useNavigate } from 'react-router-dom';
import api from '../api/axios';
import { Search, Filter, SlidersHorizontal } from 'lucide-react';
import { useAuth } from '../context/AuthContext'; // Assuming AuthContext is in this path

const ProductListingPage = () => {
    const [products, setProducts] = useState([]);
    const [categories, setCategories] = useState([]);
    const [selectedCategory, setSelectedCategory] = useState('');
    const [loading, setLoading] = useState(true);
    const [searchTerm, setSearchTerm] = useState('');
    const [page, setPage] = useState(0);
    const [totalPages, setTotalPages] = useState(0);
    const { user } = useAuth();
    const navigate = useNavigate();

    useEffect(() => {
        fetchCategories();
    }, []);

    useEffect(() => {
        fetchProducts();
    }, [page, searchTerm, selectedCategory]);

    const fetchCategories = async () => {
        try {
            const response = await api.get('/public/categories');
            setCategories(response.data);
        } catch (error) {
            console.error('Error fetching categories:', error);
        }
    };

    const fetchProducts = async () => {
        setLoading(true);
        try {
            let url = `/public/products?page=${page}&size=8`;
            if (searchTerm) url += `&name=${searchTerm}`;
            if (selectedCategory) url += `&categoryId=${selectedCategory}`;

            const response = await api.get(url);
            setProducts(response.data.content || []);
            setTotalPages(response.data.totalPages || 0);
        } catch (error) {
            console.error('Error fetching products:', error);
        } finally {
            setLoading(false);
        }
    };


    if (loading && products.length === 0) return (
        <div className="flex h-96 items-center justify-center">
            <div className="h-12 w-12 animate-spin rounded-full border-4 border-primary border-t-transparent"></div>
        </div>
    );

    return (
        <div className="flex flex-col gap-8 pb-20">
            <div className="flex flex-col gap-4 md:flex-row md:items-center md:justify-between">
                <div>
                    <h1 className="text-3xl font-bold tracking-tight">Our Products</h1>
                    <p className="text-muted-foreground">Browse our curated collection of premium items.</p>
                </div>

                <div className="flex items-center gap-4">
                    <select
                        value={selectedCategory}
                        onChange={(e) => setSelectedCategory(e.target.value)}
                        className="h-10 rounded-full border bg-background px-4 text-sm focus:outline-none focus:ring-2 focus:ring-primary/20"
                    >
                        <option value="">All Categories</option>
                        {categories.map((cat) => (
                            <option key={cat.id} value={cat.id}>{cat.name}</option>
                        ))}
                    </select>
                    <div className="relative">
                        <Search className="absolute left-3 top-1/2 h-4 w-4 -translate-y-1/2 text-muted-foreground" />
                        <input
                            type="text"
                            placeholder="Search products..."
                            value={searchTerm}
                            onChange={(e) => setSearchTerm(e.target.value)}
                            className="h-10 w-full rounded-full border bg-background pl-10 pr-4 text-sm focus:outline-none focus:ring-2 focus:ring-primary/20 md:w-64"
                        />
                    </div>
                    <button className="flex items-center gap-2 rounded-full border bg-background px-4 py-2 text-sm font-medium hover:bg-accent">
                        <Filter className="h-4 w-4" /> Filter
                    </button>
                </div>
            </div>

            <div className="grid grid-cols-1 gap-6 sm:grid-cols-2 lg:grid-cols-4">
                {products.map((product) => (
                    <Link
                        key={product.id}
                        to={`/products/${product.id}`}
                        className="group relative flex flex-col gap-4 overflow-hidden rounded-2xl border bg-card p-4 transition-all hover:shadow-xl"
                    >
                        <div className="aspect-square overflow-hidden rounded-xl bg-muted">
                            <img
                                src={product.imageUrl || 'https://via.placeholder.com/400'}
                                alt={product.name}
                                className="h-full w-full object-cover transition-transform duration-500 group-hover:scale-110"
                            />
                        </div>

                        <div className="flex flex-col gap-1">
                            <span className="text-xs font-medium text-muted-foreground uppercase tracking-wider">
                                {product.categoryName}
                            </span>
                            <h3 className="font-bold text-lg group-hover:text-primary transition-colors">
                                {product.name}
                            </h3>
                            <div className="flex items-center justify-between mt-2">
                                <p className="text-xl font-extrabold text-primary">
                                    ${product.price.toFixed(2)}
                                </p>
                                <span className="text-xs font-bold text-muted-foreground bg-muted px-2 py-1 rounded-md">
                                    Catalog
                                </span>
                            </div>
                        </div>
                    </Link>
                ))}
            </div>

            {/* Pagination Controls */}
            {totalPages > 1 && (
                <div className="flex items-center justify-center gap-2 mt-8">
                    <button
                        disabled={page === 0}
                        onClick={() => setPage(page - 1)}
                        className="rounded-lg border px-4 py-2 text-sm font-medium hover:bg-accent disabled:opacity-50"
                    >
                        Previous
                    </button>
                    {[...Array(totalPages)].map((_, i) => (
                        <button
                            key={i}
                            onClick={() => setPage(i)}
                            className={`h-10 w-10 rounded-lg border text-sm font-medium transition-colors ${page === i ? 'bg-primary text-primary-foreground' : 'hover:bg-accent'}`}
                        >
                            {i + 1}
                        </button>
                    ))}
                    <button
                        disabled={page === totalPages - 1}
                        onClick={() => setPage(page + 1)}
                        className="rounded-lg border px-4 py-2 text-sm font-medium hover:bg-accent disabled:opacity-50"
                    >
                        Next
                    </button>
                </div>
            )}

            {products.length === 0 && (
                <div className="flex flex-col items-center justify-center py-20 text-center">
                    <div className="rounded-full bg-muted p-6 mb-4">
                        <Search className="h-12 w-12 text-muted-foreground" />
                    </div>
                    <h3 className="text-xl font-bold">No products found</h3>
                    <p className="text-muted-foreground">Try adjusting your search or filters.</p>
                </div>
            )}
        </div>
    );
};

export default ProductListingPage;
