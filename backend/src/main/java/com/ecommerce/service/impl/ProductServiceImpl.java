package com.ecommerce.service.impl;

import com.ecommerce.dto.ProductDTO;
import com.ecommerce.entity.Category;
import com.ecommerce.entity.Product;
import com.ecommerce.entity.User;
import com.ecommerce.repository.CategoryRepository;
import com.ecommerce.repository.ProductRepository;
import com.ecommerce.repository.UserRepository;
import com.ecommerce.service.ProductService;
import com.ecommerce.service.FileStorageService;
import com.ecommerce.exception.ResourceNotFoundException;
import com.ecommerce.exception.APIException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import com.ecommerce.security.UserDetailsImpl;
import com.ecommerce.entity.ERole;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.cache.annotation.CacheEvict;
import java.util.UUID;
import java.util.Objects;
import java.util.stream.Collectors;
import com.ecommerce.entity.ProductVariant;
import com.ecommerce.dto.ProductVariantDTO;
import org.springframework.transaction.annotation.Transactional;

@Service
public class ProductServiceImpl implements ProductService {

    @Autowired
    private ProductRepository productRepository;

    @Autowired
    private CategoryRepository categoryRepository;

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private FileStorageService fileStorageService;

    @Autowired
    private com.ecommerce.repository.WishlistRepository wishlistRepository;

    @Autowired
    private com.ecommerce.repository.ReviewRepository reviewRepository;

    @Autowired
    private com.ecommerce.repository.CartItemRepository cartItemRepository;

    @Autowired
    private com.ecommerce.repository.OrderItemRepository orderItemRepository;

    @Override
    @Transactional
    public ProductDTO createProduct(ProductDTO productDTO, org.springframework.web.multipart.MultipartFile image) {
        Product product = mapToEntity(productDTO, new Product());

        // Handle image upload
        if (image != null && !image.isEmpty()) {
            try {
                String imageUrl = fileStorageService.uploadFile(image);
                product.setImageUrl(imageUrl);
            } catch (java.io.IOException e) {
                throw new APIException("Failed to upload image: " + e.getMessage());
            }
        }

        // Get current logged-in user
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        UserDetailsImpl userDetails = (UserDetailsImpl) authentication.getPrincipal();
        User currentUser = userRepository.findById(Objects.requireNonNull(userDetails.getId()))
                .orElseThrow(() -> new ResourceNotFoundException("User not found"));

        // If user is SELLER, force them as the seller
        boolean isSeller = userDetails.getAuthorities().stream()
                .anyMatch(a -> a.getAuthority().equals(ERole.ROLE_SELLER.name()));

        if (isSeller) {
            product.setSeller(currentUser);
        } else {
            // If ADMIN, allow setting seller from DTO or default to current user
            if (productDTO.getSellerId() != null) {
                User seller = userRepository.findById(Objects.requireNonNull(productDTO.getSellerId()))
                        .orElseThrow(() -> new ResourceNotFoundException("Seller not found"));
                product.setSeller(seller);
            } else {
                product.setSeller(currentUser);
            }
        }

        return mapToDTO(productRepository.save(product));
    }

    @Override
    @Transactional
    @CacheEvict(value = "products", key = "#id")
    public ProductDTO updateProduct(UUID id, ProductDTO productDTO,
            org.springframework.web.multipart.MultipartFile image) {
        Product product = productRepository.findById(Objects.requireNonNull(id))
                .orElseThrow(() -> new ResourceNotFoundException("Product not found"));

        validateProductOwnership(product);

        mapToEntity(productDTO, product);

        // Handle image upload
        if (image != null && !image.isEmpty()) {
            try {
                String imageUrl = fileStorageService.uploadFile(image);
                product.setImageUrl(imageUrl);
            } catch (java.io.IOException e) {
                throw new APIException("Failed to upload image: " + e.getMessage());
            }
        }

        return mapToDTO(productRepository.save(product));
    }

    @Override
    @CacheEvict(value = "products", key = "#id")
    @Transactional
    public void deleteProduct(UUID id) {
        Product product = productRepository.findById(Objects.requireNonNull(id))
                .orElseThrow(() -> new ResourceNotFoundException("Product not found"));

        validateProductOwnership(product);

        // Cleanup references before deleting product
        wishlistRepository.removeProductFromAllWishlists(id);
        reviewRepository.deleteByProductId(id);
        cartItemRepository.deleteByProductId(id);
        orderItemRepository.setProductToNull(id);

        productRepository.delete(Objects.requireNonNull(product));
    }

    @Override
    @Cacheable(value = "products", key = "#id")
    public ProductDTO getProductById(UUID id) {
        Product product = productRepository.findById(Objects.requireNonNull(id))
                .orElseThrow(() -> new ResourceNotFoundException("Product not found"));
        return mapToDTO(product);
    }

