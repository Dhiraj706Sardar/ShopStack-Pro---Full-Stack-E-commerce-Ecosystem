import React, { createContext, useContext, useState, useEffect } from 'react';
import api from '../api/axios';

const AuthContext = createContext();

export const AuthProvider = ({ children }) => {
    const [user, setUser] = useState(null);
    const [loading, setLoading] = useState(true);

    useEffect(() => {
        const storedUser = localStorage.getItem('user');
        const storedToken = localStorage.getItem('token');
        console.log('Checking stored session:', { hasUser: !!storedUser, hasToken: !!storedToken });

        if (storedUser && storedToken) {
            try {
                const parsedUser = JSON.parse(storedUser);
                setUser(parsedUser);
                console.log('Session restored for:', parsedUser.email);
            } catch (error) {
                console.error('Failed to parse stored user:', error);
                localStorage.removeItem('user');
                localStorage.removeItem('token');
            }
        } else {
            console.log('No valid session found in localStorage');
            localStorage.removeItem('user');
            localStorage.removeItem('token');
        }
        setLoading(false);
    }, []);

    const login = async (email, password) => {
        console.log('Attempting login for:', email);
        const response = await api.post('/auth/signin', { email, password });
        console.log('Login response data keys:', Object.keys(response.data));
        console.log('Full response data:', response.data);
        const { accessToken, refreshToken, ...userData } = response.data;
        if (accessToken) {
            localStorage.setItem('token', accessToken);
            localStorage.setItem('user', JSON.stringify(userData));
            setUser(userData);
            console.log('Token and user saved to localStorage. Token length:', accessToken.length);
        } else {
            console.error('No Access Token found in response. Available keys:', Object.keys(response.data));
        }
        return userData;
    };

    const signup = async (username, email, password, role) => {
        const response = await api.post('/auth/signup', { username, email, password, role });
        console.log('Signup response:', response.data);

        // Auto-login after signup
        const { accessToken, refreshToken, ...userData } = response.data;
        if (accessToken) {
            localStorage.setItem('token', accessToken);
            localStorage.setItem('user', JSON.stringify(userData));
            setUser(userData);
        }

        return response.data;
    };

    const logout = () => {
        localStorage.removeItem('token');
        localStorage.removeItem('user');
        setUser(null);
    };

    const isAdmin = () => user?.roles?.includes('ROLE_ADMIN');
    const isSeller = () => user?.roles?.includes('ROLE_SELLER');

    return (
        <AuthContext.Provider value={{ user, loading, login, signup, logout, isAdmin, isSeller }}>
            {children}
        </AuthContext.Provider>
    );
};

export const useAuth = () => useContext(AuthContext);
