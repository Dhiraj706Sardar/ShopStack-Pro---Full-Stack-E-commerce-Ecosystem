package com.ecommerce.controller;

import com.ecommerce.dto.AnalyticsDTO;
import com.ecommerce.service.AnalyticsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/public/analytics")
public class PublicAnalyticsController {

    @Autowired
    private AnalyticsService analyticsService;

    @GetMapping("/stats")
    public ResponseEntity<AnalyticsDTO> getPublicStats() {
        // For public stats, we can return the same DTO but maybe filter it if needed.
        // For now, let's provide the full stats to make the landing page look great.
        return ResponseEntity.ok(analyticsService.getDashboardStats());
    }
}
