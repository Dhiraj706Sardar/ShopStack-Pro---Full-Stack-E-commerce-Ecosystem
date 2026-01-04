package com.ecommerce.repository;

import com.ecommerce.entity.Product;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.stereotype.Repository;

import java.util.UUID;

@Repository
public interface ProductRepository extends JpaRepository<Product, UUID>, JpaSpecificationExecutor<Product> {
    Page<Product> findByNameContainingIgnoreCase(String name, Pageable pageable);

    Page<Product> findByCategoryId(UUID categoryId, Pageable pageable);

    Page<Product> findByPriceBetween(Double minPrice, Double maxPrice, Pageable pageable);

    Page<Product> findByNameContainingIgnoreCaseAndCategoryId(String name, UUID categoryId, Pageable pageable);

    @org.springframework.data.jpa.repository.Query("SELECT p FROM Product p WHERE p.seller.id = :sellerId")
    Page<Product> findBySellerId(@org.springframework.data.repository.query.Param("sellerId") UUID sellerId,
            Pageable pageable);
}
