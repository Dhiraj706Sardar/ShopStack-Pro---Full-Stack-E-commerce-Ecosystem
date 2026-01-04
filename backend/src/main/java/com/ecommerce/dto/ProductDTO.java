package com.ecommerce.dto;

import lombok.Data;
import java.util.List;
import java.util.UUID;

@Data
public class ProductDTO {
    private UUID id;
    private String name;
    private String description;
    private Double price;
    private Integer stockQuantity;
    private String imageUrl;
    private UUID categoryId;
    private String categoryName;
    private UUID sellerId;
    private String sellerName;
    private List<ProductVariantDTO> variants;
}
