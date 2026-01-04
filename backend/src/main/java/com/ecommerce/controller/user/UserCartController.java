package com.ecommerce.controller.user;

import com.ecommerce.dto.CartDTO;
import com.ecommerce.security.UserDetailsImpl;
import com.ecommerce.service.CartService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;
import java.util.UUID;

@RestController
@RequestMapping("/api/user/cart")
@PreAuthorize("hasRole('USER')")
public class UserCartController {

    @Autowired
    private CartService cartService;

    @GetMapping
    public ResponseEntity<CartDTO> getCart(Authentication authentication) {
        UserDetailsImpl userDetails = (UserDetailsImpl) authentication.getPrincipal();
        return ResponseEntity.ok(cartService.getCartByUserId(userDetails.getId()));
    }

    @PostMapping("/add")
    public ResponseEntity<CartDTO> addItemToCart(@RequestParam UUID productId, @RequestParam Integer quantity,
            Authentication authentication) {
        UserDetailsImpl userDetails = (UserDetailsImpl) authentication.getPrincipal();
        return ResponseEntity.ok(cartService.addItemToCart(userDetails.getId(), productId, quantity));
    }

    @DeleteMapping("/remove/{productId}")
    public ResponseEntity<CartDTO> removeItemFromCart(@PathVariable UUID productId, Authentication authentication) {
        UserDetailsImpl userDetails = (UserDetailsImpl) authentication.getPrincipal();
        return ResponseEntity.ok(cartService.removeItemFromCart(userDetails.getId(), productId));
    }

    @PutMapping("/update")
    public ResponseEntity<CartDTO> updateItemQuantity(@RequestParam UUID productId, @RequestParam Integer quantity,
            Authentication authentication) {
        UserDetailsImpl userDetails = (UserDetailsImpl) authentication.getPrincipal();
        return ResponseEntity.ok(cartService.updateItemQuantity(userDetails.getId(), productId, quantity));
    }

    @DeleteMapping("/clear")
    public ResponseEntity<Void> clearCart(Authentication authentication) {
        UserDetailsImpl userDetails = (UserDetailsImpl) authentication.getPrincipal();
        cartService.clearCart(userDetails.getId());
        return ResponseEntity.noContent().build();
    }
}
