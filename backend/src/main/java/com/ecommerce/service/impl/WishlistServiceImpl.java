package com.ecommerce.service.impl;

import com.ecommerce.dto.ProductDTO;
import com.ecommerce.entity.Product;
import com.ecommerce.entity.User;
import com.ecommerce.entity.Wishlist;
import com.ecommerce.repository.ProductRepository;
import com.ecommerce.repository.UserRepository;
import com.ecommerce.repository.WishlistRepository;
import com.ecommerce.service.WishlistService;
import com.ecommerce.exception.ResourceNotFoundException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

@Service
public class WishlistServiceImpl implements WishlistService {

        @Autowired
        private WishlistRepository wishlistRepository;

        @Autowired
        private ProductRepository productRepository;

        @Autowired
        private UserRepository userRepository;

        @Override
        @Transactional
        public void addToWishlist(UUID userId, UUID productId) {
                User user = userRepository.findById(java.util.Objects.requireNonNull(userId))
                                .orElseThrow(() -> new ResourceNotFoundException("User not found"));
                Product product = productRepository.findById(java.util.Objects.requireNonNull(productId))
                                .orElseThrow(() -> new ResourceNotFoundException("Product not found"));

                Wishlist wishlist = wishlistRepository.findByUserId(java.util.Objects.requireNonNull(userId))
                                .orElseGet(() -> {
                                        Wishlist newWishlist = new Wishlist();
                                        newWishlist.setUser(user);
                                        return wishlistRepository.save(newWishlist);
                                });

                wishlist.getProducts().add(product);
                wishlistRepository.save(wishlist);
        }

        @Override
        @Transactional
        public void removeFromWishlist(UUID userId, UUID productId) {
                Wishlist wishlist = wishlistRepository.findByUserId(java.util.Objects.requireNonNull(userId))
                                .orElseThrow(() -> new ResourceNotFoundException("Wishlist not found"));

                Product product = productRepository.findById(java.util.Objects.requireNonNull(productId))
                                .orElseThrow(() -> new ResourceNotFoundException("Product not found"));

                wishlist.getProducts().remove(product);
                wishlistRepository.save(wishlist);
        }

        @Override
        public List<ProductDTO> getWishlist(UUID userId) {
                Wishlist wishlist = wishlistRepository.findByUserId(java.util.Objects.requireNonNull(userId))
                                .orElseGet(() -> new Wishlist());

                return wishlist.getProducts().stream()
                                .map(this::mapToDTO)
                                .collect(Collectors.toList());
        }

        @Override
        public boolean isInWishlist(UUID userId, UUID productId) {
                Wishlist wishlist = wishlistRepository.findByUserId(java.util.Objects.requireNonNull(userId))
                                .orElse(null);
                if (wishlist == null)
                        return false;

                return wishlist.getProducts().stream()
                                .anyMatch(p -> p.getId().equals(productId));
        }

        private ProductDTO mapToDTO(Product product) {
                ProductDTO dto = new ProductDTO();
                dto.setId(product.getId());
                dto.setName(product.getName());
                dto.setDescription(product.getDescription());
                dto.setPrice(product.getPrice());
                dto.setStockQuantity(product.getStockQuantity());
                dto.setImageUrl(product.getImageUrl());
                dto.setCategoryId(product.getCategory().getId());
                dto.setCategoryName(product.getCategory().getName());
                dto.setSellerId(product.getSeller().getId());
                dto.setSellerName(product.getSeller().getUsername());
                return dto;
        }
}
