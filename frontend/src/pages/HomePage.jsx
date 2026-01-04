import React from 'react';
import { useAuth } from '../context/AuthContext';

import UserHomePage from './UserHomePage';

import { Navigate } from 'react-router-dom';

const HomePage = () => {
    const { user, loading } = useAuth();

    if (loading) {
        return (
            <div className="flex h-[80vh] items-center justify-center">
                <div className="h-12 w-12 animate-spin rounded-full border-4 border-primary border-t-transparent"></div>
            </div>
        );
    }

    if (!user) {
        return <UserHomePage />;
    }

    const roles = user.roles || [];

    if (roles.includes('ROLE_ADMIN')) {
        return <Navigate to="/admin" replace />;
    }

    if (roles.includes('ROLE_SELLER')) {
        return <Navigate to="/seller" replace />;
    }

    // Default for ROLE_USER or any other logged in user
    return <UserHomePage />;
};

export default HomePage;
