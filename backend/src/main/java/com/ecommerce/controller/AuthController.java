package com.ecommerce.controller;

import com.ecommerce.dto.LoginRequest;
import com.ecommerce.dto.SignupRequest;
import com.ecommerce.service.AuthService;
import com.ecommerce.service.UserService;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import com.ecommerce.dto.MessageResponse;
import com.ecommerce.dto.AuthResponse;

import org.springframework.http.HttpStatus;

@CrossOrigin(origins = "http://localhost:3000", maxAge = 3600)
@RestController
@RequestMapping("/api/auth")
public class AuthController {

        @Autowired
        private AuthService authService;

        @Autowired
        private UserService userService;

        @PostMapping("/signin")
        public ResponseEntity<?> authenticateUser(@Valid @RequestBody LoginRequest loginRequest,
                        jakarta.servlet.http.HttpServletResponse response) {
                AuthResponse authResponse = authService.authenticateUser(loginRequest);

                // Set Refresh Token Cookie
                jakarta.servlet.http.Cookie cookie = new jakarta.servlet.http.Cookie("refresh_token",
                                authResponse.getRefreshToken());
                cookie.setHttpOnly(true);
                cookie.setSecure(false); // Set to true in production
                cookie.setPath("/");
                cookie.setMaxAge(7 * 24 * 60 * 60); // 7 days
                response.addCookie(cookie);

                return ResponseEntity.ok(authResponse);
        }

        @PostMapping("/signup")
        public ResponseEntity<?> registerUser(@Valid @RequestBody SignupRequest signUpRequest,
                        jakarta.servlet.http.HttpServletResponse response) {
                AuthResponse authResponse = authService.registerUser(signUpRequest);

                // Set Refresh Token Cookie
                jakarta.servlet.http.Cookie cookie = new jakarta.servlet.http.Cookie("refresh_token",
                                authResponse.getRefreshToken());
                cookie.setHttpOnly(true);
                cookie.setSecure(false); // Set to true in production
                cookie.setPath("/");
                cookie.setMaxAge(7 * 24 * 60 * 60); // 7 days
                response.addCookie(cookie);

                return new ResponseEntity<>(authResponse, HttpStatus.CREATED);
        }

        @PostMapping("/forgot-password")
        public ResponseEntity<?> forgotPassword(@RequestBody com.ecommerce.dto.ForgetPasswordRequest request) {
                String token = userService.initiatePasswordReset(request.getEmail());
                return ResponseEntity.ok(java.util.Map.of(
                                "message", "Password reset token generated successfully",
                                "token", token));
        }

        @PostMapping("/reset-password")
        public ResponseEntity<?> resetPassword(@RequestBody com.ecommerce.dto.ResestPasswordRequest request) {
                String result = userService.completePasswordReset(request.getToken(), request.getNewPassword());
                return ResponseEntity.ok(java.util.Map.of("message", result));
        }
}
