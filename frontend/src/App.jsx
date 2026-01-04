import React from 'react';
import { BrowserRouter as Router, Routes, Route, Navigate } from 'react-router-dom';
import { AuthProvider, useAuth } from './context/AuthContext';
import Navbar from './components/Navbar';

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
  console.log('ProtectedRoute check:', { hasUser: !!user, loading, requiredRoles: roles });

  if (loading) return (
    <div className="flex h-screen items-center justify-center">
      <div className="h-12 w-12 animate-spin rounded-full border-4 border-primary border-t-transparent"></div>
    </div>
  );

  if (!user) {
    console.warn('ProtectedRoute: No user found, redirecting to login');
    return <Navigate to="/login" />;
  }

  if (roles && !roles.some(role => user.roles.includes(role))) {
    console.warn('ProtectedRoute: User does not have required roles:', roles);
    return <Navigate to="/" />;
  }

  return children;
};

function App() {
  return (
    <AuthProvider>
      <Router>
        <div className="min-h-screen bg-background text-foreground">
          <Navbar />
          <main className="container mx-auto px-4 py-8">
            <Routes>
              <Route path="/" element={<HomePage />} />
              <Route path="/products" element={<ProductListingPage />} />
              <Route path="/products/:id" element={<ProductDetailsPage />} />
              <Route path="/login" element={<LoginPage />} />
              <Route path="/register" element={<RegisterPage />} />
              <Route path="/forgot-password" element={<ForgotPasswordPage />} />
              <Route path="/reset-password" element={<ResetPasswordPage />} />

              <Route path="/cart" element={
                <ProtectedRoute>
                  <CartPage />
                </ProtectedRoute>
              } />

              <Route path="/checkout" element={
                <ProtectedRoute>
                  <CheckoutPage />
                </ProtectedRoute>
              } />

              <Route path="/orders" element={
                <ProtectedRoute>
                  <OrdersPage />
                </ProtectedRoute>
              } />

              <Route path="/wishlist" element={
                <ProtectedRoute>
                  <WishlistPage />
                </ProtectedRoute>
              } />

              <Route path="/profile" element={
                <ProtectedRoute>
                  <ProfilePage />
                </ProtectedRoute>
              } />

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
            </Routes>
          </main>
        </div>
      </Router>
    </AuthProvider>
  );
}

export default App;
