package com.ecommerce.controller.admin;

import com.ecommerce.dto.ProductDTO;
import com.ecommerce.service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.UUID;

@RestController
@RequestMapping("/api/admin/products")
@PreAuthorize("hasRole('ADMIN')")
public class AdminProductController {

    @Autowired
    private ProductService productService;

    @GetMapping
    public ResponseEntity<Page<ProductDTO>> getAllProducts(
            @RequestParam(required = false) String name,
            @RequestParam(required = false) UUID categoryId,
            @RequestParam(required = false) Double minPrice,
            @RequestParam(required = false) Double maxPrice,
            @RequestParam(required = false) Boolean inStock,
            @RequestParam(required = false) UUID sellerId,
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "10") int size) {

        Pageable pageable = PageRequest.of(page, size);
        Page<ProductDTO> products = productService.getAllProducts(name, categoryId, minPrice, maxPrice, inStock,
                sellerId, pageable);
        return ResponseEntity.ok(products);
    }

    @PostMapping(consumes = { "multipart/form-data" })
    public ResponseEntity<ProductDTO> createProduct(
            @RequestParam("product") String productJson,
            @RequestParam("image") MultipartFile image) throws com.fasterxml.jackson.core.JsonProcessingException {
        com.fasterxml.jackson.databind.ObjectMapper objectMapper = new com.fasterxml.jackson.databind.ObjectMapper();
        ProductDTO productDTO = objectMapper.readValue(productJson, ProductDTO.class);
        return new ResponseEntity<>(productService.createProduct(productDTO, image), HttpStatus.CREATED);
    }

    @PutMapping(value = "/{id}", consumes = { "multipart/form-data" })
    public ResponseEntity<ProductDTO> updateProduct(
            @PathVariable UUID id,
            @RequestParam("product") String productJson,
            @RequestParam(value = "image", required = false) MultipartFile image)
            throws com.fasterxml.jackson.core.JsonProcessingException {
        com.fasterxml.jackson.databind.ObjectMapper objectMapper = new com.fasterxml.jackson.databind.ObjectMapper();
        ProductDTO productDTO = objectMapper.readValue(productJson, ProductDTO.class);
        return ResponseEntity.ok(productService.updateProduct(id, productDTO, image));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteProduct(@PathVariable UUID id) {
        productService.deleteProduct(id);
        return ResponseEntity.noContent().build();
    }
}
