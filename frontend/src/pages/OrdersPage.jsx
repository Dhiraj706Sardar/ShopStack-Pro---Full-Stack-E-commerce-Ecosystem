import React, { useState, useEffect } from 'react';
import api from '../api/axios';
import { Package, Calendar, MapPin, CheckCircle2, Clock, Truck, XCircle, Download } from 'lucide-react';

const OrdersPage = () => {
    const [orders, setOrders] = useState([]);
    const [loading, setLoading] = useState(true);
    const [downloading, setDownloading] = useState(null);

    useEffect(() => {
        fetchOrders();
    }, []);

    const fetchOrders = async () => {
        try {
            const response = await api.get('/user/orders');
            setOrders(response.data.sort((a, b) => new Date(b.orderDate) - new Date(a.orderDate)));
        } catch (error) {
            console.error('Error fetching orders:', error);
        } finally {
            setLoading(false);
        }
    };

    const handleDownloadInvoice = async (orderId) => {
        setDownloading(orderId);
        try {
            const response = await api.get(`/user/orders/${orderId}/invoice`, {
                responseType: 'blob',
            });
            const url = window.URL.createObjectURL(new Blob([response.data]));
            const link = document.createElement('a');
            link.href = url;
            link.setAttribute('download', `invoice_${orderId}.pdf`);
            document.body.appendChild(link);
            link.click();
            link.remove();
        } catch (error) {
            console.error('Error downloading invoice:', error);
            alert('Failed to download invoice');
        } finally {
            setDownloading(null);
        }
    };

    const getStatusIcon = (status) => {
        switch (status) {
            case 'PENDING': return <Clock className="h-5 w-5 text-yellow-500" />;
            case 'PAID': return <CheckCircle2 className="h-5 w-5 text-blue-500" />;
            case 'SHIPPED': return <Truck className="h-5 w-5 text-purple-500" />;
            case 'DELIVERED': return <CheckCircle2 className="h-5 w-5 text-green-500" />;
            case 'CANCELLED': return <XCircle className="h-5 w-5 text-destructive" />;
            default: return <Package className="h-5 w-5" />;
        }
    };

    if (loading) return (
        <div className="flex h-96 items-center justify-center">
            <div className="h-12 w-12 animate-spin rounded-full border-4 border-primary border-t-transparent"></div>
        </div>
    );

    return (
        <div className="flex flex-col gap-8">
            <h1 className="text-3xl font-bold tracking-tight">My Orders</h1>

            <div className="flex flex-col gap-6">
                {orders.map((order) => (
                    <div key={order.id} className="overflow-hidden rounded-3xl border bg-card shadow-sm transition-all hover:shadow-md">
                        <div className="flex flex-col border-b bg-muted/30 p-6 md:flex-row md:items-center md:justify-between">
                            <div className="grid grid-cols-2 gap-8 md:flex md:gap-12">
                                <div>
                                    <p className="text-xs font-bold uppercase tracking-wider text-muted-foreground">Order ID</p>
                                    <p className="font-mono text-sm font-bold">#ORD-{order.id}</p>
                                </div>
                                <div>
                                    <p className="text-xs font-bold uppercase tracking-wider text-muted-foreground">Date</p>
                                    <div className="flex items-center gap-2 font-medium">
                                        <Calendar className="h-4 w-4" />
                                        {new Date(order.orderDate).toLocaleDateString()}
                                    </div>
                                </div>
                                <div>
                                    <p className="text-xs font-bold uppercase tracking-wider text-muted-foreground">Total</p>
                                    <p className="font-bold text-primary">${order.totalAmount.toFixed(2)}</p>
                                </div>
                            </div>
                            <div className="mt-4 flex flex-col md:flex-row items-start md:items-center gap-4 md:mt-0">
                                <div className="flex items-center gap-2 rounded-full bg-background px-4 py-2 text-sm font-bold shadow-sm">
                                    {getStatusIcon(order.status)}
                                    {order.status}
                                </div>
                                <button
                                    onClick={() => handleDownloadInvoice(order.id)}
                                    disabled={downloading === order.id}
                                    className="flex items-center gap-2 rounded-full bg-primary/10 px-4 py-2 text-sm font-bold text-primary hover:bg-primary/20 disabled:opacity-50"
                                >
                                    {downloading === order.id ? (
                                        <div className="h-4 w-4 animate-spin rounded-full border-2 border-primary border-t-transparent"></div>
                                    ) : (
                                        <Download className="h-4 w-4" />
                                    )}
                                    Invoice
                                </button>
                            </div>
                        </div>

                        <div className="p-6">
                            <div className="mb-6 flex items-start gap-3 text-sm">
                                <MapPin className="mt-0.5 h-4 w-4 text-muted-foreground" />
                                <div>
                                    <p className="font-bold">Shipping Address</p>
                                    <p className="text-muted-foreground">{order.shippingAddress}</p>
                                </div>
                            </div>

                            <div className="space-y-4">
                                {order.items.map((item) => (
                                    <div key={item.id} className="flex items-center justify-between rounded-xl bg-muted/20 p-4">
                                        <div className="flex items-center gap-4">
                                            <div className="h-12 w-12 rounded-lg bg-muted flex items-center justify-center">
                                                <Package className="h-6 w-6 text-muted-foreground" />
                                            </div>
                                            <div>
                                                <p className="font-bold">{item.productName}</p>
                                                <p className="text-xs text-muted-foreground">Qty: {item.quantity}</p>
                                            </div>
                                        </div>
                                        <p className="font-bold">${(item.price * item.quantity).toFixed(2)}</p>
                                    </div>
                                ))}
                            </div>
                        </div>
                    </div>
                ))}

                {orders.length === 0 && (
                    <div className="flex flex-col items-center justify-center py-20 text-center">
                        <div className="rounded-full bg-muted p-8 mb-6">
                            <Package className="h-16 w-16 text-muted-foreground" />
                        </div>
                        <h2 className="text-2xl font-bold">No orders yet</h2>
                        <p className="mt-2 text-muted-foreground">When you buy something, it will appear here.</p>
                    </div>
                )}
            </div>
        </div>
    );
};

export default OrdersPage;
