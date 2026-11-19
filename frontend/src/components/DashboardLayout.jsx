import React, { useState } from 'react';
import { Link, useLocation, useNavigate } from 'react-router-dom';
import { useAuth } from '../context/AuthContext';
import {
    ShoppingBag,
    Bell,
    LogOut,
    Menu,
    X,
    LayoutDashboard,
    Package,
    ShoppingCart,
    Users,
    Tag,
    BarChart2,
    Store,
    ArrowLeft
} from 'lucide-react';

const ADMIN_NAV = [
    { id: 'overview', label: 'Overview', icon: LayoutDashboard, path: '/admin' },
    { id: 'products', label: 'Products', icon: Package, path: '/admin/products' },
    { id: 'orders', label: 'Orders', icon: ShoppingCart, path: '/admin/orders' },
    { id: 'categories', label: 'Categories', icon: Tag, path: '/admin/categories' },
    { id: 'users', label: 'Users', icon: Users, path: '/admin/users' },
];

const SELLER_NAV = [
    { id: 'overview', label: 'Overview', icon: LayoutDashboard, path: '/seller' },
    { id: 'products', label: 'My Products', icon: Package, path: '/seller/products' },
    { id: 'orders', label: 'Orders', icon: ShoppingCart, path: '/seller/orders' },
];

const SidebarItem = ({ item, isActive, onClick }) => {
    const Icon = item.icon;
    if (onClick) {
        return (
            <button
                type="button"
                onClick={onClick}
                className={`w-full flex items-center gap-3 px-4 py-3 rounded-xl text-sm font-medium transition-all text-left ${
                    isActive
                        ? 'bg-blue-600 text-white shadow-lg shadow-blue-600/20'
                        : 'text-slate-400 hover:bg-slate-800 hover:text-white'
                }`}
            >
                {Icon && <Icon className="h-4 w-4 flex-shrink-0" />}
                <span>{item.label}</span>
            </button>
        );
    }
    return (
        <Link
            to={item.path}
            className={`flex items-center gap-3 px-4 py-3 rounded-xl text-sm font-medium transition-all ${
                isActive
                    ? 'bg-blue-600 text-white shadow-lg shadow-blue-600/20'
                    : 'text-slate-400 hover:bg-slate-800 hover:text-white'
            }`}
        >
            {Icon && <Icon className="h-4 w-4 flex-shrink-0" />}
            <span>{item.label}</span>
        </Link>
    );
};

