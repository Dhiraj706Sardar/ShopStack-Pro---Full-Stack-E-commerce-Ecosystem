package com.ecommerce.controller.user;

import com.ecommerce.dto.ProductDTO;
import com.ecommerce.security.UserDetailsImpl;
import com.ecommerce.service.WishlistService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.UUID;

@RestController
@RequestMapping("/api/user/wishlist")
@PreAuthorize("hasRole('USER')")
public class UserWishlistController {

    @Autowired
    private WishlistService wishlistService;

    @GetMapping
    public ResponseEntity<List<ProductDTO>> getWishlist(Authentication authentication) {
        UserDetailsImpl userDetails = (UserDetailsImpl) authentication.getPrincipal();
        return ResponseEntity.ok(wishlistService.getWishlist(userDetails.getId()));
    }

    @PostMapping("/add/{productId}")
    public ResponseEntity<Void> addToWishlist(@PathVariable UUID productId, Authentication authentication) {
        UserDetailsImpl userDetails = (UserDetailsImpl) authentication.getPrincipal();
        wishlistService.addToWishlist(userDetails.getId(), productId);
        return ResponseEntity.ok().build();
    }

    @DeleteMapping("/remove/{productId}")
    public ResponseEntity<Void> removeFromWishlist(@PathVariable UUID productId, Authentication authentication) {
        UserDetailsImpl userDetails = (UserDetailsImpl) authentication.getPrincipal();
        wishlistService.removeFromWishlist(userDetails.getId(), productId);
        return ResponseEntity.noContent().build();
    }

    @GetMapping("/check/{productId}")
    public ResponseEntity<Boolean> isInWishlist(@PathVariable UUID productId, Authentication authentication) {
        UserDetailsImpl userDetails = (UserDetailsImpl) authentication.getPrincipal();
        return ResponseEntity.ok(wishlistService.isInWishlist(userDetails.getId(), productId));
    }
}
