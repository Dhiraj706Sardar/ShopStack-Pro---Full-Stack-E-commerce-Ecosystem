package com.ecommerce.controller.user;

import com.ecommerce.dto.ReviewDTO;
import com.ecommerce.security.UserDetailsImpl;
import com.ecommerce.service.ReviewService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

import java.util.UUID;

@RestController
@RequestMapping("/api/user/reviews")
@PreAuthorize("hasRole('USER')")
public class UserReviewController {

    @Autowired
    private ReviewService reviewService;

    @PostMapping("/{productId}")
    public ResponseEntity<ReviewDTO> addReview(
            @PathVariable UUID productId,
            @RequestBody ReviewDTO reviewDTO,
            Authentication authentication) {
        UserDetailsImpl userDetails = (UserDetailsImpl) authentication.getPrincipal();
        return new ResponseEntity<>(reviewService.addReview(userDetails.getId(), productId, reviewDTO),
                HttpStatus.CREATED);
    }

    @DeleteMapping("/{reviewId}")
    public ResponseEntity<Void> deleteReview(@PathVariable UUID reviewId, Authentication authentication) {
        UserDetailsImpl userDetails = (UserDetailsImpl) authentication.getPrincipal();
        reviewService.deleteReview(reviewId, userDetails.getId());
        return ResponseEntity.noContent().build();
    }
}
