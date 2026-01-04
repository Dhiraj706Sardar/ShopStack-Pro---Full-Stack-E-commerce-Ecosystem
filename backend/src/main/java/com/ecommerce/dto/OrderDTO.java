package com.ecommerce.dto;

import com.ecommerce.entity.OrderStatus;
import lombok.Data;
import java.time.LocalDateTime;
import java.util.List;
import java.util.UUID;

@Data
public class OrderDTO {
    private UUID id;
    private UUID userId;
    private String userName;
    private String userEmail;
    private List<OrderItemDTO> items;
    private Double totalAmount;
    private OrderStatus status;
    private String shippingAddress;
    private LocalDateTime orderDate;
}
