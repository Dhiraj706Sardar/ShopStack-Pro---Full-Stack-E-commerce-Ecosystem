package com.ecommerce.controller.seller;

import com.ecommerce.dto.OrderDTO;
import com.ecommerce.security.UserDetailsImpl;
import com.ecommerce.service.OrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.UUID;

@RestController
@RequestMapping("/api/seller/orders")
@PreAuthorize("hasRole('SELLER')")
public class SellerOrderController {

    @Autowired
    private OrderService orderService;

    @GetMapping
    public ResponseEntity<List<OrderDTO>> getMyOrders(Authentication authentication) {
        UserDetailsImpl userDetails = (UserDetailsImpl) authentication.getPrincipal();
        return ResponseEntity.ok(orderService.getOrdersForSeller(userDetails.getId()));
    }

    @GetMapping("/{id}")
    public ResponseEntity<OrderDTO> getOrderById(@PathVariable UUID id, Authentication authentication) {
        UserDetailsImpl userDetails = (UserDetailsImpl) authentication.getPrincipal();
        // We reuse getOrdersForSeller logic or check manually.
        // Since getOrdersForSeller returns a list, we can filter it or implement a
        // specific method.
        // For efficiency, let's fetch the order and verify it contains seller's items.
        // BUT, OrderService.getOrdersForSeller already filters items.
        // So a simpler way is to fetch all seller orders and find the one with this ID.
        // Or better, add getOrderForSeller(orderId, sellerId) to service.
        // For now, let's stick to the plan and iterate.

        List<OrderDTO> sellerOrders = orderService.getOrdersForSeller(userDetails.getId());
        return sellerOrders.stream()
                .filter(o -> o.getId().equals(id))
                .findFirst()
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.status(HttpStatus.FORBIDDEN).build());
    }
}
