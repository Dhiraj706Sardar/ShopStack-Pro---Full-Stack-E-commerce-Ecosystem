import React from 'react';
import { HashRouter as Router, Routes, Route, Navigate, useLocation } from 'react-router-dom';
import { AuthProvider, useAuth } from './context/AuthContext';
import Navbar from './components/Navbar';
import Footer from './components/Footer';

import HomePage from './pages/HomePage';
import ProductListingPage from './pages/ProductListingPage';
import ProductDetailsPage from './pages/ProductDetailsPage';
import CartPage from './pages/CartPage';
import CheckoutPage from './pages/CheckoutPage';
import OrdersPage from './pages/OrdersPage';
import LoginPage from './pages/LoginPage';
import RegisterPage from './pages/RegisterPage';
import AdminDashboard from './pages/AdminDashboard';
import SellerDashboard from './pages/SellerDashboard';
import WishlistPage from './pages/WishlistPage';
import ProfilePage from './pages/ProfilePage';
import ForgotPasswordPage from './pages/ForgotPasswordPage';
import ResetPasswordPage from './pages/ResetPasswordPage';

const ProtectedRoute = ({ children, roles }) => {
  const { user, loading } = useAuth();
  const location = useLocation();

  if (loading) return (
    <div className="flex h-screen items-center justify-center">
      <div className="h-12 w-12 animate-spin rounded-full border-4 border-primary border-t-transparent"></div>
    </div>
  );

  if (!user) {
    return <Navigate to="/login" state={{ from: location }} replace />;
  }

  if (roles && !roles.some(role => user.roles?.includes(role))) {
    return <Navigate to="/" replace />;
  }

  return children;
};

// StoreLayout: standard store pages with Navbar, container padding, and Footer
const StoreLayout = ({ children }) => (
  <div className="min-h-screen bg-background text-foreground flex flex-col justify-between">
    <div>
      <Navbar />
      <main className="container mx-auto px-4 py-8">
        {children}
      </main>
    </div>
    <Footer />
  </div>
);

// AuthLayout: full-screen split-screen auth pages with Navbar on top and Footer at bottom
const AuthLayout = ({ children }) => (
  <div className="min-h-screen bg-background text-foreground flex flex-col justify-between">
    <Navbar />
    <main className="flex-1">
      {children}
    </main>
    <Footer />
  </div>
);

function App() {
  return (
    <AuthProvider>
      <Router>
        <Routes>
          {/* Isolated Dashboard Portals (no store Navbar/Footer; use own full-height sidebar layout) */}
          <Route path="/admin/*" element={
            <ProtectedRoute roles={['ROLE_ADMIN']}>
              <AdminDashboard />
            </ProtectedRoute>
          } />

          <Route path="/seller/*" element={
            <ProtectedRoute roles={['ROLE_SELLER']}>
              <SellerDashboard />
            </ProtectedRoute>
          } />

          {/* Full-screen Split Auth Routes */}
          <Route path="/login" element={<AuthLayout><LoginPage /></AuthLayout>} />
          <Route path="/register" element={<AuthLayout><RegisterPage /></AuthLayout>} />
          <Route path="/forgot-password" element={<AuthLayout><ForgotPasswordPage /></AuthLayout>} />
          <Route path="/reset-password" element={<AuthLayout><ResetPasswordPage /></AuthLayout>} />

          {/* Public Storefront Routes */}
          <Route path="/" element={<StoreLayout><HomePage /></StoreLayout>} />
          <Route path="/products" element={<StoreLayout><ProductListingPage /></StoreLayout>} />
          <Route path="/products/:id" element={<StoreLayout><ProductDetailsPage /></StoreLayout>} />

          {/* Protected Customer Routes */}
          <Route path="/cart" element={
            <ProtectedRoute>
              <StoreLayout><CartPage /></StoreLayout>
            </ProtectedRoute>
          } />

          <Route path="/checkout" element={
            <ProtectedRoute>
              <StoreLayout><CheckoutPage /></StoreLayout>
            </ProtectedRoute>
          } />

          <Route path="/orders" element={
            <ProtectedRoute>
              <StoreLayout><OrdersPage /></StoreLayout>
            </ProtectedRoute>
          } />

          <Route path="/wishlist" element={
            <ProtectedRoute>
              <StoreLayout><WishlistPage /></StoreLayout>
            </ProtectedRoute>
          } />

          <Route path="/profile" element={
            <ProtectedRoute>
              <StoreLayout><ProfilePage /></StoreLayout>
            </ProtectedRoute>
          } />

          {/* Fallback */}
          <Route path="*" element={<Navigate to="/" replace />} />
        </Routes>
      </Router>
    </AuthProvider>
  );
}

export default App;
