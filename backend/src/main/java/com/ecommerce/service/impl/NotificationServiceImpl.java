package com.ecommerce.service.impl;

import com.ecommerce.dto.NotificationDTO;
import com.ecommerce.service.NotificationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Service;

@Service
public class NotificationServiceImpl implements NotificationService {

    @Autowired
    private SimpMessagingTemplate messagingTemplate;

    @Override
    public void sendNotification(String username, NotificationDTO notification) {
        messagingTemplate.convertAndSendToUser(username, "/queue/notifications", notification);
    }
}
