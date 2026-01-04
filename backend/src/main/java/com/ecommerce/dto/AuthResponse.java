package com.ecommerce.dto;

import java.util.List;
import java.util.UUID;

import lombok.Data;

@Data
public class AuthResponse {
    private String jwt;
    private String tokenType;
    private String message;
    private UUID id;
    private String username;
    private String email;
    private List<String> roles;

    public AuthResponse(String jwt, String tokenType, String message, UUID id, String username, String email,
            List<String> roles) {
        this.jwt = jwt;
        this.tokenType = tokenType;
        this.message = message;
        this.id = id;
        this.username = username;
        this.email = email;
        this.roles = roles;
    }
}
