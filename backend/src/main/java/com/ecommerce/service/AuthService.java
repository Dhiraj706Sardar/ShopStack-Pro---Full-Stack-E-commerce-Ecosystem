package com.ecommerce.service;

import com.ecommerce.dto.AuthResponse;
import com.ecommerce.dto.LoginRequest;
import com.ecommerce.dto.SignupRequest;

import com.ecommerce.dto.MessageResponse;

public interface AuthService {
    AuthResponse authenticateUser(LoginRequest loginRequest);

    MessageResponse registerUser(SignupRequest signUpRequest);
}
