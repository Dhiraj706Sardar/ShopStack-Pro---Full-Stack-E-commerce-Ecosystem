package com.ecommerce.service.impl;

import com.ecommerce.dto.ReviewDTO;
import com.ecommerce.entity.Product;
import com.ecommerce.entity.Review;
import com.ecommerce.entity.User;
import com.ecommerce.repository.OrderRepository;
import com.ecommerce.repository.ProductRepository;
import com.ecommerce.repository.ReviewRepository;
import com.ecommerce.repository.UserRepository;
import com.ecommerce.exception.APIException;
import com.ecommerce.exception.ResourceNotFoundException;
import com.ecommerce.service.ReviewService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

@Service
public class ReviewServiceImpl implements ReviewService {

    @Autowired
    private ReviewRepository reviewRepository;

    @Autowired
    private ProductRepository productRepository;

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private OrderRepository orderRepository;

    @Override
    public ReviewDTO addReview(UUID userId, UUID productId, ReviewDTO reviewDTO) {
        User user = userRepository.findById(java.util.Objects.requireNonNull(userId))
                .orElseThrow(() -> new ResourceNotFoundException("User not found"));
        Product product = productRepository.findById(java.util.Objects.requireNonNull(productId))
                .orElseThrow(() -> new ResourceNotFoundException("Product not found"));

        // Check if user has purchased the product
        List<com.ecommerce.entity.Order> userOrders = orderRepository
                .findByUserId(java.util.Objects.requireNonNull(userId));
        boolean hasPurchased = userOrders.stream()
                .anyMatch(order -> order.getItems().stream()
                        .anyMatch(item -> item.getProduct().getId().equals(productId)));

        if (!hasPurchased) {
            throw new APIException("You can only review products you have purchased");
        }

        Review review = new Review();
        review.setUser(user);
        review.setProduct(product);
        review.setComment(reviewDTO.getComment());
        review.setRating(reviewDTO.getRating());

        return mapToDTO(reviewRepository.save(review));
    }

    @Override
    public List<ReviewDTO> getReviewsByProductId(UUID productId) {
        return reviewRepository.findByProductId(java.util.Objects.requireNonNull(productId)).stream()
                .map(this::mapToDTO)
                .collect(Collectors.toList());
    }

    @Override
    public void deleteReview(UUID reviewId, UUID userId) {
        Review review = reviewRepository.findById(java.util.Objects.requireNonNull(reviewId))
                .orElseThrow(() -> new ResourceNotFoundException("Review not found"));

        if (!review.getUser().getId().equals(userId)) {
            throw new APIException("Unauthorized to delete this review");
        }

        reviewRepository.delete(review);
    }

    private ReviewDTO mapToDTO(Review review) {
        ReviewDTO dto = new ReviewDTO();
        dto.setId(review.getId());
        dto.setComment(review.getComment());
        dto.setRating(review.getRating());
        dto.setUserId(review.getUser().getId());
        dto.setUsername(review.getUser().getUsername());
        dto.setProductId(review.getProduct().getId());
        dto.setCreatedAt(review.getCreatedAt());
        return dto;
    }
}
