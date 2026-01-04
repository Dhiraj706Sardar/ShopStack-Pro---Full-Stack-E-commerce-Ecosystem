package com.ecommerce.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.UUID;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ProductVariantDTO {
    private UUID id;
    private String name;
    private String value;
    private Double price;
    private Integer stockQuantity;
    private String sku;
}
