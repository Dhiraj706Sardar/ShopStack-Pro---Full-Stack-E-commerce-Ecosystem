package com.ecommerce.repository;

import com.ecommerce.entity.Review;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.UUID;

@Repository
public interface ReviewRepository extends JpaRepository<Review, UUID> {
    List<Review> findByProductId(UUID productId);

    @Modifying
    @Query("DELETE FROM Review r WHERE r.product.id = :productId")
    void deleteByProductId(UUID productId);
}
