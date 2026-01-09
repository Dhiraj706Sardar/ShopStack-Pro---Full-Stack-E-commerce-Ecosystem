package com.ecommerce.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ProductSalesDTO {
    private String productName;
    private Long totalQuantity;
    private Double totalRevenue;
}
