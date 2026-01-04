package com.ecommerce.service;

import com.ecommerce.dto.CartDTO;
import com.ecommerce.entity.Cart;
import com.ecommerce.entity.CartItem;
import com.ecommerce.entity.Product;
import com.ecommerce.entity.User;
import com.ecommerce.exception.ResourceNotFoundException;
import com.ecommerce.repository.CartRepository;
import com.ecommerce.repository.ProductRepository;
import com.ecommerce.repository.UserRepository;
import com.ecommerce.service.impl.CartServiceImpl;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;

import java.util.ArrayList;
import java.util.Optional;
import java.util.UUID;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.*;

class CartServiceTest {

    @Mock
    private CartRepository cartRepository;

    @Mock
    private ProductRepository productRepository;

    @Mock
    private UserRepository userRepository;

    @InjectMocks
    private CartServiceImpl cartService;

    @BeforeEach
    void setUp() {
        MockitoAnnotations.openMocks(this);
    }

    @Test
    void testGetCartByUserId_ExistingCart() {
        UUID userId = UUID.randomUUID();
        User user = new User();
        user.setId(userId);
        Cart cart = new Cart();
        cart.setUser(user);
        cart.setItems(new ArrayList<>());

        when(cartRepository.findByUserId(userId)).thenReturn(Optional.of(cart));

        CartDTO result = cartService.getCartByUserId(userId);

        assertNotNull(result);
        assertEquals(userId, result.getUserId());
        verify(cartRepository, times(1)).findByUserId(userId);
    }

    @Test
    void testAddItemToCart_Success() {
        UUID userId = UUID.randomUUID();
        UUID productId = UUID.randomUUID();
        User user = new User();
        user.setId(userId);
        Cart cart = new Cart();
        cart.setUser(user);
        cart.setItems(new ArrayList<>());

        Product product = new Product();
        product.setId(productId);
        product.setPrice(100.0);
        product.setStockQuantity(10);

        when(cartRepository.findByUserId(userId)).thenReturn(Optional.of(cart));
        when(productRepository.findById(productId)).thenReturn(Optional.of(product));
        when(cartRepository.save(any(Cart.class))).thenReturn(cart);

        CartDTO result = cartService.addItemToCart(userId, productId, 2);

        assertNotNull(result);
        assertEquals(200.0, cart.getTotalPrice());
        assertEquals(1, cart.getItems().size());
        verify(cartRepository, times(1)).save(cart);
    }

    @Test
    void testAddItemToCart_InsufficientStock() {
        UUID userId = UUID.randomUUID();
        UUID productId = UUID.randomUUID();
        Cart cart = new Cart();
        cart.setItems(new ArrayList<>());

        Product product = new Product();
        product.setId(productId);
        product.setStockQuantity(1);

        when(cartRepository.findByUserId(userId)).thenReturn(Optional.of(cart));
        when(productRepository.findById(productId)).thenReturn(Optional.of(product));

        assertThrows(com.ecommerce.exception.APIException.class, () -> cartService.addItemToCart(userId, productId, 2));
    }
}
