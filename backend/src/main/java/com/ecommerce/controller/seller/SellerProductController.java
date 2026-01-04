package com.ecommerce.controller.seller;

import com.ecommerce.dto.ProductDTO;
import com.ecommerce.security.UserDetailsImpl;
import com.ecommerce.service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.UUID;

@RestController
@RequestMapping("/api/seller/products")
@PreAuthorize("hasRole('SELLER')")
public class SellerProductController {

    @Autowired
    private ProductService productService;

    @GetMapping
    public ResponseEntity<java.util.List<ProductDTO>> getMyProducts() {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        UserDetailsImpl userDetails = (UserDetailsImpl) authentication.getPrincipal();
        org.springframework.data.domain.Page<ProductDTO> productPage = productService
                .getAllProductsBySeller(userDetails.getId(), org.springframework.data.domain.PageRequest.of(0, 100));
        return ResponseEntity.ok(productPage.getContent());
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
