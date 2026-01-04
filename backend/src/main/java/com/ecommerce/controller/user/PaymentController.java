package com.ecommerce.controller.user;

import com.ecommerce.dto.PaymentRequest;
import com.ecommerce.dto.PaymentResponse;
import com.ecommerce.service.PaymentService;
import com.stripe.exception.StripeException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/user/payments")
public class PaymentController {

    @Autowired
    private PaymentService paymentService;

    @PostMapping("/create-intent")
    public ResponseEntity<PaymentResponse> createPaymentIntent(@RequestBody PaymentRequest paymentRequest)
            throws StripeException {
        return ResponseEntity.ok(paymentService.createPaymentIntent(paymentRequest));
    }
}
