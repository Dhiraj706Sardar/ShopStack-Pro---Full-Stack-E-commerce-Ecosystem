package com.ecommerce.dto;

import lombok.Data;
import java.util.UUID;

@Data
public class OrderItemDTO {
    private UUID id;
    private UUID productId;
    private String productName;
    private Integer quantity;
    private Double price;
    private String sellerName;
}
