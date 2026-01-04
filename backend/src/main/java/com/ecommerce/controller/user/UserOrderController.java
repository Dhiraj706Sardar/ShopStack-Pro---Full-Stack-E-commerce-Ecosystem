package com.ecommerce.controller.user;

import com.ecommerce.dto.OrderDTO;
import com.ecommerce.security.UserDetailsImpl;
import com.ecommerce.service.OrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;
import org.springframework.core.io.InputStreamResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import com.ecommerce.service.PdfService;
import java.io.ByteArrayInputStream;

import java.util.List;
import java.util.UUID;

@RestController
@RequestMapping("/api/user/orders")
@PreAuthorize("hasRole('USER')")
public class UserOrderController {

    @Autowired
    private OrderService orderService;

    @Autowired
    private PdfService pdfService;

    @PostMapping
    public ResponseEntity<OrderDTO> createOrder(@RequestParam String shippingAddress, Authentication authentication) {
        UserDetailsImpl userDetails = (UserDetailsImpl) authentication.getPrincipal();
        return new ResponseEntity<>(orderService.createOrder(userDetails.getId(), shippingAddress), HttpStatus.CREATED);
    }

    @GetMapping
    public ResponseEntity<List<OrderDTO>> getMyOrders(Authentication authentication) {
        UserDetailsImpl userDetails = (UserDetailsImpl) authentication.getPrincipal();
        return ResponseEntity.ok(orderService.getOrdersByUserId(userDetails.getId()));
    }

    @GetMapping("/{id}")
    public ResponseEntity<OrderDTO> getOrderById(@PathVariable UUID id, Authentication authentication) {
        UserDetailsImpl userDetails = (UserDetailsImpl) authentication.getPrincipal();
        OrderDTO order = orderService.getOrderById(id);

        // Ensure the order belongs to the user
        if (!order.getUserId().equals(userDetails.getId())) {
            return ResponseEntity.status(HttpStatus.FORBIDDEN).build();
        }

        return ResponseEntity.ok(order);
    }

    @GetMapping("/{id}/invoice")
    public ResponseEntity<InputStreamResource> getInvoice(@PathVariable UUID id, Authentication authentication) {
        UserDetailsImpl userDetails = (UserDetailsImpl) authentication.getPrincipal();
        OrderDTO order = orderService.getOrderById(id);

        // Ensure the order belongs to the user
        if (!order.getUserId().equals(userDetails.getId())) {
            return ResponseEntity.status(HttpStatus.FORBIDDEN).build();
        }

        ByteArrayInputStream bis = pdfService.generateInvoice(order);

        HttpHeaders headers = new HttpHeaders();
        headers.add("Content-Disposition", "inline; filename=invoice_" + id + ".pdf");

        return ResponseEntity
                .ok()
                .headers(headers)
                .contentType(MediaType.APPLICATION_PDF)
                .body(new InputStreamResource(bis));
    }

    @PutMapping("/{id}/confirm-payment")
    public ResponseEntity<OrderDTO> confirmPayment(@PathVariable UUID id, Authentication authentication) {
        UserDetailsImpl userDetails = (UserDetailsImpl) authentication.getPrincipal();
        OrderDTO order = orderService.getOrderById(id);

        // Ensure the order belongs to the user
        if (!order.getUserId().equals(userDetails.getId())) {
            return ResponseEntity.status(HttpStatus.FORBIDDEN).build();
        }

        return ResponseEntity.ok(orderService.updateOrderStatus(id, com.ecommerce.entity.OrderStatus.PAID));
    }
}
