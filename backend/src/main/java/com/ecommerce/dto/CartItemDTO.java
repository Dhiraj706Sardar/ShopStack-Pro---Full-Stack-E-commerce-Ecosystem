package com.ecommerce.dto;

import lombok.Data;
import java.util.UUID;

@Data
public class CartItemDTO {
    private UUID id;
    private UUID productId;
    private String productName;
    private String productImageUrl;
    private Integer quantity;
    private Double price;
}
