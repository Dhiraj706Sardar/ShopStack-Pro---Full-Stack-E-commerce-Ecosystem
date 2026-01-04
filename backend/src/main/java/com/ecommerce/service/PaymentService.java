package com.ecommerce.service;

import com.ecommerce.dto.PaymentRequest;
import com.ecommerce.dto.PaymentResponse;
import com.stripe.exception.StripeException;

public interface PaymentService {
    PaymentResponse createPaymentIntent(PaymentRequest paymentRequest) throws StripeException;
}
