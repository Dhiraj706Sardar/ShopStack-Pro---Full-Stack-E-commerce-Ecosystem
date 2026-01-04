package com.ecommerce.controller.user;

import com.ecommerce.dto.UserUpdateRequest;
import com.ecommerce.dto.UserDTO;
import com.ecommerce.security.UserDetailsImpl;
import com.ecommerce.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/user/profile")
@PreAuthorize("hasAnyRole('USER', 'ADMIN', 'SELLER')")
public class UserProfileController {

    @Autowired
    private UserService userService;

    @Autowired
    private com.fasterxml.jackson.databind.ObjectMapper objectMapper;

    @GetMapping
    public ResponseEntity<UserDTO> getProfile(Authentication authentication) {
        UserDetailsImpl userDetails = (UserDetailsImpl) authentication.getPrincipal();
        return ResponseEntity.ok(userService.getUserProfile(userDetails.getId()));
    }

    @PutMapping(value = { "", "/{userId}" }, consumes = { "multipart/form-data" })
    public ResponseEntity<UserDTO> updateProfile(
            @PathVariable(value = "userId", required = false) java.util.UUID userId,
            @RequestParam(value = "user", required = false) String userJson,
            @RequestParam(value = "image", required = false) org.springframework.web.multipart.MultipartFile image,
            Authentication authentication) throws Exception {
        UserDetailsImpl userDetails = (UserDetailsImpl) authentication.getPrincipal();
        java.util.UUID targetUserId = (userId != null) ? userId : userDetails.getId();

        // Check permissions: Admin can update anyone, others only themselves
        if (!targetUserId.equals(userDetails.getId()) &&
                !authentication.getAuthorities().stream().anyMatch(a -> a.getAuthority().equals("ROLE_ADMIN"))) {
            return ResponseEntity.status(org.springframework.http.HttpStatus.FORBIDDEN).build();
        }

        UserUpdateRequest updateRequest = null;
        if (userJson != null && !userJson.isBlank()) {
            updateRequest = objectMapper.readValue(userJson, UserUpdateRequest.class);
        }
        return ResponseEntity.ok(userService.updateUserProfile(targetUserId, updateRequest, image));
    }

    @PutMapping(value = { "", "/{userId}" }, consumes = { "application/json" })
    public ResponseEntity<UserDTO> updateProfileJson(
            @PathVariable(value = "userId", required = false) java.util.UUID userId,
            @RequestBody UserUpdateRequest updateRequest,
            Authentication authentication) {
        UserDetailsImpl userDetails = (UserDetailsImpl) authentication.getPrincipal();
        java.util.UUID targetUserId = (userId != null) ? userId : userDetails.getId();

        // Check permissions
        if (!targetUserId.equals(userDetails.getId()) &&
                !authentication.getAuthorities().stream().anyMatch(a -> a.getAuthority().equals("ROLE_ADMIN"))) {
            return ResponseEntity.status(org.springframework.http.HttpStatus.FORBIDDEN).build();
        }

        return ResponseEntity.ok(userService.updateUserProfile(targetUserId, updateRequest, null));
    }
}
