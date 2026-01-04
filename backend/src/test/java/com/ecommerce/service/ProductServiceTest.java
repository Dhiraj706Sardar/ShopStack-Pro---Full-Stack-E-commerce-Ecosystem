package com.ecommerce.service;

import com.ecommerce.dto.ProductDTO;
import com.ecommerce.entity.Category;
import com.ecommerce.entity.Product;
import com.ecommerce.repository.CategoryRepository;
import com.ecommerce.repository.ProductRepository;
import com.ecommerce.service.impl.ProductServiceImpl;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.PageRequest;

import com.ecommerce.entity.User;
import com.ecommerce.repository.UserRepository;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;

import java.util.Collections;
import java.util.Optional;
import java.util.UUID;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.*;

class ProductServiceTest {

    @Mock
    private ProductRepository productRepository;

    @Mock
    private CategoryRepository categoryRepository;

    @Mock
    private UserRepository userRepository;

    @Mock
    private FileStorageService fileStorageService;

    @Mock
    private com.ecommerce.repository.WishlistRepository wishlistRepository;

    @Mock
    private com.ecommerce.repository.ReviewRepository reviewRepository;

    @Mock
    private com.ecommerce.repository.CartItemRepository cartItemRepository;

    @Mock
    private com.ecommerce.repository.OrderItemRepository orderItemRepository;

    @InjectMocks
    private ProductServiceImpl productService;

    @BeforeEach
    void setUp() {
        MockitoAnnotations.openMocks(this);
    }

    @Test
    void testGetAllProducts() {
        Product product = new Product();
        UUID productId = UUID.randomUUID();
        product.setId(productId);
        product.setName("Test Product");
        product.setPrice(10.0);

        Category category = new Category();
        category.setName("Test Category");
        product.setCategory(category);

        Page<Product> productPage = new PageImpl<>(Collections.singletonList(product));
        when(productRepository.findAll(any(org.springframework.data.jpa.domain.Specification.class),
                any(PageRequest.class))).thenReturn(productPage);

        Page<ProductDTO> result = productService.getAllProducts(null, null, null, null, null, null,
                PageRequest.of(0, 10));

        assertNotNull(result);
        assertEquals(1, result.getContent().size());
        assertEquals("Test Product", result.getContent().get(0).getName());
    }

    @Test
    void testGetProductById() {
        Product product = new Product();
        UUID productId = UUID.randomUUID();
        product.setId(productId);
        product.setName("Test Product");

        Category category = new Category();
        category.setName("Test Category");
        product.setCategory(category);

        when(productRepository.findById(productId)).thenReturn(Optional.of(product));

        ProductDTO result = productService.getProductById(productId);

        assertNotNull(result);
        assertEquals("Test Product", result.getName());
    }

    @Test
    void testDeleteProduct_Success() {
        UUID productId = UUID.randomUUID();
        UUID userId = UUID.randomUUID();
        Product product = new Product();
        product.setId(productId);
        User seller = new User();
        seller.setId(userId);
        product.setSeller(seller);

        // Mock Security Context
        com.ecommerce.security.UserDetailsImpl userDetails = mock(com.ecommerce.security.UserDetailsImpl.class);
        when(userDetails.getId()).thenReturn(userId);
        Authentication authentication = mock(Authentication.class);
        when(authentication.getPrincipal()).thenReturn(userDetails);
        SecurityContextHolder.getContext().setAuthentication(authentication);

        when(productRepository.findById(productId)).thenReturn(Optional.of(product));

        productService.deleteProduct(productId);

        verify(productRepository, times(1)).delete(product);
        verify(wishlistRepository, times(1)).removeProductFromAllWishlists(productId);
        verify(reviewRepository, times(1)).deleteByProductId(productId);
    }

    @Test
    void testDeleteProduct_AccessDenied() {
        UUID productId = UUID.randomUUID();
        UUID userId = UUID.randomUUID();
        UUID otherUserId = UUID.randomUUID();
        Product product = new Product();
        product.setId(productId);
        User seller = new User();
        seller.setId(otherUserId);
        product.setSeller(seller);

        // Mock Security Context
        com.ecommerce.security.UserDetailsImpl userDetails = mock(com.ecommerce.security.UserDetailsImpl.class);
        when(userDetails.getId()).thenReturn(userId);
        Authentication authentication = mock(Authentication.class);
        when(authentication.getPrincipal()).thenReturn(userDetails);
        SecurityContextHolder.getContext().setAuthentication(authentication);

        when(productRepository.findById(productId)).thenReturn(Optional.of(product));

        assertThrows(org.springframework.security.access.AccessDeniedException.class,
                () -> productService.deleteProduct(productId));
    }
}
