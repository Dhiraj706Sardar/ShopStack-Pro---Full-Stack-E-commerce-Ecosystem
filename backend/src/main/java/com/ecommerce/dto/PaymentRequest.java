package com.ecommerce.dto;

import lombok.Data;
import java.util.UUID;

@Data
public class PaymentRequest {
    private Long amount; // in cents
    private String currency;
    private UUID orderId;
}
