package com.ecommerce.repository;

import com.ecommerce.entity.OrderItem;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.UUID;

@Repository
public interface OrderItemRepository extends JpaRepository<OrderItem, UUID> {

    @Query("SELECT i.product.name, SUM(i.quantity), SUM(i.price * i.quantity) " +
            "FROM OrderItem i " +
            "WHERE i.product IS NOT NULL " +
            "GROUP BY i.product.id, i.product.name " +
            "ORDER BY SUM(i.quantity) DESC")
    List<Object[]> findTopSellingProducts(Pageable pageable);

    @Modifying
    @Query("UPDATE OrderItem i SET i.product = null WHERE i.product.id = :productId")
    void setProductToNull(@Param("productId") UUID productId);
}
