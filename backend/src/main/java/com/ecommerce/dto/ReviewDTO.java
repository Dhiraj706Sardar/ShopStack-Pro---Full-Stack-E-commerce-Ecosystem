package com.ecommerce.dto;

import lombok.Data;
import java.time.LocalDateTime;
import java.util.UUID;

@Data
public class ReviewDTO {
    private UUID id;
    private String comment;
    private Integer rating;
    private UUID userId;
    private String username;
    private UUID productId;
    private LocalDateTime createdAt;
}
