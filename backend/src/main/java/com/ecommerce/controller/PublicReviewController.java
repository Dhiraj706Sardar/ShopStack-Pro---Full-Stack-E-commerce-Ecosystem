package com.ecommerce.controller;

import com.ecommerce.dto.ReviewDTO;
import com.ecommerce.service.ReviewService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.UUID;

@RestController
@RequestMapping("/api/public/reviews")
public class PublicReviewController {

    @Autowired
    private ReviewService reviewService;

    @GetMapping("/product/{productId}")
    public ResponseEntity<List<ReviewDTO>> getReviewsByProduct(@PathVariable UUID productId) {
        return ResponseEntity.ok(reviewService.getReviewsByProductId(productId));
    }
}
