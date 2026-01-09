package com.ecommerce.service.impl;

import com.ecommerce.dto.UserDTO;
import com.ecommerce.dto.UserUpdateRequest;
import com.ecommerce.entity.PasswordResetToken;
import com.ecommerce.entity.User;
import com.ecommerce.exception.ResourceNotFoundException;
import com.ecommerce.repository.PasswordResetRepository;
import com.ecommerce.repository.UserRepository;
import com.ecommerce.security.jwt.JwtUtils;
import com.ecommerce.service.UserService;

import lombok.AllArgsConstructor;

import com.ecommerce.service.FileStorageService;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.UUID;
import java.util.stream.Collectors;

@Service
public class UserServiceImpl implements UserService {

    private UserRepository userRepository;

    private PasswordEncoder encoder;

    private FileStorageService fileStorageService;

    private PasswordResetRepository passwordResetRepository;

    private JwtUtils jwtUtils;

    private com.ecommerce.service.EmailService emailService;

    public UserServiceImpl(UserRepository userRepository, PasswordEncoder encoder,
            FileStorageService fileStorageService, PasswordResetRepository passwordResetRepository, JwtUtils jwtUtils,
            com.ecommerce.service.EmailService emailService) {
        this.userRepository = userRepository;
        this.encoder = encoder;
        this.fileStorageService = fileStorageService;
        this.passwordResetRepository = passwordResetRepository;
        this.jwtUtils = jwtUtils;
        this.emailService = emailService;
    }

    @Override
    public UserDTO getUserProfile(UUID userId) {
        User user = userRepository.findById(java.util.Objects.requireNonNull(userId))
                .orElseThrow(() -> new ResourceNotFoundException("User not found"));
        return mapToDTO(user);
    }

    @Override
    @Transactional
    public UserDTO updateUserProfile(UUID userId, UserUpdateRequest updateRequest,
            org.springframework.web.multipart.MultipartFile image) {
        User user = userRepository.findById(java.util.Objects.requireNonNull(userId))
                .orElseThrow(() -> new ResourceNotFoundException("User not found"));

        if (updateRequest != null) {
            if (updateRequest.getUsername() != null && !updateRequest.getUsername().isBlank()) {
                user.setUsername(updateRequest.getUsername());
            }
            if (updateRequest.getEmail() != null && !updateRequest.getEmail().isBlank()) {
                if (!updateRequest.getEmail().equals(user.getEmail())) {
                    if (userRepository.existsByEmail(updateRequest.getEmail())) {
                        throw new com.ecommerce.exception.APIException("Error: Email is already in use!");
                    }
                    user.setEmail(updateRequest.getEmail());
                }
            }
            if (updateRequest.getPassword() != null && !updateRequest.getPassword().isEmpty()) {
                user.setPassword(encoder.encode(updateRequest.getPassword()));
            }
        }

        // Handle image upload
        if (image != null && !image.isEmpty()) {
            try {
                String imageUrl = fileStorageService.uploadFile(image);
                user.setProfileImageUrl(imageUrl);
            } catch (Exception e) {
                throw new com.ecommerce.exception.APIException("Failed to upload profile image: " + e.getMessage(), e);
            }
        }

        User updatedUser = userRepository.save(user);
        System.out.println("User updated successfully: " + updatedUser.getUsername());
        return mapToDTO(updatedUser);
    }

    @Override
    public java.util.List<UserDTO> getAllUsers() {
        return userRepository.findAll().stream()
                .map(this::mapToDTO)
                .collect(Collectors.toList());
    }

    @Override
    public void banUser(UUID userId) {
        User user = userRepository.findById(java.util.Objects.requireNonNull(userId))
                .orElseThrow(() -> new ResourceNotFoundException("User not found"));
        user.setIsActive(false);
        userRepository.save(user);
    }

    @Override
    public void unbanUser(UUID userId) {
        User user = userRepository.findById(java.util.Objects.requireNonNull(userId))
                .orElseThrow(() -> new ResourceNotFoundException("User not found"));
        user.setIsActive(true);
        userRepository.save(user);
    }

    private UserDTO mapToDTO(User user) {
        UserDTO dto = new UserDTO();
        dto.setId(user.getId());
        dto.setUsername(user.getUsername());
        dto.setEmail(user.getEmail());
        dto.setRoles(user.getRoles().stream()
                .map(role -> role.getName().name())
                .collect(Collectors.toSet()));
        dto.setActive(user.getIsActive());
        dto.setProfileImageUrl(user.getProfileImageUrl());
        return dto;
    }

    @Override
    @Transactional
    public String initiatePasswordReset(String email) {
        User user = userRepository.findByEmail(email)
                .orElseThrow(() -> new ResourceNotFoundException("User not found"));

        // Find and delete existing token explicitly to avoid Duplicate Entry error
        passwordResetRepository.findByUser(user).ifPresent(t -> {
            passwordResetRepository.delete(t);
            passwordResetRepository.flush();
        });

        String token = UUID.randomUUID().toString();
        PasswordResetToken passwordResetToken = new PasswordResetToken();
        passwordResetToken.setToken(token);
        passwordResetToken.setUser(user);
        passwordResetToken.setExpiryDate(LocalDateTime.now().plusHours(24));
        passwordResetRepository.save(passwordResetToken);

        // Send Email
        emailService.sendPasswordResetEmail(email, token);

        return token;
    }

    @Override
    public String completePasswordReset(String token, String newPassword) {
        PasswordResetToken passwordResetToken = passwordResetRepository.findByToken(token)
                .orElseThrow(() -> new ResourceNotFoundException("Password reset token not found"));
        if (passwordResetToken.getExpiryDate().isBefore(LocalDateTime.now())) {
            throw new RuntimeException("Password reset token has expired");
        }
        User user = passwordResetToken.getUser();
        user.setPassword(encoder.encode(newPassword));
        userRepository.save(user);
        passwordResetRepository.delete(passwordResetToken);
        return "Password reset successfully";
    }

}
