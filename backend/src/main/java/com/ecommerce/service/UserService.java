package com.ecommerce.service;

import com.ecommerce.dto.UserDTO;

import java.util.List;
import java.util.UUID;

public interface UserService {
    UserDTO getUserProfile(UUID userId);

    UserDTO updateUserProfile(UUID userId, com.ecommerce.dto.UserUpdateRequest updateRequest,
            org.springframework.web.multipart.MultipartFile image);

    List<UserDTO> getAllUsers();

    void banUser(UUID userId);

    void unbanUser(UUID userId);

    String initiatePasswordReset(String email);

    String completePasswordReset(String token, String newPassword);

}
