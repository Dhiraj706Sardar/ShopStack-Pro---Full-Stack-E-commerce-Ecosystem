package com.ecommerce.controller;

import com.ecommerce.dto.ProductDTO;
import com.ecommerce.service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import java.util.UUID;

@RestController
@RequestMapping("/api/public/products")
public class ProductController {

    @Autowired
    private ProductService productService;

    @GetMapping
    public ResponseEntity<Page<ProductDTO>> getAllProducts(
            @RequestParam(required = false) String name,
            @RequestParam(required = false) UUID categoryId,
            @RequestParam(required = false) Double minPrice,
            @RequestParam(required = false) Double maxPrice,
            @RequestParam(required = false) Boolean inStock,
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "10") int size) {

        Pageable pageable = PageRequest.of(page, size);
        Page<ProductDTO> products = productService.getAllProducts(name, categoryId, minPrice, maxPrice, inStock, null,
                pageable);
        return ResponseEntity.ok(products);
    }

    @GetMapping("/{id}")
    public ResponseEntity<ProductDTO> getProductById(@PathVariable UUID id) {
        return ResponseEntity.ok(productService.getProductById(id));
    }

    @GetMapping("/search")
    public ResponseEntity<Page<ProductDTO>> searchProducts(@RequestParam String name, Pageable pageable) {
        return ResponseEntity.ok(productService.searchProducts(name, pageable));
    }

    @GetMapping("/category/{categoryId}")
    public ResponseEntity<Page<ProductDTO>> getProductsByCategory(@PathVariable UUID categoryId, Pageable pageable) {
        return ResponseEntity.ok(productService.getAllProducts(null, categoryId, null, null, null, null, pageable));
    }
}
