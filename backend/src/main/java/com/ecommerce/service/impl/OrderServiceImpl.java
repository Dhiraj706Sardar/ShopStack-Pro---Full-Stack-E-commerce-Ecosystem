package com.ecommerce.service.impl;

import com.ecommerce.dto.OrderDTO;
import com.ecommerce.dto.OrderItemDTO;
import com.ecommerce.entity.*;
import com.ecommerce.repository.CartRepository;
import com.ecommerce.repository.OrderRepository;
import com.ecommerce.repository.ProductRepository;
import com.ecommerce.service.OrderService;
import com.ecommerce.service.EmailService;
import com.ecommerce.exception.APIException;
import com.ecommerce.exception.ResourceNotFoundException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;
import com.ecommerce.dto.NotificationDTO;

@Service
public class OrderServiceImpl implements OrderService {

    @Autowired
    private OrderRepository orderRepository;

    @Autowired
    private CartRepository cartRepository;

    @Autowired
    private ProductRepository productRepository;

    @Autowired
    private com.ecommerce.service.NotificationService notificationService;

    @Autowired
    private EmailService emailService;

    @Override
    @Transactional
    public OrderDTO createOrder(UUID userId, String shippingAddress) {
        Cart cart = cartRepository.findByUserId(java.util.Objects.requireNonNull(userId))
                .orElseThrow(() -> new ResourceNotFoundException("Cart not found"));

        if (cart.getItems().isEmpty()) {
            throw new APIException("Cart is empty");
        }

        Order order = new Order();
        order.setUser(cart.getUser());
        order.setShippingAddress(shippingAddress);
        order.setTotalAmount(cart.getTotalPrice());
        order.setStatus(OrderStatus.PENDING);

        List<OrderItem> orderItems = cart.getItems().stream().map(cartItem -> {
            Product product = cartItem.getProduct();
            if (cartItem.getQuantity() > product.getStockQuantity()) {
                throw new APIException("Insufficient stock for product: " + product.getName());
            }

            // Decrement stock
            product.setStockQuantity(product.getStockQuantity() - cartItem.getQuantity());
            productRepository.save(product);

            OrderItem orderItem = new OrderItem();
            orderItem.setOrder(order);
            orderItem.setProduct(product);
            orderItem.setQuantity(cartItem.getQuantity());
            orderItem.setPrice(cartItem.getPrice());
            return orderItem;
        }).collect(Collectors.toList());

        order.setItems(orderItems);

        // Clear cart after order
        cart.getItems().clear();
        cart.setTotalPrice(0.0);
        cartRepository.save(cart);

        Order savedOrder = orderRepository.save(order);
        OrderDTO orderDTO = mapToDTO(savedOrder);

        // Send email confirmation (wrapped in try-catch to prevent order failure)
        try {
            emailService.sendOrderConfirmationEmail(orderDTO);
        } catch (Exception e) {
            // Log the error but don't fail the order
            System.err.println("Failed to send order confirmation email: " + e.getMessage());
        }

        return orderDTO;
    }

    @Override
    public OrderDTO getOrderById(UUID orderId) {
        Order order = orderRepository.findById(java.util.Objects.requireNonNull(orderId))
                .orElseThrow(() -> new ResourceNotFoundException("Order not found"));
        return mapToDTO(order);
    }

    @Override
    public List<OrderDTO> getOrdersByUserId(UUID userId) {
        return orderRepository.findByUserId(java.util.Objects.requireNonNull(userId)).stream()
                .map(this::mapToDTO)
                .collect(Collectors.toList());
    }

    @Override
    public List<OrderDTO> getAllOrders() {
        return orderRepository.findAll().stream()
                .map(this::mapToDTO)
                .collect(Collectors.toList());
    }

    @Override
    @Transactional
    public OrderDTO updateOrderStatus(UUID orderId, OrderStatus status) {
        Order order = orderRepository.findById(java.util.Objects.requireNonNull(orderId))
                .orElseThrow(() -> new ResourceNotFoundException("Order not found"));
        order.setStatus(status);
        Order updatedOrder = orderRepository.save(order);

        // Send real-time notification
        NotificationDTO notification = new NotificationDTO(
                "Your order status has been updated to: " + status,
                "ORDER_UPDATE",
                LocalDateTime.now(),
                orderId);
        notificationService.sendNotification(order.getUser().getUsername(), notification);

        OrderDTO updatedOrderDTO = mapToDTO(updatedOrder);

        // Send email if status is PAID (wrapped in try-catch)
        if (status == OrderStatus.PAID) {
            try {
                emailService.sendOrderConfirmationEmail(updatedOrderDTO);
            } catch (Exception e) {
                System.err.println("Failed to send order status update email: " + e.getMessage());
            }
        }

        return updatedOrderDTO;
    }

    @Override
    public List<OrderDTO> getOrdersForSeller(UUID sellerId) {
        List<Order> orders = orderRepository.findOrdersBySellerId(sellerId);
        return orders.stream().map(order -> {
            OrderDTO dto = mapToDTO(order);
            // Correct approach: Filter the entity's items based on seller ID and map ONLY
            // those.
            List<OrderItemDTO> filteredItems = order.getItems().stream()
                    .filter(item -> item.getProduct() != null
                            && item.getProduct().getSeller() != null
                            && item.getProduct().getSeller().getId().equals(sellerId))
                    .map(item -> {
                        OrderItemDTO itemDTO = new OrderItemDTO();
                        itemDTO.setId(item.getId());
                        itemDTO.setProductId(item.getProduct().getId());
                        itemDTO.setProductName(item.getProduct().getName());
                        if (item.getProduct().getSeller() != null) {
                            itemDTO.setSellerName(item.getProduct().getSeller().getUsername());
                        }
                        itemDTO.setQuantity(item.getQuantity());
                        itemDTO.setPrice(item.getPrice());
                        return itemDTO;
                    })
                    .collect(Collectors.toList());

            dto.setItems(filteredItems);
            return dto;
        }).collect(Collectors.toList());
    }

    private OrderDTO mapToDTO(Order order) {
        OrderDTO dto = new OrderDTO();
        dto.setId(order.getId());
        dto.setUserId(order.getUser().getId());
        dto.setUserName(order.getUser().getUsername());
        dto.setUserEmail(order.getUser().getEmail());
        dto.setTotalAmount(order.getTotalAmount());
        dto.setStatus(order.getStatus());
        dto.setShippingAddress(order.getShippingAddress());
        dto.setOrderDate(order.getOrderDate());
        dto.setItems(order.getItems().stream().map(item -> {
            OrderItemDTO itemDTO = new OrderItemDTO();
            itemDTO.setId(item.getId());
            if (item.getProduct() != null) {
                itemDTO.setProductId(item.getProduct().getId());
                itemDTO.setProductName(item.getProduct().getName());
                if (item.getProduct().getSeller() != null) {
                    itemDTO.setSellerName(item.getProduct().getSeller().getUsername());
                }
            } else {
                itemDTO.setProductName("Deleted Product");
            }
            itemDTO.setQuantity(item.getQuantity());
            itemDTO.setPrice(item.getPrice());
            return itemDTO;
        }).collect(Collectors.toList()));
        return dto;
    }
}
