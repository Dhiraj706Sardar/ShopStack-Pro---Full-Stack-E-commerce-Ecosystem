package com.ecommerce.service;

import com.ecommerce.dto.ProductDTO;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.web.multipart.MultipartFile;
import java.util.UUID;

public interface ProductService {
    ProductDTO createProduct(ProductDTO productDTO, MultipartFile image);

    ProductDTO updateProduct(UUID id, ProductDTO productDTO, MultipartFile image);

    void deleteProduct(UUID id);

    ProductDTO getProductById(UUID id);

    Page<ProductDTO> getAllProducts(String name, UUID categoryId, Double minPrice, Double maxPrice, Boolean inStock,
            UUID sellerId, Pageable pageable);

    Page<ProductDTO> searchProducts(String name, Pageable pageable);

    Page<ProductDTO> getAllProductsBySeller(UUID sellerId, Pageable pageable);
}
