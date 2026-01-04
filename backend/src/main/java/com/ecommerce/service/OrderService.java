package com.ecommerce.service;

import com.ecommerce.dto.OrderDTO;
import com.ecommerce.entity.OrderStatus;
import java.util.List;
import java.util.UUID;

public interface OrderService {
    OrderDTO createOrder(UUID userId, String address);

    OrderDTO getOrderById(UUID orderId);

    List<OrderDTO> getOrdersByUserId(UUID userId);

    List<OrderDTO> getAllOrders();

    OrderDTO updateOrderStatus(UUID orderId, OrderStatus status);

    List<OrderDTO> getOrdersForSeller(UUID sellerId);
}
