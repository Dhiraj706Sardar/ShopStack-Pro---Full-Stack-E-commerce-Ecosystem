package com.ecommerce.service;

import com.ecommerce.dto.ProductDTO;
import java.util.List;
import java.util.UUID;

public interface WishlistService {
    void addToWishlist(UUID userId, UUID productId);

    void removeFromWishlist(UUID userId, UUID productId);

    List<ProductDTO> getWishlist(UUID userId);

    boolean isInWishlist(UUID userId, UUID productId);
}
