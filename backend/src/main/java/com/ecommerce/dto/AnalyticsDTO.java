package com.ecommerce.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;
import java.util.Map;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class AnalyticsDTO {
    private Double totalRevenue;
    private Long totalOrders;
    private Long totalUsers;
    private List<ProductSalesDTO> topProducts;
    private Map<String, Double> revenueByMonth;

   
}