const DashboardLayout = ({ children, navItems, pageTitle, role, activeTab, onTabChange }) => {
    const { user, logout } = useAuth();
    const location = useLocation();
    const navigate = useNavigate();
    const [mobileOpen, setMobileOpen] = useState(false);

    const resolvedRole = role || 'admin';
    const resolvedNavItems = navItems || (resolvedRole === 'admin' ? ADMIN_NAV : SELLER_NAV);

    const handleLogout = () => {
        logout();
        navigate('/login');
    };

    const getIsActive = (item) => {
        if (onTabChange && activeTab) {
            return item.id === activeTab;
        }
        if (location.pathname === item.path) return true;
        if (item.path === '/admin' || item.path === '/seller') return location.pathname === item.path;
        return location.pathname.startsWith(item.path);
    };

    const roleBadgeColor = resolvedRole === 'admin' ? 'bg-red-500' : 'bg-purple-500';
    const roleBadgeLabel = resolvedRole === 'admin' ? 'Administrator' : 'Merchant';

    const userInitial = user?.username
        ? user.username.charAt(0).toUpperCase()
        : user?.email
        ? user.email.charAt(0).toUpperCase()
        : 'U';

    const sidebarContent = (
        <div className="flex h-full flex-col bg-slate-950 text-white">
            {/* Logo area */}
            <div className="p-6 border-b border-slate-800">
                <Link to="/" className="flex items-center gap-2 mb-3">
                    <div className="h-9 w-9 rounded-xl bg-blue-600 flex items-center justify-center shadow-md shadow-blue-600/30">
                        <ShoppingBag className="h-5 w-5 text-white" />
                    </div>
                    <span className="text-xl font-black text-white tracking-tight">ShopStack</span>
                    <span className="text-xl font-black bg-gradient-to-r from-blue-400 to-indigo-400 bg-clip-text text-transparent">Pro</span>
                </Link>
                <div className="flex items-center gap-2">
                    <span className={`inline-flex items-center px-2.5 py-0.5 rounded-full text-[11px] font-bold text-white ${roleBadgeColor}`}>
                        {roleBadgeLabel}
                    </span>
                    <Link
                        to="/"
                        className="text-[11px] font-semibold text-slate-400 hover:text-white flex items-center gap-1 transition-colors ml-auto"
                        title="Return to Public Storefront"
                    >
                        <ArrowLeft className="h-3 w-3" /> Storefront
                    </Link>
                </div>
            </div>

            {/* Navigation links */}
            <nav className="flex-1 p-4 space-y-1.5 overflow-y-auto">
                {resolvedNavItems.map((item) => (
                    <SidebarItem
                        key={item.id || item.path}
                        item={item}
                        isActive={getIsActive(item)}
                        onClick={onTabChange ? () => {
                            onTabChange(item.id);
                            setMobileOpen(false);
                        } : undefined}
                    />
                ))}
            </nav>

            {/* User footer */}
            <div className="p-4 border-t border-slate-800">
                <div className="flex items-center gap-3 mb-3">
                    <div className="h-10 w-10 rounded-full bg-slate-800 flex items-center justify-center overflow-hidden flex-shrink-0 border border-slate-700">
                        {user?.profileImageUrl ? (
                            <img src={user.profileImageUrl} alt="avatar" className="h-full w-full object-cover" />
                        ) : (
                            <span className="text-sm font-bold text-white">{userInitial}</span>
                        )}
                    </div>
                    <div className="min-w-0 flex-1">
                        <p className="text-sm font-bold text-white truncate">{user?.username || 'User'}</p>
                        <p className="text-xs text-slate-400 truncate">{user?.email || ''}</p>
                    </div>
                </div>
                <button
                    onClick={handleLogout}
                    className="w-full flex items-center justify-center gap-2 px-3 py-2.5 rounded-xl text-xs font-bold text-slate-400 bg-slate-900 hover:bg-red-500/10 hover:text-red-400 border border-slate-800 transition-all"
                >
                    <LogOut className="h-4 w-4" /> Sign Out
                </button>
            </div>
        </div>
    );

    return (
        <div className="flex h-screen overflow-hidden bg-slate-50 dark:bg-background">
            {/* Desktop Sidebar */}
            <aside className="hidden lg:flex w-64 flex-shrink-0 flex-col border-r border-slate-800">
                {sidebarContent}
            </aside>

            {/* Mobile Sidebar Drawer */}
            {mobileOpen && (
                <div className="fixed inset-0 z-50 lg:hidden flex">
                    <div className="fixed inset-0 bg-black/60 backdrop-blur-sm" onClick={() => setMobileOpen(false)} />
                    <div className="relative w-64 max-w-[80vw] h-full z-10">
                        {sidebarContent}
                    </div>
                </div>
            )}

            {/* Main content container */}
            <div className="flex-1 flex flex-col overflow-hidden">
                {/* Header bar */}
                <header className="h-16 bg-white dark:bg-card border-b border-slate-200 dark:border-border flex items-center px-4 sm:px-6 justify-between flex-shrink-0">
                    <div className="flex items-center gap-3">
                        <button
                            type="button"
                            onClick={() => setMobileOpen(!mobileOpen)}
                            className="lg:hidden p-2 rounded-xl hover:bg-slate-100 dark:hover:bg-muted text-slate-700 dark:text-foreground"
                            aria-label="Toggle Navigation"
                        >
                            <Menu className="h-5 w-5" />
                        </button>
                        <h1 className="text-lg font-bold text-slate-900 dark:text-foreground">
                            {pageTitle || (resolvedRole === 'admin' ? 'Administrator Portal' : 'Merchant Seller Hub')}
                        </h1>
                    </div>

                    <div className="flex items-center gap-3 sm:gap-4">
                        <Link
                            to="/"
                            className="hidden sm:inline-flex items-center gap-1.5 px-3 py-1.5 rounded-xl text-xs font-bold border border-slate-200 dark:border-border hover:bg-slate-100 dark:hover:bg-muted text-slate-700 dark:text-foreground transition-colors"
                        >
                            <ShoppingBag className="h-3.5 w-3.5" /> View Store
                        </Link>

                        <div className="flex items-center gap-2 pl-2 border-l border-slate-200 dark:border-border">
                            <div className="h-8 w-8 rounded-full bg-blue-100 dark:bg-blue-900/30 flex items-center justify-center overflow-hidden">
                                {user?.profileImageUrl ? (
                                    <img src={user.profileImageUrl} alt="avatar" className="h-full w-full object-cover" />
                                ) : (
                                    <span className="text-xs font-bold text-blue-600 dark:text-blue-400">{userInitial}</span>
                                )}
                            </div>
                            <span className="hidden md:block text-xs font-bold text-slate-700 dark:text-foreground">
                                {user?.username || 'User'}
                            </span>
                        </div>
                    </div>
                </header>

                {/* Dashboard view area */}
                <main className="flex-1 overflow-y-auto p-4 sm:p-6 lg:p-8">
                    {children}
                </main>
            </div>
        </div>
    );
};

export default DashboardLayout;
