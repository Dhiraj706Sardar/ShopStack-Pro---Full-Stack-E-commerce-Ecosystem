import React, { useState, useEffect } from 'react';
import api from '../api/axios';
import { User, Mail, Lock, Save, Shield, Camera } from 'lucide-react';

const ProfilePage = () => {
    const [profile, setProfile] = useState({ username: '', email: '', roles: [], profileImageUrl: '' });
    const [loading, setLoading] = useState(true);
    const [saving, setSaving] = useState(false);
    const [imageUploading, setImageUploading] = useState(false);
    const [message, setMessage] = useState({ type: '', text: '' });
    const [previewUrl, setPreviewUrl] = useState('');

    useEffect(() => {
        fetchProfile();
    }, []);

    const fetchProfile = async () => {
        try {
            const response = await api.get('/user/profile');
            setProfile(response.data);
            if (response.data.profileImageUrl) {
                setPreviewUrl(response.data.profileImageUrl);
            }
        } catch (error) {
            console.error('Error fetching profile:', error);
        } finally {
            setLoading(false);
        }
    };

    const handleImageChange = async (e) => {
        const file = e.target.files[0];
        if (!file) return;

        // Show local preview immediately
        const localUrl = URL.createObjectURL(file);
        setPreviewUrl(localUrl);
        setImageUploading(true);
        setMessage({ type: '', text: '' });

        try {
            const formData = new FormData();
            formData.append('image', file);

            const response = await api.put('/user/profile', formData);
            setProfile(response.data);
            setPreviewUrl(response.data.profileImageUrl);

            const storedUser = JSON.parse(localStorage.getItem('user') || '{}');
            localStorage.setItem('user', JSON.stringify({ ...storedUser, ...response.data }));

            setMessage({ type: 'success', text: 'Profile picture updated!' });
        } catch (error) {
            console.error('Error uploading image:', error);
            const errorMsg = error.response?.data?.message || 'Failed to upload image';
            setMessage({ type: 'error', text: errorMsg });
            // Revert preview on error
            setPreviewUrl(profile.profileImageUrl);
        } finally {
            setImageUploading(false);
        }
    };

    const handleUpdate = async (e) => {
        e.preventDefault();
        setSaving(true);
        setMessage({ type: '', text: '' });
        try {
            const formData = new FormData();
            formData.append('user', JSON.stringify({
                username: profile.username,
                email: profile.email
            }));

            const response = await api.put('/user/profile', formData);
            setProfile(response.data);
            setMessage({ type: 'success', text: 'Profile details updated!' });

            const storedUser = JSON.parse(localStorage.getItem('user') || '{}');
            localStorage.setItem('user', JSON.stringify({ ...storedUser, ...response.data }));
        } catch (error) {
            setMessage({ type: 'error', text: error.response?.data?.message || 'Failed to update profile' });
        } finally {
            setSaving(false);
        }
    };

    if (loading) return (
        <div className="flex h-96 items-center justify-center">
            <div className="h-12 w-12 animate-spin rounded-full border-4 border-primary border-t-transparent"></div>
        </div>
    );

    return (
        <div className="max-w-2xl mx-auto flex flex-col gap-8 pb-20">
            <div className="flex flex-col gap-2">
                <h1 className="text-3xl font-bold tracking-tight">My Profile</h1>
                <p className="text-muted-foreground">Manage your account settings and preferences.</p>
            </div>

            <div className="rounded-3xl border bg-card p-8 shadow-lg">
                <div className="space-y-8">
                    {message.text && (
                        <div className={`rounded-xl p-4 text-sm font-medium animate-in fade-in slide-in-from-top-2 ${message.type === 'success' ? 'bg-green-100 text-green-700' : 'bg-red-100 text-red-700'}`}>
                            {message.text}
                        </div>
                    )}

                    {/* Profile Image Section */}
                    <div className="flex flex-col items-center gap-4">
                        <div className="relative group">
                            <div className={`h-32 w-32 rounded-full overflow-hidden border-4 border-primary/10 bg-muted flex items-center justify-center transition-opacity ${imageUploading ? 'opacity-50' : ''}`}>
                                {previewUrl ? (
                                    <img src={previewUrl} alt="Profile" className="h-full w-full object-cover" />
                                ) : (
                                    <User className="h-16 w-16 text-muted-foreground" />
                                )}
                            </div>
                            {imageUploading && (
                                <div className="absolute inset-0 flex items-center justify-center">
                                    <div className="h-8 w-8 animate-spin rounded-full border-4 border-primary border-t-transparent"></div>
                                </div>
                            )}
                            <label className="absolute bottom-0 right-0 p-2 bg-primary text-white rounded-full cursor-pointer shadow-lg hover:scale-110 transition-transform disabled:opacity-50">
                                <Camera className="h-5 w-5" />
                                <input
                                    type="file"
                                    className="hidden"
                                    accept="image/*"
                                    onChange={handleImageChange}
                                    disabled={imageUploading}
                                />
                            </label>
                        </div>
                        <p className="text-xs text-muted-foreground font-medium">
                            {imageUploading ? 'Uploading...' : 'Click the camera icon to change photo'}
                        </p>
                    </div>

                    <form onSubmit={handleUpdate} className="space-y-8">
                        <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
                            <div className="space-y-2">
                                <label className="text-sm font-bold flex items-center gap-2">
                                    <User className="h-4 w-4" /> Username
                                </label>
                                <input
                                    type="text"
                                    required
                                    value={profile.username}
                                    onChange={(e) => setProfile({ ...profile, username: e.target.value })}
                                    className="w-full rounded-xl border bg-background p-4 text-sm focus:ring-2 focus:ring-primary/20 outline-none"
                                />
                            </div>

                            <div className="space-y-2">
                                <label className="text-sm font-bold flex items-center gap-2">
                                    <Mail className="h-4 w-4" /> Email Address
                                </label>
                                <input
                                    type="email"
                                    required
                                    value={profile.email}
                                    onChange={(e) => setProfile({ ...profile, email: e.target.value })}
                                    className="w-full rounded-xl border bg-background p-4 text-sm focus:ring-2 focus:ring-primary/20 outline-none"
                                />
                            </div>

                            <div className="space-y-2 md:col-span-2">
                                <label className="text-sm font-bold flex items-center gap-2">
                                    <Shield className="h-4 w-4" /> Account Roles
                                </label>
                                <div className="flex flex-wrap gap-2">
                                    {profile.roles.map((role) => (
                                        <span key={role} className="rounded-full bg-primary/10 px-3 py-1 text-[10px] font-bold text-primary uppercase">
                                            {role.replace('ROLE_', '')}
                                        </span>
                                    ))}
                                </div>
                            </div>
                        </div>

                        <button
                            type="submit"
                            disabled={saving}
                            className="w-full flex items-center justify-center gap-2 rounded-xl bg-primary py-4 text-lg font-bold text-primary-foreground transition-all hover:opacity-90 disabled:opacity-50"
                        >
                            {saving ? 'Saving...' : <><Save className="h-5 w-5" /> Save Changes</>}
                        </button>
                    </form>
                </div>
            </div>
        </div>
    );
};

export default ProfilePage;
