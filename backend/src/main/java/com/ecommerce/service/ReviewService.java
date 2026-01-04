package com.ecommerce.service;

import com.ecommerce.dto.ReviewDTO;
import java.util.List;
import java.util.UUID;

public interface ReviewService {
    ReviewDTO addReview(UUID userId, UUID productId, ReviewDTO reviewDTO);

    List<ReviewDTO> getReviewsByProductId(UUID productId);

    void deleteReview(UUID reviewId, UUID userId);
}
