package com.ecommerce.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import java.time.LocalDateTime;
import java.util.UUID;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class NotificationDTO {
    private String message;
    private String type;
    private LocalDateTime timestamp;
    private UUID orderId;
}
