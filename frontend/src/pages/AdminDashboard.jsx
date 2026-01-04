import React, { useState, useEffect } from 'react';
import api from '../api/axios';
import {
    LayoutDashboard,
    ShoppingBag,
    Users,
    ClipboardList,
    Plus,
    Edit,
    Trash2,
    TrendingUp,
    DollarSign,
    Package,
    ShoppingCart,
    LayoutGrid,
    X,
    Search,
    Activity,
    ArrowUpRight
} from 'lucide-react';
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

// Register ChartJS components
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

const AdminDashboard = () => {
    const [activeTab, setActiveTab] = useState('overview');
    const [products, setProducts] = useState([]);
    const [orders, setOrders] = useState([]);
    const [categories, setCategories] = useState([]);
    const [users, setUsers] = useState([]);
    const [analytics, setAnalytics] = useState(null);
    const [loading, setLoading] = useState(true);
    const [showProductModal, setShowProductModal] = useState(false);
    const [showCategoryModal, setShowCategoryModal] = useState(false);
    const [showOrderModal, setShowOrderModal] = useState(false);
    const [selectedOrder, setSelectedOrder] = useState(null);
    const [editingProduct, setEditingProduct] = useState(null);
    const [editingCategory, setEditingCategory] = useState(null);
    const [productSearch, setProductSearch] = useState('');
    const [userSearch, setUserSearch] = useState('');
    const [userRoleFilter, setUserRoleFilter] = useState('ALL'); // ALL, USER, SELLER
    const [productForm, setProductForm] = useState({
        name: '',
        description: '',
        price: '',
        stockQuantity: '',
        categoryId: ''
    });
    const [categoryForm, setCategoryForm] = useState({
        name: '',
        description: ''
    });
    const [imageFile, setImageFile] = useState(null);
    const [notification, setNotification] = useState(null);
    const [submitting, setSubmitting] = useState(false);

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
            const [prodRes, orderRes, catRes, analyticsRes, userRes] = await Promise.all([
                api.get('/admin/products?size=100'),
                api.get('/admin/orders'),
                api.get('/public/categories'),
                api.get('/admin/analytics/dashboard'),
                api.get('/admin/users')
            ]);
            setProducts(prodRes.data.content || []);
            setOrders(orderRes.data || []);
            setCategories(catRes.data || []);
            setAnalytics(analyticsRes.data);
            setUsers(userRes.data || []);
        } catch (error) {
            console.error('Error fetching dashboard data:', error);
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
                await api.put(`/admin/products/${editingProduct.id}`, formData, config);
            } else {
                await api.post('/admin/products', formData, config);
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
                await api.delete(`/admin/products/${id}`);
                showNotification('Product deleted successfully!');
                fetchData();
            } catch (error) {
                console.error('Error deleting product:', error);
                showNotification('Error deleting product', 'error');
            }
        }
    };

    const handleCategorySubmit = async (e) => {
        e.preventDefault();
        setSubmitting(true);
        try {
            if (editingCategory) {
                await api.put(`/admin/categories/${editingCategory.id}`, categoryForm);
            } else {
                await api.post('/admin/categories', categoryForm);
            }
            setShowCategoryModal(false);
            setEditingCategory(null);
            setCategoryForm({ name: '', description: '' });
            showNotification(editingCategory ? 'Category updated successfully!' : 'Category created successfully!');
            fetchData();
        } catch (error) {
            console.error('Error saving category:', error);
            showNotification('Error saving category', 'error');
        } finally {
            setSubmitting(false);
        }
    };

    const deleteCategory = async (id) => {
        if (window.confirm('Are you sure you want to delete this category?')) {
            try {
                await api.delete(`/admin/categories/${id}`);
                showNotification('Category deleted successfully!');
                fetchData();
            } catch (error) {
                console.error('Error deleting category:', error);
                showNotification('Error deleting category', 'error');
            }
        }
    };

    const updateOrderStatus = async (orderId, newStatus) => {
        try {
            await api.put(`/admin/orders/${orderId}/status?status=${newStatus}`);
            fetchData();
        } catch (error) {
            console.error('Error updating order status:', error);
        }
    };

    const handleUserStatus = async (userId, isActive) => {
        try {
            if (isActive) {
                await api.put(`/admin/users/${userId}/ban`);
            } else {
                await api.put(`/admin/users/${userId}/unban`);
            }
            showNotification(isActive ? 'User banned successfully!' : 'User unbanned successfully!');
            fetchData();
        } catch (error) {
            console.error('Error updating user status:', error);
            showNotification('Error updating user status', 'error');
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
                    <h1 className="text-3xl font-bold tracking-tight">Admin Dashboard</h1>
                    <p className="text-muted-foreground">Manage your store's products, orders, and categories.</p>
                </div>
                <div className="flex gap-4">
                    {activeTab === 'products' && (
                        <button
                            onClick={() => {
                                setEditingProduct(null);
                                setProductForm({ name: '', description: '', price: '', stockQuantity: '', categoryId: '' });
                                setImageFile(null);
                                setShowProductModal(true);
                            }}
                            className="admin-btn-primary"
                        >
                            <Plus className="h-5 w-5" /> Add Product
                        </button>
                    )}
                    {activeTab === 'categories' && (
                        <button
                            onClick={() => {
                                setEditingCategory(null);
                                setCategoryForm({ name: '', description: '' });
                                setShowCategoryModal(true);
                            }}
                            className="admin-btn-primary"
                        >
                            <Plus className="h-5 w-5" /> Add Category
                        </button>
                    )}
                </div>
            </div>

            {/* Tabs */}
            <div className="flex gap-4 border-b">
                {['overview', 'products', 'orders', 'categories', 'users'].map((tab) => (
                    <button
                        key={tab}
                        onClick={() => setActiveTab(tab)}
                        className={`pb-4 text-sm font-bold capitalize transition-all ${activeTab === tab ? 'border-b-2 border-primary text-primary' : 'text-muted-foreground hover:text-foreground'}`}
                    >
                        {tab}
                    </button>
                ))}
            </div>

            {/* Tab Content */}
            <div className="grid gap-8">
                {activeTab === 'overview' && (
                    <div className="space-y-8 animate-in">
                        <div className="grid grid-cols-1 gap-6 md:grid-cols-4">
                            <div className="admin-card delay-100">
                                <div className="flex items-center gap-4">
                                    <div className="rounded-2xl bg-blue-100 p-4 text-blue-600">
                                        <Package className="h-8 w-8" />
                                    </div>
                                    <div>
                                        <p className="text-sm font-medium text-muted-foreground">Products</p>
                                        <h3 className="text-3xl font-bold">{products.length}</h3>
                                    </div>
                                </div>
                            </div>
                            <div className="admin-card delay-200">
                                <div className="flex items-center gap-4">
                                    <div className="rounded-2xl bg-green-100 p-4 text-green-600">
                                        <ShoppingCart className="h-8 w-8" />
                                    </div>
                                    <div>
                                        <p className="text-sm font-medium text-muted-foreground">Orders</p>
                                        <h3 className="text-3xl font-bold">{analytics?.totalOrders || orders.length}</h3>
                                    </div>
                                </div>
                            </div>
                            <div className="admin-card delay-300">
                                <div className="flex items-center gap-4">
                                    <div className="rounded-2xl bg-yellow-100 p-4 text-yellow-600">
                                        <DollarSign className="h-8 w-8" />
                                    </div>
                                    <div>
                                        <p className="text-sm font-medium text-muted-foreground">Revenue</p>
                                        <h3 className="text-3xl font-bold">${analytics?.totalRevenue?.toFixed(2) || '0.00'}</h3>
                                    </div>
                                </div>
                            </div>
                            <div className="admin-card">
                                <div className="flex items-center gap-4">
                                    <div className="rounded-2xl bg-purple-100 p-4 text-purple-600">
                                        <Users className="h-8 w-8" />
                                    </div>
                                    <div>
                                        <p className="text-sm font-medium text-muted-foreground">Users</p>
                                        <h3 className="text-3xl font-bold">{analytics?.totalUsers || users.length}</h3>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div className="grid grid-cols-1 gap-8 lg:grid-cols-3">
                            {/* Revenue Chart */}
                            <div className="lg:col-span-2 admin-card">
                                <div className="mb-6 flex items-center justify-between">
                                    <h2 className="text-xl font-bold">Revenue Performance</h2>
                                    <div className="flex items-center gap-2 rounded-lg bg-green-50 px-3 py-1 text-xs font-bold text-green-600">
                                        <TrendingUp className="h-3 w-3" />
                                        +12.5% vs last month
                                    </div>
                                </div>
                                <div className="h-[300px]">
                                    <Line
                                        data={{
                                            labels: analytics?.revenueByMonth ? Object.keys(analytics.revenueByMonth).reverse() : [],
                                            datasets: [{
                                                label: 'Revenue',
                                                data: analytics?.revenueByMonth ? Object.values(analytics.revenueByMonth).reverse() : [],
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

                            {/* Top Selling Products */}
                            <div className="admin-card">
                                <h2 className="text-xl font-bold mb-6">Top Selling Products</h2>
                                <div className="h-[300px]">
                                    <Bar
                                        data={{
                                            labels: analytics?.topProducts?.map(p => p.productName.substring(0, 10) + '...') || [],
                                            datasets: [{
                                                label: 'Sales',
                                                data: analytics?.topProducts?.map(p => p.totalQuantity) || [],
                                                backgroundColor: 'rgba(139, 92, 246, 0.8)',
                                                borderRadius: 6
                                            }]
                                        }}
                                        options={{
                                            responsive: true,
                                            maintainAspectRatio: false,
                                            plugins: { legend: { display: false } },
                                            indexAxis: 'y',
                                            scales: {
                                                x: { beginAtZero: true, grid: { display: false } },
                                                y: { grid: { display: false } }
                                            }
                                        }}
                                    />
                                </div>
                            </div>
                        </div>

                        <div className="grid grid-cols-1 gap-8 lg:grid-cols-2">
                            <div className="admin-card">
                                <h2 className="text-xl font-bold mb-6">Recent Orders</h2>
                                <div className="space-y-4">
                                    {orders.slice(0, 5).map((order) => (
                                        <div key={order.id} className="flex items-center justify-between border-b pb-4 last:border-0">
                                            <div className="flex items-center gap-4">
                                                <div className="rounded-full bg-muted p-2">
                                                    <Package className="h-5 w-5 text-muted-foreground" />
                                                </div>
                                                <div>
                                                    <p className="font-bold">Order #ORD-{order.id.substring(0, 8)}</p>
                                                    <p className="text-xs text-muted-foreground">{new Date(order.orderDate).toLocaleString()}</p>
                                                </div>
                                            </div>
                                            <div className="text-right">
                                                <p className="font-bold text-primary">${order.totalAmount?.toFixed(2) || '0.00'}</p>
                                                <p className="text-xs font-bold text-green-600">{order.status}</p>
                                            </div>
                                        </div>
                                    ))}
                                </div>
                            </div>

                            <div className="admin-card">
                                <h2 className="text-xl font-bold mb-6">System Health</h2>
                                <div className="space-y-6">
                                    <div className="flex items-center justify-between">
                                        <div className="flex items-center gap-3">
                                            <div className="h-2 w-2 rounded-full bg-green-500 animate-pulse" />
                                            <span className="font-medium">API Server</span>
                                        </div>
                                        <span className="text-sm text-muted-foreground">99.9% Uptime</span>
                                    </div>
                                    <div className="flex items-center justify-between">
                                        <div className="flex items-center gap-3">
                                            <div className="h-2 w-2 rounded-full bg-green-500 animate-pulse" />
                                            <span className="font-medium">Database</span>
                                        </div>
                                        <span className="text-sm text-muted-foreground">Healthy</span>
                                    </div>
                                    <div className="flex items-center justify-between">
                                        <div className="flex items-center gap-3">
                                            <div className="h-2 w-2 rounded-full bg-blue-500 animate-pulse" />
                                            <span className="font-medium">Cloudinary Storage</span>
                                        </div>
                                        <span className="text-sm text-muted-foreground">Connected</span>
                                    </div>
                                    <div className="mt-6 rounded-2xl bg-slate-900 p-6 text-white">
                                        <div className="flex items-center justify-between mb-4">
                                            <span className="text-sm font-medium text-slate-400">Monthly Target</span>
                                            <span className="text-sm font-bold">75%</span>
                                        </div>
                                        <div className="h-2 w-full rounded-full bg-slate-800">
                                            <div className="h-full w-3/4 rounded-full bg-blue-500 shadow-[0_0_10px_rgba(59,130,246,0.5)]" />
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                )}

                {activeTab === 'products' && (
                    <div className="space-y-4 animate-in">
                        <div className="relative max-w-md">
                            <Search className="absolute left-3 top-1/2 h-4 w-4 -translate-y-1/2 text-muted-foreground" />
                            <input
                                type="text"
                                placeholder="Search products by name..."
                                value={productSearch}
                                onChange={(e) => setProductSearch(e.target.value)}
                                className="h-12 w-full rounded-full border bg-background pl-10 pr-4 text-sm focus:outline-none focus:ring-2 focus:ring-primary/20 transition-all"
                            />
                        </div>
                        <div className="admin-table-container">
                            <table className="w-full text-left">
                                <thead className="bg-muted/50">
                                    <tr>
                                        <th className="px-6 py-4 text-sm font-bold whitespace-nowrap">Product</th>
                                        <th className="px-6 py-4 text-sm font-bold whitespace-nowrap">Category</th>
                                        <th className="px-6 py-4 text-sm font-bold whitespace-nowrap">Seller</th>
                                        <th className="px-6 py-4 text-sm font-bold whitespace-nowrap">Price</th>
                                        <th className="px-6 py-4 text-sm font-bold whitespace-nowrap">Stock</th>
                                        <th className="px-6 py-4 text-sm font-bold whitespace-nowrap">Actions</th>
                                    </tr>
                                </thead>
                                <tbody className="divide-y">
                                    {products
                                        .filter(p => p.name.toLowerCase().includes(productSearch.toLowerCase()))
                                        .map((product) => (
                                            <tr key={product.id} className="hover:bg-muted/30 transition-colors">
                                                <td className="px-6 py-4">
                                                    <div className="flex items-center gap-3">
                                                        <img src={product.imageUrl} alt="" className="h-12 w-12 rounded-xl object-cover shadow-sm" />
                                                        <span className="font-bold">{product.name}</span>
                                                    </div>
                                                </td>
                                                <td className="px-6 py-4 text-sm text-muted-foreground whitespace-nowrap">{product.categoryName}</td>
                                                <td className="px-6 py-4">
                                                    <span className="inline-block whitespace-nowrap text-xs font-bold bg-slate-100 px-2 py-1 rounded-md text-slate-600">
                                                        {product.sellerName || 'Admin'}
                                                    </span>
                                                </td>
                                                <td className="px-6 py-4 font-bold text-primary whitespace-nowrap">${product.price?.toFixed(2) || '0.00'}</td>
                                                <td className="px-6 py-4">
                                                    <span className={`inline-block whitespace-nowrap rounded-full px-3 py-1 text-xs font-bold ${product.stockQuantity < 10 ? 'bg-red-100 text-red-600' : 'bg-green-100 text-green-600'}`}>
                                                        {product.stockQuantity} in stock
                                                    </span>
                                                </td>
                                                <td className="px-6 py-4">
                                                    <div className="flex gap-2">
                                                        <button onClick={() => openEditProduct(product)} className="p-2 hover:text-primary transition-all hover:scale-110"><Edit className="h-4 w-4" /></button>
                                                        <button onClick={() => deleteProduct(product.id)} className="p-2 hover:text-red-500 transition-all hover:scale-110"><Trash2 className="h-4 w-4" /></button>
                                                    </div>
                                                </td>
                                            </tr>
                                        ))}
                                </tbody>
                            </table>
                        </div>
                    </div>
                )}

                {activeTab === 'categories' && (
                    <div className="animate-in">
                        <div className="admin-table-container">
                            <table className="w-full text-left">
                                <thead className="bg-muted/50">
                                    <tr>
                                        <th className="px-6 py-4 text-sm font-bold">Name</th>
                                        <th className="px-6 py-4 text-sm font-bold">Description</th>
                                        <th className="px-6 py-4 text-sm font-bold">Actions</th>
                                    </tr>
                                </thead>
                                <tbody className="divide-y">
                                    {categories.map((cat) => (
                                        <tr key={cat.id} className="hover:bg-muted/30 transition-colors">
                                            <td className="px-6 py-4 font-bold">{cat.name}</td>
                                            <td className="px-6 py-4 text-sm text-muted-foreground">{cat.description}</td>
                                            <td className="px-6 py-4">
                                                <div className="flex gap-2">
                                                    <button
                                                        onClick={() => {
                                                            setEditingCategory(cat);
                                                            setCategoryForm({ name: cat.name, description: cat.description });
                                                            setShowCategoryModal(true);
                                                        }}
                                                        className="p-2 hover:text-primary transition-all hover:scale-110"
                                                    >
                                                        <Edit className="h-4 w-4" />
                                                    </button>
                                                    <button onClick={() => deleteCategory(cat.id)} className="p-2 hover:text-red-500 transition-all hover:scale-110"><Trash2 className="h-4 w-4" /></button>
                                                </div>
                                            </td>
                                        </tr>
                                    ))}
                                </tbody>
                            </table>
                        </div>
                    </div>
                )}

                {activeTab === 'orders' && (
                    <div className="animate-in">
                        <div className="admin-table-container">
                            <table className="w-full text-left">
                                <thead className="bg-muted/50">
                                    <tr>
                                        <th className="px-6 py-4 text-sm font-bold whitespace-nowrap">Order ID</th>
                                        <th className="px-6 py-4 text-sm font-bold whitespace-nowrap">Customer</th>
                                        <th className="px-6 py-4 text-sm font-bold whitespace-nowrap">Date</th>
                                        <th className="px-6 py-4 text-sm font-bold whitespace-nowrap">Total</th>
                                        <th className="px-6 py-4 text-sm font-bold whitespace-nowrap">Status</th>
                                        <th className="px-6 py-4 text-sm font-bold whitespace-nowrap">Actions</th>
                                    </tr>
                                </thead>
                                <tbody className="divide-y">
                                    {orders.map((order) => (
                                        <tr key={order.id} className="hover:bg-muted/30 transition-colors">
                                            <td className="px-6 py-4 font-mono font-bold text-primary">#ORD-{order.id.substring(0, 8)}</td>
                                            <td className="px-6 py-4">
                                                <div className="flex flex-col">
                                                    <span className="font-bold">{order.userName}</span>
                                                    <span className="text-xs text-muted-foreground">{order.userEmail}</span>
                                                </div>
                                            </td>
                                            <td className="px-6 py-4 text-sm">{new Date(order.orderDate).toLocaleDateString()}</td>
                                            <td className="px-6 py-4 font-bold text-primary">${order.totalAmount?.toFixed(2) || '0.00'}</td>
                                            <td className="px-6 py-4">
                                                <select
                                                    value={order.status}
                                                    onChange={(e) => updateOrderStatus(order.id, e.target.value)}
                                                    className="rounded-full bg-primary/10 px-3 py-1 text-xs font-bold text-primary outline-none border-none focus:ring-2 focus:ring-primary/20"
                                                >
                                                    <option value="PENDING">PENDING</option>
                                                    <option value="PAID">PAID</option>
                                                    <option value="SHIPPED">SHIPPED</option>
                                                    <option value="DELIVERED">DELIVERED</option>
                                                    <option value="CANCELLED">CANCELLED</option>
                                                </select>
                                            </td>
                                            <td className="px-6 py-4">
                                                <button
                                                    onClick={() => {
                                                        setSelectedOrder(order);
                                                        setShowOrderModal(true);
                                                    }}
                                                    className="text-xs font-bold text-primary hover:underline underline-offset-4"
                                                >
                                                    View Details
                                                </button>
                                            </td>
                                        </tr>
                                    ))}
                                </tbody>
                            </table>
                        </div>
                    </div>
                )}

                {activeTab === 'users' && (
                    <div className="space-y-4 animate-in">
                        <div className="flex flex-col md:flex-row gap-4 items-center justify-between">
                            <div className="relative w-full max-w-md">
                                <Search className="absolute left-3 top-1/2 h-4 w-4 -translate-y-1/2 text-muted-foreground" />
                                <input
                                    type="text"
                                    placeholder="Search users by name or email..."
                                    value={userSearch}
                                    onChange={(e) => setUserSearch(e.target.value)}
                                    className="h-12 w-full rounded-full border bg-background pl-10 pr-4 text-sm focus:outline-none focus:ring-2 focus:ring-primary/20 transition-all"
                                />
                            </div>
                            <div className="flex bg-muted p-1 rounded-2xl">
                                {['ALL', 'USER', 'SELLER', 'BANNED'].map((role) => (
                                    <button
                                        key={role}
                                        onClick={() => setUserRoleFilter(role)}
                                        className={`px-6 py-2 rounded-xl text-xs font-bold transition-all ${userRoleFilter === role ? 'bg-background shadow-sm text-primary' : 'text-muted-foreground hover:text-primary'}`}
                                    >
                                        {role === 'ALL' ? 'All Accounts' : role === 'USER' ? 'Customers' : role === 'SELLER' ? 'Sellers' : 'Banned'}
                                    </button>
                                ))}
                            </div>
                        </div>
                        <div className="admin-table-container">
                            <table className="w-full text-left">
                                <thead className="bg-muted/50">
                                    <tr>
                                        <th className="px-6 py-4 text-sm font-bold whitespace-nowrap">User</th>
                                        <th className="px-6 py-4 text-sm font-bold whitespace-nowrap">Roles</th>
                                        <th className="px-6 py-4 text-sm font-bold whitespace-nowrap">Status</th>
                                        <th className="px-6 py-4 text-sm font-bold whitespace-nowrap">Actions</th>
                                    </tr>
                                </thead>
                                <tbody className="divide-y">
                                    {users
                                        .filter(u => {
                                            const matchesSearch = u.username.toLowerCase().includes(userSearch.toLowerCase()) || u.email.toLowerCase().includes(userSearch.toLowerCase());
                                            let matchesRole = userRoleFilter === 'ALL' || u.roles.includes(`ROLE_${userRoleFilter}`);
                                            if (userRoleFilter === 'BANNED') {
                                                matchesRole = !u.isActive;
                                            }
                                            return matchesSearch && matchesRole;
                                        })
                                        .map((user) => (
                                            <tr key={user.id} className="hover:bg-muted/30 transition-colors">
                                                <td className="px-6 py-4">
                                                    <div className="flex items-center gap-3">
                                                        <div className={`h-10 w-10 rounded-full overflow-hidden flex items-center justify-center font-bold text-white border-2 border-primary/10 ${user.roles.includes('ROLE_SELLER') ? 'bg-purple-500' : 'bg-blue-500'}`}>
                                                            {user.profileImageUrl ? (
                                                                <img src={user.profileImageUrl} alt="" className="h-full w-full object-cover" />
                                                            ) : (
                                                                user.username.charAt(0).toUpperCase()
                                                            )}
                                                        </div>
                                                        <div>
                                                            <p className="font-bold text-sm">{user.username}</p>
                                                            <p className="text-xs text-muted-foreground">{user.email}</p>
                                                        </div>
                                                    </div>
                                                </td>
                                                <td className="px-6 py-4">
                                                    <div className="flex gap-1">
                                                        {user.roles.map(role => (
                                                            <span key={role} className={`rounded-full px-3 py-1 text-[10px] font-bold uppercase ${role === 'ROLE_ADMIN' ? 'bg-red-100 text-red-600' : role === 'ROLE_SELLER' ? 'bg-purple-100 text-purple-600' : 'bg-blue-100 text-blue-600'}`}>
                                                                {role.replace('ROLE_', '')}
                                                            </span>
                                                        ))}
                                                    </div>
                                                </td>
                                                <td className="px-6 py-4">
                                                    <span className={`inline-block whitespace-nowrap rounded-full px-3 py-1 text-xs font-bold ${user.isActive ? 'bg-green-100 text-green-600' : 'bg-red-100 text-red-600'}`}>
                                                        {user.isActive ? 'Active' : 'Banned'}
                                                    </span>
                                                </td>
                                                <td className="px-6 py-4">
                                                    {!user.roles.includes('ROLE_ADMIN') && (
                                                        <button
                                                            onClick={() => handleUserStatus(user.id, user.isActive)}
                                                            className={`text-xs font-bold hover:underline underline-offset-4 ${user.isActive ? 'text-red-500' : 'text-green-600'}`}
                                                        >
                                                            {user.isActive ? 'Ban Account' : 'Unban Account'}
                                                        </button>
                                                    )}
                                                </td>
                                            </tr>
                                        ))}
                                </tbody>
                            </table>
                        </div>
                    </div>
                )}
            </div>

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
                                        <div className="h-5 w-5 animate-spin rounded-full border-2 border-white border-t-transparent"></div>
                                    ) : (
                                        editingProduct ? 'Update Product' : 'Create Product'
                                    )}
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            )}
            {/* Category Modal */}
            {showCategoryModal && (
                <div className="fixed inset-0 z-50 flex items-center justify-center bg-black/50 backdrop-blur-sm p-4">
                    <div className="w-full max-w-md rounded-3xl bg-card p-8 shadow-2xl">
                        <div className="flex items-center justify-between mb-8">
                            <h2 className="text-2xl font-bold">{editingCategory ? 'Edit Category' : 'Add New Category'}</h2>
                            <button onClick={() => setShowCategoryModal(false)} className="rounded-full p-2 hover:bg-muted transition-colors">
                                <X className="h-6 w-6" />
                            </button>
                        </div>
                        <form onSubmit={handleCategorySubmit} className="space-y-6">
                            <div className="space-y-2">
                                <label className="text-sm font-bold">Category Name</label>
                                <input
                                    type="text"
                                    required
                                    value={categoryForm.name}
                                    onChange={(e) => setCategoryForm({ ...categoryForm, name: e.target.value })}
                                    className="w-full rounded-xl border bg-background p-4 text-sm outline-none focus:ring-2 focus:ring-primary/20"
                                />
                            </div>
                            <div className="space-y-2">
                                <label className="text-sm font-bold">Description</label>
                                <textarea
                                    required
                                    rows="3"
                                    value={categoryForm.description}
                                    onChange={(e) => setCategoryForm({ ...categoryForm, description: e.target.value })}
                                    className="w-full rounded-xl border bg-background p-4 text-sm outline-none focus:ring-2 focus:ring-primary/20"
                                />
                            </div>
                            <button
                                type="submit"
                                disabled={submitting}
                                className="w-full flex items-center justify-center gap-2 rounded-xl bg-primary py-4 font-bold text-primary-foreground transition-all hover:opacity-90 disabled:opacity-50"
                            >
                                {submitting ? (
                                    <div className="h-5 w-5 animate-spin rounded-full border-2 border-white border-t-transparent"></div>
                                ) : (
                                    editingCategory ? 'Update Category' : 'Create Category'
                                )}
                            </button>
                        </form>
                    </div>
                </div>
            )}
            {/* Order Details Modal */}
            {showOrderModal && selectedOrder && (
                <div className="fixed inset-0 z-50 flex items-center justify-center bg-black/50 backdrop-blur-sm p-4">
                    <div className="w-full max-w-2xl rounded-3xl bg-card p-8 shadow-2xl overflow-y-auto max-h-[90vh]">
                        <div className="flex items-center justify-between mb-8">
                            <div>
                                <h2 className="text-2xl font-bold">Order Details</h2>
                                <p className="text-sm text-muted-foreground">#ORD-{selectedOrder.id}</p>
                            </div>
                            <button onClick={() => setShowOrderModal(false)} className="rounded-full p-2 hover:bg-muted transition-colors">
                                <X className="h-6 w-6" />
                            </button>
                        </div>

                        <div className="grid grid-cols-1 md:grid-cols-2 gap-8 mb-8">
                            <div className="space-y-4">
                                <h3 className="font-bold text-lg border-b pb-2">Customer Info</h3>
                                <div>
                                    <p className="text-sm font-medium text-muted-foreground">Name</p>
                                    <p className="font-bold">{selectedOrder.userName}</p>
                                </div>
                                <div>
                                    <p className="text-sm font-medium text-muted-foreground">Email</p>
                                    <p className="font-bold">{selectedOrder.userEmail}</p>
                                </div>
                                <div>
                                    <p className="text-sm font-medium text-muted-foreground">Shipping Address</p>
                                    <p className="font-bold">{selectedOrder.shippingAddress}</p>
                                </div>
                            </div>
                            <div className="space-y-4">
                                <h3 className="font-bold text-lg border-b pb-2">Order Summary</h3>
                                <div>
                                    <p className="text-sm font-medium text-muted-foreground">Date</p>
                                    <p className="font-bold">{new Date(selectedOrder.orderDate).toLocaleString()}</p>
                                </div>
                                <div>
                                    <p className="text-sm font-medium text-muted-foreground">Status</p>
                                    <span className="rounded-full bg-primary/10 px-3 py-1 text-xs font-bold text-primary">
                                        {selectedOrder.status}
                                    </span>
                                </div>
                                <div>
                                    <p className="text-sm font-medium text-muted-foreground">Total Amount</p>
                                    <p className="text-2xl font-extrabold text-primary">${selectedOrder.totalAmount?.toFixed(2) || '0.00'}</p>
                                </div>
                            </div>
                        </div>

                        <div className="space-y-4">
                            <h3 className="font-bold text-lg border-b pb-2">Order Items</h3>
                            <div className="space-y-4">
                                {selectedOrder.items.map((item) => (
                                    <div key={item.id} className="flex items-center justify-between">
                                        <div className="flex items-center gap-4">
                                            <div className="h-12 w-12 rounded-lg bg-muted flex items-center justify-center font-bold text-muted-foreground">
                                                {item.productName.charAt(0)}
                                            </div>
                                            <div>
                                                <p className="font-bold">{item.productName}</p>
                                                <p className="text-xs text-muted-foreground">Qty: {item.quantity} x ${item.price?.toFixed(2) || '0.00'}</p>
                                            </div>
                                        </div>
                                        <p className="font-bold">${((item.quantity || 0) * (item.price || 0)).toFixed(2)}</p>
                                    </div>
                                ))}
                            </div>
                        </div>
                    </div>
                </div>
            )}
        </div>
    );
};

export default AdminDashboard;
