package com.ecommerce.service;

import com.ecommerce.dto.NotificationDTO;

public interface NotificationService {
    void sendNotification(String username, NotificationDTO notification);
}
