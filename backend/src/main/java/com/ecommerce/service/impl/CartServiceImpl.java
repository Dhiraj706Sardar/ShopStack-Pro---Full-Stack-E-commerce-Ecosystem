package com.ecommerce.service.impl;

import com.ecommerce.dto.CartDTO;
import com.ecommerce.dto.CartItemDTO;
import com.ecommerce.entity.Cart;
import com.ecommerce.entity.CartItem;
import com.ecommerce.entity.Product;
import com.ecommerce.entity.User;
import com.ecommerce.repository.CartRepository;
import com.ecommerce.repository.ProductRepository;
import com.ecommerce.repository.UserRepository;
import com.ecommerce.service.CartService;
import com.ecommerce.exception.ResourceNotFoundException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Objects;
import java.util.Optional;
import java.util.UUID;
import java.util.stream.Collectors;

@Service
public class CartServiceImpl implements CartService {

    @Autowired
    private CartRepository cartRepository;

    @Autowired
    private ProductRepository productRepository;

    @Autowired
    private UserRepository userRepository;

    @Override
    public CartDTO getCartByUserId(UUID userId) {
        Cart cart = cartRepository.findByUserId(Objects.requireNonNull(userId))
                .orElseGet(() -> {
                    User user = userRepository.findById(Objects.requireNonNull(userId))
                            .orElseThrow(() -> new ResourceNotFoundException("User not found"));
                    Cart newCart = new Cart();
                    newCart.setUser(user);
                    return cartRepository.save(newCart);
                });
        return mapToDTO(cart);
    }

    @Override
    @Transactional
    public CartDTO addItemToCart(UUID userId, UUID productId, Integer quantity) {
        Cart cart = getOrCreateCart(userId);
        Product product = productRepository.findById(java.util.Objects.requireNonNull(productId))
                .orElseThrow(() -> new ResourceNotFoundException("Product not found"));

        Optional<CartItem> existingItem = cart.getItems().stream()
                .filter(item -> item.getProduct().getId().equals(productId))
                .findFirst();

        if (existingItem.isPresent()) {
            int newQuantity = existingItem.get().getQuantity() + quantity;
            if (newQuantity > product.getStockQuantity()) {
                throw new com.ecommerce.exception.APIException(
                        "Insufficient stock. Available: " + product.getStockQuantity());
            }
            existingItem.get().setQuantity(newQuantity);
        } else {
            if (quantity > product.getStockQuantity()) {
                throw new com.ecommerce.exception.APIException(
                        "Insufficient stock. Available: " + product.getStockQuantity());
            }
            CartItem newItem = new CartItem();
            newItem.setCart(cart);
            newItem.setProduct(product);
            newItem.setQuantity(quantity);
            newItem.setPrice(product.getPrice());
            cart.getItems().add(newItem);
        }

        updateTotalPrice(cart);
        return mapToDTO(cartRepository.save(cart));
    }

    @Override
    @Transactional
    public CartDTO removeItemFromCart(UUID userId, UUID productId) {
        Cart cart = getOrCreateCart(userId);
        cart.getItems().removeIf(item -> item.getProduct().getId().equals(java.util.Objects.requireNonNull(productId)));
        updateTotalPrice(cart);
        return mapToDTO(cartRepository.save(cart));
    }

    @Override
    @Transactional
    public CartDTO updateItemQuantity(UUID userId, UUID productId, Integer quantity) {
        Cart cart = cartRepository.findByUserId(Objects.requireNonNull(userId))
                .orElseThrow(() -> new ResourceNotFoundException("Cart not found"));

        Product product = productRepository.findById(Objects.requireNonNull(productId))
                .orElseThrow(() -> new ResourceNotFoundException("Product not found"));

        Optional<CartItem> existingItem = cart.getItems().stream()
                .filter(item -> item.getProduct().getId().equals(productId))
                .findFirst();

        existingItem
                .ifPresent(item -> {
                    if (quantity > product.getStockQuantity()) { // Use product.getStockQuantity() for current stock
                                                                 // check
                        throw new com.ecommerce.exception.APIException(
                                "Insufficient stock. Available: " + product.getStockQuantity());
                    }
                    item.setQuantity(quantity);
                });

        updateTotalPrice(cart);
        return mapToDTO(cartRepository.save(cart));
    }

    @Override
    @Transactional
    public void clearCart(UUID userId) {
        Cart cart = getOrCreateCart(userId);
        cart.getItems().clear();
        cart.setTotalPrice(0.0);
        cartRepository.save(cart);
    }

    private Cart getOrCreateCart(UUID userId) {
        return cartRepository.findByUserId(Objects.requireNonNull(userId)).orElseGet(() -> {
            Cart newCart = new Cart();
            User user = userRepository.findById(Objects.requireNonNull(userId))
                    .orElseThrow(() -> new ResourceNotFoundException("User not found"));
            newCart.setUser(user);
            return cartRepository.save(newCart);
        });
    }

    private void updateTotalPrice(Cart cart) {
        double total = cart.getItems().stream()
                .mapToDouble(item -> item.getPrice() * item.getQuantity())
                .sum();
        cart.setTotalPrice(total);
    }

    private CartDTO mapToDTO(Cart cart) {
        CartDTO dto = new CartDTO();
        dto.setId(cart.getId());
        dto.setUserId(cart.getUser().getId());
        dto.setTotalPrice(cart.getTotalPrice());
        dto.setItems(cart.getItems().stream().map(item -> {
            CartItemDTO itemDTO = new CartItemDTO();
            itemDTO.setId(item.getId());
            itemDTO.setProductId(item.getProduct().getId());
            itemDTO.setProductName(item.getProduct().getName());
            itemDTO.setProductImageUrl(item.getProduct().getImageUrl());
            itemDTO.setQuantity(item.getQuantity());
            itemDTO.setPrice(item.getPrice());
            return itemDTO;
        }).collect(Collectors.toList()));
        return dto;
    }
}
