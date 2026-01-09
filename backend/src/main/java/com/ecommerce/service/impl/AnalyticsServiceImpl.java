package com.ecommerce.service.impl;

import com.ecommerce.dto.AnalyticsDTO;
import com.ecommerce.dto.ProductSalesDTO;
import com.ecommerce.repository.OrderItemRepository;
import com.ecommerce.repository.OrderRepository;
import com.ecommerce.repository.UserRepository;
import com.ecommerce.service.AnalyticsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Service
public class AnalyticsServiceImpl implements AnalyticsService {

    @Autowired
    private OrderRepository orderRepository;

    @Autowired
    private OrderItemRepository orderItemRepository;

    @Autowired
    private UserRepository userRepository;

    @Override
    public AnalyticsDTO getDashboardStats() {
        Double totalRevenue = orderRepository.calculateTotalRevenue();
        if (totalRevenue == null)
            totalRevenue = 0.0;

        Long totalOrders = orderRepository.count();
        Long totalUsers = userRepository.count();

        List<Object[]> topProductsData = orderItemRepository.findTopSellingProducts(PageRequest.of(0, 5));
        List<ProductSalesDTO> topProducts = topProductsData.stream()
                .map(data -> new ProductSalesDTO(
                        (String) data[0],
                        (Long) data[1],
                        (Double) data[2]))
                .collect(Collectors.toList());

        List<Object[]> revenueByMonthData = orderRepository.getRevenueByMonth();
        Map<String, Double> revenueByMonth = revenueByMonthData.stream()
                .collect(Collectors.toMap(
                        data -> (String) data[0],
                        data -> (Double) data[1]));

        return new AnalyticsDTO(totalRevenue, totalOrders, totalUsers, topProducts, revenueByMonth);
    }
}
