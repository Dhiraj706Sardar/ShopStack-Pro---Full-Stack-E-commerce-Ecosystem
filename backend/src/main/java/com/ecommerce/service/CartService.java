package com.ecommerce.service;

import com.ecommerce.dto.CartDTO;
import java.util.UUID;

public interface CartService {
    CartDTO getCartByUserId(UUID userId);

    CartDTO addItemToCart(UUID userId, UUID productId, Integer quantity);

    CartDTO removeItemFromCart(UUID userId, UUID productId);

    CartDTO updateItemQuantity(UUID userId, UUID productId, Integer quantity);

    void clearCart(UUID userId);
}
