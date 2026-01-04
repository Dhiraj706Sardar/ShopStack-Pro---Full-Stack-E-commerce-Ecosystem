package com.ecommerce.repository;

import com.ecommerce.entity.Order;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.UUID;

@Repository
public interface OrderRepository extends JpaRepository<Order, UUID> {
    List<Order> findByUserId(UUID userId);

    @org.springframework.data.jpa.repository.Query("SELECT DISTINCT o FROM Order o JOIN o.items i WHERE i.product.seller.id = :sellerId")
    List<Order> findOrdersBySellerId(UUID sellerId);

    @org.springframework.data.jpa.repository.Query("SELECT SUM(o.totalAmount) FROM Order o WHERE o.status = 'PAID' OR o.status = 'DELIVERED'")
    Double calculateTotalRevenue();

    @org.springframework.data.jpa.repository.Query("SELECT FUNCTION('DATE_FORMAT', o.orderDate, '%Y-%m') as month, SUM(o.totalAmount) "
            +
            "FROM Order o " +
            "WHERE o.status = 'PAID' OR o.status = 'DELIVERED' " +
            "GROUP BY month " +
            "ORDER BY month DESC")
    List<Object[]> getRevenueByMonth();
}