    @Override
    public Page<ProductDTO> getAllProducts(String name, UUID categoryId, Double minPrice, Double maxPrice,
            Boolean inStock, UUID sellerId,
            Pageable pageable) {
        org.springframework.data.jpa.domain.Specification<Product> spec = org.springframework.data.jpa.domain.Specification
                .where(null);

        if (name != null && !name.isEmpty()) {
            spec = spec.and((root, query, cb) -> cb.like(cb.lower(root.get("name")), "%" + name.toLowerCase() + "%"));
        }

        if (categoryId != null) {
            spec = spec.and((root, query, cb) -> cb.equal(root.get("category").get("id"), categoryId));
        }

        if (minPrice != null) {
            spec = spec.and((root, query, cb) -> cb.greaterThanOrEqualTo(root.get("price"), minPrice));
        }

        if (maxPrice != null) {
            spec = spec.and((root, query, cb) -> cb.lessThanOrEqualTo(root.get("price"), maxPrice));
        }

        if (inStock != null && inStock) {
            spec = spec.and((root, query, cb) -> cb.greaterThan(root.get("stockQuantity"), 0));
        }

        if (sellerId != null) {
            spec = spec.and((root, query, cb) -> cb.equal(root.get("seller").get("id"), sellerId));
        }

        return productRepository.findAll(spec, pageable).map(this::mapToDTO);
    }

    @Override
    public Page<ProductDTO> searchProducts(String name, Pageable pageable) {
        return productRepository.findByNameContainingIgnoreCase(name, pageable)
                .map(this::mapToDTO);
    }

    @Override
    public Page<ProductDTO> getAllProductsBySeller(UUID sellerId, Pageable pageable) {
        return productRepository.findBySellerId(sellerId, pageable).map(this::mapToDTO);
    }

    private ProductDTO mapToDTO(Product product) {
        ProductDTO dto = new ProductDTO();
        dto.setId(product.getId());
        dto.setName(product.getName());
        dto.setDescription(product.getDescription());
        dto.setPrice(product.getPrice());
        dto.setStockQuantity(product.getStockQuantity());
        dto.setImageUrl(product.getImageUrl());
        if (product.getCategory() != null) {
            dto.setCategoryId(product.getCategory().getId());
            dto.setCategoryName(product.getCategory().getName());
        }
        if (product.getSeller() != null) {
            dto.setSellerId(product.getSeller().getId());
            dto.setSellerName(product.getSeller().getUsername());
        }
        if (product.getVariants() != null) {
            dto.setVariants(product.getVariants().stream().map(variant -> {
                ProductVariantDTO variantDTO = new ProductVariantDTO();
                variantDTO.setId(variant.getId());
                variantDTO.setName(variant.getName());
                variantDTO.setValue(variant.getValue());
                variantDTO.setPrice(variant.getPrice());
                variantDTO.setStockQuantity(variant.getStockQuantity());
                variantDTO.setSku(variant.getSku());
                return variantDTO;
            }).collect(Collectors.toList()));
        }
        return dto;
    }

    private Product mapToEntity(ProductDTO dto, Product product) {
        product.setName(dto.getName());
        product.setDescription(dto.getDescription());
        product.setPrice(dto.getPrice());
        product.setStockQuantity(dto.getStockQuantity());
        if (dto.getImageUrl() != null) {
            product.setImageUrl(dto.getImageUrl());
        }

        if (dto.getCategoryId() != null) {
            Category category = categoryRepository.findById(dto.getCategoryId())
                    .orElseThrow(() -> new ResourceNotFoundException("Category not found"));
            product.setCategory(category);
        }

        if (dto.getSellerId() != null) {
            User seller = userRepository.findById(dto.getSellerId())
                    .orElseThrow(() -> new ResourceNotFoundException("Seller not found"));
            product.setSeller(seller);
        }

        if (dto.getVariants() != null) {
            // Clear existing variants and add new ones to handle orphanRemoval
            product.getVariants().clear();
            product.getVariants().addAll(dto.getVariants().stream().map(variantDTO -> {
                ProductVariant variant = new ProductVariant();
                variant.setId(variantDTO.getId());
                variant.setName(variantDTO.getName());
                variant.setValue(variantDTO.getValue());
                variant.setPrice(variantDTO.getPrice());
                variant.setStockQuantity(variantDTO.getStockQuantity());
                variant.setSku(variantDTO.getSku());
                variant.setProduct(product);
                return variant;
            }).collect(Collectors.toList()));
        }

        return product;
    }

    private void validateProductOwnership(Product product) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        UserDetailsImpl userDetails = (UserDetailsImpl) authentication.getPrincipal();

        boolean isAdmin = userDetails.getAuthorities().stream()
                .anyMatch(a -> a.getAuthority().equals(ERole.ROLE_ADMIN.name()));

        if (isAdmin) {
            return;
        }

        if (product.getSeller() == null
                || !product.getSeller().getId().equals(java.util.Objects.requireNonNull(userDetails.getId()))) {
            throw new AccessDeniedException("You are not authorized to manage this product");
        }
    }
}
