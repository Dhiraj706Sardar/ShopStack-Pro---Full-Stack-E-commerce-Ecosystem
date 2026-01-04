package com.ecommerce.dto;

import lombok.Data;

@Data
public class ResestPasswordRequest {
    String token;
    String newPassword;
}
