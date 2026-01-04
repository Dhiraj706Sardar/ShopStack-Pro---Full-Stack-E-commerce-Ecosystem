package com.ecommerce.service;

import com.ecommerce.dto.OrderDTO;

public interface EmailService {
    void sendOrderConfirmationEmail(OrderDTO order);

    void sendPasswordResetEmail(String to, String token);
}
