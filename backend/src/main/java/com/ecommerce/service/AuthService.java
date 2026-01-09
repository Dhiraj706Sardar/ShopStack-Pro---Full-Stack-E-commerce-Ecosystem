package com.ecommerce.service;

import com.ecommerce.dto.AuthResponse;
import com.ecommerce.dto.LoginRequest;
import com.ecommerce.dto.SignupRequest;

public interface AuthService {
    AuthResponse authenticateUser(LoginRequest loginRequest);

    AuthResponse registerUser(SignupRequest signUpRequest);
}
