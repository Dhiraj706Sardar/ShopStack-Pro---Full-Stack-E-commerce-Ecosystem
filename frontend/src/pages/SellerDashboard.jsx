import React, { useState, useEffect } from 'react';
import api from '../api/axios';
import { useAuth } from '../context/AuthContext';
import {
    Chart as ChartJS,
    CategoryScale,
    LinearScale,
    PointElement,
    LineElement,
    BarElement,
    Title,
    Tooltip,
    Legend,
    ArcElement,
    Filler
} from 'chart.js';
import { Line, Bar } from 'react-chartjs-2';
import {
    Package,
    ShoppingCart,
    DollarSign,
    TrendingUp,
    Plus,
    Search,
    Edit,
    Trash2,
    LayoutDashboard,
    Activity,
    ArrowUpRight,
    X
} from 'lucide-react';

ChartJS.register(
    CategoryScale,
    LinearScale,
    PointElement,
    LineElement,
    BarElement,
    ArcElement,
    Title,
    Tooltip,
    Legend,
    Filler
);

const SellerDashboard = () => {
    const { user } = useAuth();
    const [products, setProducts] = useState([]);
    const [orders, setOrders] = useState([]);
    const [categories, setCategories] = useState([]);
    const [loading, setLoading] = useState(true);
    const [activeTab, setActiveTab] = useState('overview');
    const [showProductModal, setShowProductModal] = useState(false);
    const [editingProduct, setEditingProduct] = useState(null);
    const [productSearch, setProductSearch] = useState('');
    const [submitting, setSubmitting] = useState(false);
    const [notification, setNotification] = useState(null);
    const [imageFile, setImageFile] = useState(null);
    const [productForm, setProductForm] = useState({
        name: '',
        description: '',
        price: '',
        stockQuantity: '',
        categoryId: ''
    });

    const showNotification = (message, type = 'success') => {
        setNotification({ message, type });
        setTimeout(() => setNotification(null), 3000);
    };

    useEffect(() => {
        fetchData();
    }, []);

    const fetchData = async () => {
        setLoading(true);
        try {
            const [productsRes, ordersRes, categoriesRes] = await Promise.all([
                api.get('/seller/products'),
                api.get('/seller/orders'),
                api.get('/public/categories')
            ]);
            setProducts(productsRes.data || []);
            setOrders(ordersRes.data || []);
            setCategories(categoriesRes.data || []);
        } catch (error) {
            console.error('Error fetching seller data:', error);
            showNotification('Error fetching dashboard data', 'error');
        } finally {
            setLoading(false);
        }
    };

    const handleProductSubmit = async (e) => {
        e.preventDefault();
        setSubmitting(true);
        try {
            const formData = new FormData();
            formData.append('product', JSON.stringify(productForm));
            if (imageFile) {
                formData.append('image', imageFile);
            }

            const config = {
                headers: {
                    'Content-Type': 'multipart/form-data'
                }
            };

            if (editingProduct) {
                await api.put(`/seller/products/${editingProduct.id}`, formData, config);
            } else {
                await api.post('/seller/products', formData, config);
            }
            setShowProductModal(false);
            setEditingProduct(null);
            setProductForm({ name: '', description: '', price: '', stockQuantity: '', categoryId: '' });
            setImageFile(null);
            showNotification(editingProduct ? 'Product updated successfully!' : 'Product created successfully!');
            fetchData();
        } catch (error) {
            console.error('Error saving product:', error);
            showNotification(error.response?.data?.message || 'Error saving product', 'error');
        } finally {
            setSubmitting(false);
        }
    };

    const deleteProduct = async (id) => {
        if (window.confirm('Are you sure you want to delete this product?')) {
            try {
                await api.delete(`/seller/products/${id}`);
                showNotification('Product deleted successfully!');
                fetchData();
            } catch (error) {
                console.error('Error deleting product:', error);
                showNotification('Error deleting product', 'error');
            }
        }
    };

    const openEditProduct = (product) => {
        setEditingProduct(product);
        setProductForm({
            name: product.name,
            description: product.description,
            price: product.price,
            stockQuantity: product.stockQuantity,
            categoryId: product.categoryId
        });
        setImageFile(null);
        setShowProductModal(true);
    };

    const totalRevenue = orders.reduce((sum, order) => sum + (order.totalAmount || 0), 0);

    if (loading) return (
        <div className="flex h-96 items-center justify-center">
            <div className="h-12 w-12 animate-spin rounded-full border-4 border-primary border-t-transparent"></div>
        </div>
    );

    return (
        <div className="flex flex-col gap-8 pb-20 relative">
            {/* Notification Toast */}
            {notification && (
                <div className={`fixed top-4 right-4 z-[100] animate-in fade-in slide-in-from-top-4 duration-300`}>
                    <div className={`rounded-2xl px-6 py-4 shadow-2xl flex items-center gap-3 border ${notification.type === 'error' ? 'bg-red-50 border-red-100 text-red-600' : 'bg-green-50 border-green-100 text-green-600'
                        }`}>
                        <div className={`h-2 w-2 rounded-full ${notification.type === 'error' ? 'bg-red-600' : 'bg-green-600'}`} />
                        <p className="font-bold text-sm">{notification.message}</p>
                    </div>
                </div>
            )}

            <div className="flex items-center justify-between">
                <div>
                    <h1 className="text-3xl font-black tracking-tight">Seller Hub</h1>
                    <p className="text-muted-foreground">Welcome back, {user?.username}. Here's your business at a glance.</p>
                </div>
                <button
                    onClick={() => {
                        setEditingProduct(null);
                        setProductForm({ name: '', description: '', price: '', stockQuantity: '', categoryId: '' });
                        setImageFile(null);
                        setShowProductModal(true);
                    }}
                    className="admin-btn-primary"
                >
                    <Plus className="h-5 w-5" /> Add New Product
                </button>
            </div>

            {/* Tabs */}
            <div className="flex gap-4 border-b">
                {['overview', 'my-products', 'sales'].map((tab) => (
                    <button
                        key={tab}
                        onClick={() => setActiveTab(tab)}
                        className={`pb-4 text-sm font-bold transition-all ${activeTab === tab
                            ? 'border-b-2 border-primary text-primary'
                            : 'text-muted-foreground hover:text-foreground'
                            }`}
                    >
                        {tab.charAt(0).toUpperCase() + tab.slice(1).replace('-', ' ')}
                    </button>
                ))}
            </div>

            {activeTab === 'overview' && (
                <div className="space-y-8 animate-in fade-in duration-500">
                    {/* Stats Grid */}
                    <div className="grid grid-cols-1 gap-6 md:grid-cols-3">
                        <div className="admin-card group">
                            <div className="flex items-center gap-4">
                                <div className="rounded-2xl bg-blue-50 p-4 text-blue-600 group-hover:scale-110 transition-transform">
                                    <Package className="h-8 w-8" />
                                </div>
                                <div>
                                    <p className="text-sm font-medium text-muted-foreground">Active Products</p>
                                    <h3 className="text-3xl font-black">{products.length}</h3>
                                </div>
                            </div>
                        </div>
                        <div className="admin-card group">
                            <div className="flex items-center gap-4">
                                <div className="rounded-2xl bg-emerald-50 p-4 text-emerald-600 group-hover:scale-110 transition-transform">
                                    <ShoppingCart className="h-8 w-8" />
                                </div>
                                <div>
                                    <p className="text-sm font-medium text-muted-foreground">Total Orders</p>
                                    <h3 className="text-3xl font-black">{orders.length}</h3>
                                </div>
                            </div>
                        </div>
                        <div className="admin-card group">
                            <div className="flex items-center gap-4">
                                <div className="rounded-2xl bg-amber-50 p-4 text-amber-600 group-hover:scale-110 transition-transform">
                                    <DollarSign className="h-8 w-8" />
                                </div>
                                <div>
                                    <p className="text-sm font-medium text-muted-foreground">Total Revenue</p>
                                    <h3 className="text-3xl font-black">${totalRevenue.toFixed(2)}</h3>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div className="grid grid-cols-1 gap-8 lg:grid-cols-3">
                        <div className="lg:col-span-2 admin-card">
                            <h2 className="text-xl font-bold mb-6">Sales Performance</h2>
                            <div className="h-[300px]">
                                <Line
                                    data={{
                                        labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'],
                                        datasets: [{
                                            label: 'Revenue',
                                            data: [totalRevenue * 0.1, totalRevenue * 0.2, totalRevenue * 0.15, totalRevenue * 0.25, totalRevenue * 0.3, totalRevenue],
                                            borderColor: 'rgb(59, 130, 246)',
                                            backgroundColor: 'rgba(59, 130, 246, 0.1)',
                                            fill: true,
                                            tension: 0.4
                                        }]
                                    }}
                                    options={{
                                        responsive: true,
                                        maintainAspectRatio: false,
                                        plugins: { legend: { display: false } },
                                        scales: {
                                            y: { beginAtZero: true, grid: { color: 'rgba(0,0,0,0.05)' } },
                                            x: { grid: { display: false } }
                                        }
                                    }}
                                />
                            </div>
                        </div>

                        <div className="admin-card">
                            <h2 className="text-xl font-bold mb-6">Recent Activity</h2>
                            <div className="space-y-4">
                                {orders.slice(0, 5).map((order) => (
                                    <div key={order.id} className="flex items-center justify-between border-b pb-4 last:border-0">
                                        <div className="flex items-center gap-3">
                                            <div className="rounded-full bg-blue-50 p-2 text-blue-600">
                                                <Activity className="h-4 w-4" />
                                            </div>
                                            <div>
                                                <p className="text-sm font-bold">New Order</p>
                                                <p className="text-xs text-muted-foreground">${order.totalAmount.toFixed(2)}</p>
                                            </div>
                                        </div>
                                        <span className="text-[10px] font-bold text-muted-foreground">Just now</span>
                                    </div>
                                ))}
                                {orders.length === 0 && (
                                    <p className="text-center text-muted-foreground py-10">No orders yet.</p>
                                )}
                            </div>
                        </div>
                    </div>
                </div>
            )}

            {activeTab === 'my-products' && (
                <div className="admin-card animate-in slide-in-from-bottom-4 duration-500">
                    <div className="mb-6 flex items-center justify-between">
                        <h2 className="text-xl font-bold">Your Inventory</h2>
                        <div className="relative">
                            <Search className="absolute left-3 top-1/2 h-4 w-4 -translate-y-1/2 text-muted-foreground" />
                            <input
                                type="text"
                                placeholder="Search products..."
                                value={productSearch}
                                onChange={(e) => setProductSearch(e.target.value)}
                                className="rounded-full border bg-muted/50 py-2 pl-10 pr-4 text-sm focus:outline-none focus:ring-2 focus:ring-primary/20"
                            />
                        </div>
                    </div>
                    <div className="overflow-x-auto">
                        <table className="w-full text-left">
                            <thead>
                                <tr className="border-b text-sm font-bold text-muted-foreground">
                                    <th className="pb-4 px-4">Product</th>
                                    <th className="pb-4 px-4">Category</th>
                                    <th className="pb-4 px-4">Price</th>
                                    <th className="pb-4 px-4">Stock</th>
                                    <th className="pb-4 px-4 text-right">Actions</th>
                                </tr>
                            </thead>
                            <tbody className="divide-y">
                                {products
                                    .filter(p => p.name.toLowerCase().includes(productSearch.toLowerCase()))
                                    .map((product) => (
                                        <tr key={product.id} className="group hover:bg-muted/30 transition-colors">
                                            <td className="py-4 px-4">
                                                <div className="flex items-center gap-3">
                                                    <img src={product.imageUrl} alt="" className="h-10 w-10 rounded-lg object-cover shadow-sm" />
                                                    <span className="font-bold">{product.name}</span>
                                                </div>
                                            </td>
                                            <td className="py-4 px-4 text-sm text-muted-foreground">{product.categoryName}</td>
                                            <td className="py-4 px-4 font-medium">${product.price.toFixed(2)}</td>
                                            <td className="py-4 px-4">
                                                <span className={`rounded-full px-2 py-1 text-xs font-bold ${product.stockQuantity > 10 ? 'bg-green-50 text-green-600' : 'bg-red-50 text-red-600'
                                                    }`}>
                                                    {product.stockQuantity} in stock
                                                </span>
                                            </td>
                                            <td className="py-4 px-4 text-right">
                                                <div className="flex justify-end gap-2">
                                                    <button
                                                        onClick={() => openEditProduct(product)}
                                                        className="rounded-lg p-2 hover:bg-blue-50 hover:text-blue-600 transition-colors"
                                                    >
                                                        <Edit className="h-4 w-4" />
                                                    </button>
                                                    <button
                                                        onClick={() => deleteProduct(product.id)}
                                                        className="rounded-lg p-2 hover:bg-red-50 hover:text-red-600 transition-colors"
                                                    >
                                                        <Trash2 className="h-4 w-4" />
                                                    </button>
                                                </div>
                                            </td>
                                        </tr>
                                    ))}
                            </tbody>
                        </table>
                    </div>
                </div>
            )}

            {/* Product Modal */}
            {showProductModal && (
                <div className="fixed inset-0 z-50 flex items-center justify-center bg-black/50 backdrop-blur-sm p-4">
                    <div className="w-full max-w-2xl rounded-3xl bg-card p-8 shadow-2xl overflow-y-auto max-h-[90vh]">
                        <div className="flex items-center justify-between mb-8">
                            <h2 className="text-2xl font-bold">{editingProduct ? 'Edit Product' : 'Add New Product'}</h2>
                            <button onClick={() => setShowProductModal(false)} className="rounded-full p-2 hover:bg-muted transition-colors">
                                <X className="h-6 w-6" />
                            </button>
                        </div>
                        <form onSubmit={handleProductSubmit} className="grid grid-cols-1 md:grid-cols-2 gap-6">
                            <div className="space-y-2">
                                <label className="text-sm font-bold">Product Name</label>
                                <input
                                    type="text"
                                    required
                                    value={productForm.name}
                                    onChange={(e) => setProductForm({ ...productForm, name: e.target.value })}
                                    className="w-full rounded-xl border bg-background p-4 text-sm outline-none focus:ring-2 focus:ring-primary/20"
                                />
                            </div>
                            <div className="space-y-2">
                                <label className="text-sm font-bold">Category</label>
                                <select
                                    required
                                    value={productForm.categoryId}
                                    onChange={(e) => setProductForm({ ...productForm, categoryId: e.target.value })}
                                    className="w-full rounded-xl border bg-background p-4 text-sm outline-none focus:ring-2 focus:ring-primary/20"
                                >
                                    <option value="">Select Category</option>
                                    {categories.map(cat => (
                                        <option key={cat.id} value={cat.id}>{cat.name}</option>
                                    ))}
                                </select>
                            </div>
                            <div className="space-y-2 md:col-span-2">
                                <label className="text-sm font-bold">Description</label>
                                <textarea
                                    required
                                    rows="3"
                                    value={productForm.description}
                                    onChange={(e) => setProductForm({ ...productForm, description: e.target.value })}
                                    className="w-full rounded-xl border bg-background p-4 text-sm outline-none focus:ring-2 focus:ring-primary/20"
                                />
                            </div>
                            <div className="space-y-2">
                                <label className="text-sm font-bold">Price ($)</label>
                                <input
                                    type="number"
                                    step="0.01"
                                    required
                                    value={productForm.price}
                                    onChange={(e) => setProductForm({ ...productForm, price: e.target.value })}
                                    className="w-full rounded-xl border bg-background p-4 text-sm outline-none focus:ring-2 focus:ring-primary/20"
                                />
                            </div>
                            <div className="space-y-2">
                                <label className="text-sm font-bold">Stock Quantity</label>
                                <input
                                    type="number"
                                    required
                                    value={productForm.stockQuantity}
                                    onChange={(e) => setProductForm({ ...productForm, stockQuantity: e.target.value })}
                                    className="w-full rounded-xl border bg-background p-4 text-sm outline-none focus:ring-2 focus:ring-primary/20"
                                />
                            </div>
                            <div className="space-y-2 md:col-span-2">
                                <label className="text-sm font-bold">Product Image</label>
                                <input
                                    type="file"
                                    accept="image/*"
                                    required={!editingProduct}
                                    onChange={(e) => setImageFile(e.target.files[0])}
                                    className="w-full rounded-xl border bg-background p-4 text-sm outline-none focus:ring-2 focus:ring-primary/20"
                                />
                                {editingProduct && !imageFile && (
                                    <p className="text-xs text-muted-foreground mt-1">Leave empty to keep current image</p>
                                )}
                            </div>
                            <div className="md:col-span-2 pt-4">
                                <button
                                    type="submit"
                                    disabled={submitting}
                                    className="w-full flex items-center justify-center gap-2 rounded-xl bg-primary py-4 font-bold text-primary-foreground transition-all hover:opacity-90 disabled:opacity-50"
                                >
                                    {submitting ? (
                                        <div className="h-5 w-5 animate-spin rounded-full border-2 border-white border-t-transparent" />
                                    ) : (
                                        <>{editingProduct ? 'Update Product' : 'Create Product'}</>
                                    )}
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            )}
        </div>
    );
};

export default SellerDashboard;
