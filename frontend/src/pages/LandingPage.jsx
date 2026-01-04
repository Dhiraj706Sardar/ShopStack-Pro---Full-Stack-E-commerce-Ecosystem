import React, { useState, useEffect } from 'react';
import { Link } from 'react-router-dom';
import api from '../api/axios';
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
import { Line, Bar, Doughnut } from 'react-chartjs-2';
import {
    TrendingUp,
    Users,
    ShoppingBag,
    DollarSign,
    ArrowUpRight,
    ArrowDownRight,
    Activity,
    Package,
    ArrowRight
} from 'lucide-react';

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

const LandingPage = () => {
    const [stats, setStats] = useState(null);
    const [loading, setLoading] = useState(true);

    useEffect(() => {
        fetchStats();
    }, []);

    const fetchStats = async () => {
        try {
            const response = await api.get('/public/analytics/stats');
            setStats(response.data);
        } catch (error) {
            console.error('Error fetching stats:', error);
        } finally {
            setLoading(false);
        }
    };

    if (loading) {
        return (
            <div className="flex h-[80vh] items-center justify-center">
                <div className="relative h-20 w-20">
                    <div className="absolute h-full w-full animate-ping rounded-full bg-primary/20"></div>
                    <div className="absolute h-full w-full animate-spin rounded-full border-4 border-primary border-t-transparent"></div>
                </div>
            </div>
        );
    }

    // Chart Data
    const revenueData = {
        labels: stats?.revenueByMonth ? Object.keys(stats.revenueByMonth).reverse() : [],
        datasets: [
            {
                fill: true,
                label: 'Monthly Revenue',
                data: stats?.revenueByMonth ? Object.values(stats.revenueByMonth).reverse() : [],
                borderColor: 'rgb(59, 130, 246)',
                backgroundColor: 'rgba(59, 130, 246, 0.1)',
                tension: 0.4,
                pointBackgroundColor: 'rgb(59, 130, 246)',
                pointBorderColor: '#fff',
                pointHoverRadius: 6,
            },
        ],
    };

    const topProductsData = {
        labels: stats?.topProducts?.map(p => p.productName) || [],
        datasets: [
            {
                label: 'Units Sold',
                data: stats?.topProducts?.map(p => p.totalQuantity) || [],
                backgroundColor: [
                    'rgba(59, 130, 246, 0.8)',
                    'rgba(16, 185, 129, 0.8)',
                    'rgba(245, 158, 11, 0.8)',
                    'rgba(139, 92, 246, 0.8)',
                    'rgba(236, 72, 153, 0.8)',
                ],
                borderRadius: 8,
            },
        ],
    };

    const chartOptions = {
        responsive: true,
        maintainAspectRatio: false,
        plugins: {
            legend: {
                display: false,
            },
            tooltip: {
                backgroundColor: '#1e293b',
                padding: 12,
                titleFont: { size: 14, weight: 'bold' },
                bodyFont: { size: 13 },
                displayColors: false,
            },
        },
        scales: {
            y: {
                beginAtZero: true,
                grid: {
                    display: true,
                    color: 'rgba(0,0,0,0.05)',
                },
                ticks: {
                    font: { size: 12 },
                    callback: (value) => '$' + value,
                },
            },
            x: {
                grid: {
                    display: false,
                },
                ticks: {
                    font: { size: 12 },
                },
            },
        },
    };

    return (
        <div className="flex flex-col gap-10 pb-20">
            {/* Hero Section */}
            <header className="relative overflow-hidden rounded-[2.5rem] bg-slate-950 px-8 py-20 text-white md:px-20">
                <div className="relative z-10 flex flex-col items-center text-center gap-6">
                    <div className="inline-flex items-center gap-2 rounded-full bg-white/10 px-4 py-2 text-sm font-medium backdrop-blur-md">
                        <Activity className="h-4 w-4 text-blue-400" />
                        Live Market Insights
                    </div>
                    <h1 className="text-4xl font-black tracking-tight md:text-6xl lg:text-7xl">
                        Real-Time <span className="bg-gradient-to-r from-blue-400 to-emerald-400 bg-clip-text text-transparent">Commerce</span> Analytics
                    </h1>
                    <p className="max-w-2xl text-lg text-slate-400 md:text-xl">
                        Experience the pulse of our marketplace. Transparent data,
                        growth metrics, and trend analysis at your fingertips.
                    </p>
                    <div className="mt-4 flex flex-wrap justify-center gap-4">
                        <Link
                            to="/products"
                            className="group flex items-center gap-2 rounded-full bg-white px-8 py-4 text-lg font-bold text-slate-950 transition-all hover:scale-105 hover:bg-blue-50"
                        >
                            Explore Products <ArrowRight className="h-5 w-5 transition-transform group-hover:translate-x-1" />
                        </Link>
                        {stats && (
                            <Link
                                to="/"
                                className="flex items-center gap-2 rounded-full border border-white/20 bg-white/5 px-8 py-4 text-lg font-bold text-white backdrop-blur-md transition-all hover:bg-white/10"
                            >
                                View Live Dashboard
                            </Link>
                        )}
                    </div>
                </div>
                {/* Abstract Background Elements */}
                <div className="absolute -right-20 -top-20 h-96 w-96 rounded-full bg-blue-600/20 blur-[100px]" />
                <div className="absolute -left-20 -bottom-20 h-96 w-96 rounded-full bg-emerald-600/20 blur-[100px]" />
            </header>

            {/* Stats Grid */}
            <section className="grid grid-cols-1 gap-6 sm:grid-cols-2 lg:grid-cols-4">
                <StatCard
                    title="Total Revenue"
                    value={`$${stats?.totalRevenue?.toLocaleString() || '0'}`}
                    icon={<DollarSign className="h-6 w-6" />}
                    trend="+12.5%"
                    color="blue"
                />
                <StatCard
                    title="Total Orders"
                    value={stats?.totalOrders?.toLocaleString() || '0'}
                    icon={<ShoppingBag className="h-6 w-6" />}
                    trend="+8.2%"
                    color="emerald"
                />
                <StatCard
                    title="Active Users"
                    value={stats?.totalUsers?.toLocaleString() || '0'}
                    icon={<Users className="h-6 w-6" />}
                    trend="+5.4%"
                    color="purple"
                />
                <StatCard
                    title="Growth Rate"
                    value="24.8%"
                    icon={<TrendingUp className="h-6 w-6" />}
                    trend="+2.1%"
                    color="amber"
                />
            </section>

            {/* Charts Section */}
            <section className="grid grid-cols-1 gap-8 lg:grid-cols-3">
                {/* Revenue Chart */}
                <div className="lg:col-span-2 rounded-[2rem] border bg-card p-8 shadow-sm transition-all hover:shadow-md">
                    <div className="mb-8 flex items-center justify-between">
                        <div>
                            <h3 className="text-xl font-bold">Revenue Overview</h3>
                            <p className="text-sm text-muted-foreground">Monthly income performance</p>
                        </div>
                        <div className="rounded-xl bg-blue-50 px-4 py-2 text-sm font-bold text-blue-600">
                            Last 6 Months
                        </div>
                    </div>
                    <div className="h-[350px] w-full">
                        <Line data={revenueData} options={chartOptions} />
                    </div>
                </div>

                {/* Top Products Chart */}
                <div className="rounded-[2rem] border bg-card p-8 shadow-sm transition-all hover:shadow-md">
                    <div className="mb-8">
                        <h3 className="text-xl font-bold">Top Sellers</h3>
                        <p className="text-sm text-muted-foreground">Most popular products by volume</p>
                    </div>
                    <div className="h-[350px] w-full">
                        <Bar
                            data={topProductsData}
                            options={{
                                ...chartOptions,
                                indexAxis: 'y',
                                plugins: { ...chartOptions.plugins, legend: { display: false } }
                            }}
                        />
                    </div>
                </div>
            </section>

            {/* Recent Activity / Trends */}
            <section className="grid grid-cols-1 gap-8 md:grid-cols-2">
                <div className="rounded-[2rem] border bg-card p-8 shadow-sm">
                    <h3 className="mb-6 text-xl font-bold">Market Trends</h3>
                    <div className="space-y-6">
                        {[
                            { label: 'Sustainable Fashion', growth: 85, color: 'bg-emerald-500' },
                            { label: 'Smart Electronics', growth: 62, color: 'bg-blue-500' },
                            { label: 'Home Decor', growth: 45, color: 'bg-purple-500' },
                            { label: 'Luxury Accessories', growth: 38, color: 'bg-amber-500' },
                        ].map((trend, i) => (
                            <div key={i} className="space-y-2">
                                <div className="flex justify-between text-sm font-medium">
                                    <span>{trend.label}</span>
                                    <span className="text-muted-foreground">{trend.growth}% Growth</span>
                                </div>
                                <div className="h-2 w-full overflow-hidden rounded-full bg-muted">
                                    <div
                                        className={`h-full ${trend.color} transition-all duration-1000`}
                                        style={{ width: `${trend.growth}%` }}
                                    />
                                </div>
                            </div>
                        ))}
                    </div>
                </div>

                <div className="flex flex-col items-center justify-center rounded-[2rem] bg-gradient-to-br from-blue-600 to-indigo-700 p-10 text-center text-white shadow-xl">
                    <div className="mb-6 rounded-full bg-white/20 p-6 backdrop-blur-lg">
                        <Package className="h-12 w-12" />
                    </div>
                    <h3 className="mb-4 text-3xl font-black">Ready to scale?</h3>
                    <p className="mb-8 text-blue-100">
                        Join our ecosystem of sellers and buyers. Start your journey today
                        with the most advanced commerce platform.
                    </p>
                    <Link
                        to="/register"
                        className="rounded-full bg-white px-10 py-4 text-lg font-bold text-blue-600 transition-transform hover:scale-105 active:scale-95"
                    >
                        Get Started Now
                    </Link>
                </div>
            </section>
        </div>
    );
};

const StatCard = ({ title, value, icon, trend, color }) => {
    const colors = {
        blue: 'bg-blue-50 text-blue-600 border-blue-100',
        emerald: 'bg-emerald-50 text-emerald-600 border-emerald-100',
        purple: 'bg-purple-50 text-purple-600 border-purple-100',
        amber: 'bg-amber-50 text-amber-600 border-amber-100',
    };

    return (
        <div className="group rounded-[2rem] border bg-card p-6 shadow-sm transition-all hover:shadow-md hover:-translate-y-1">
            <div className="mb-4 flex items-center justify-between">
                <div className={`rounded-2xl p-3 transition-transform group-hover:scale-110 ${colors[color]}`}>
                    {icon}
                </div>
                <div className="flex items-center gap-1 text-sm font-bold text-emerald-600">
                    <ArrowUpRight className="h-4 w-4" />
                    {trend}
                </div>
            </div>
            <div>
                <p className="text-sm font-medium text-muted-foreground">{title}</p>
                <h3 className="text-3xl font-black tracking-tight">{value}</h3>
            </div>
        </div>
    );
};

export default LandingPage;
