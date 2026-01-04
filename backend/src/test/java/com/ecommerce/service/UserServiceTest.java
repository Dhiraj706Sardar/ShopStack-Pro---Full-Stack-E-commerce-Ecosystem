package com.ecommerce.service;

import com.ecommerce.dto.UserDTO;
import com.ecommerce.entity.PasswordResetToken;
import com.ecommerce.entity.User;
import com.ecommerce.exception.ResourceNotFoundException;
import com.ecommerce.repository.PasswordResetRepository;
import com.ecommerce.repository.UserRepository;
import com.ecommerce.service.impl.UserServiceImpl;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;
import org.springframework.security.crypto.password.PasswordEncoder;

import java.time.LocalDateTime;
import java.util.Collections;
import java.util.Optional;
import java.util.UUID;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.*;

class UserServiceTest {

    @Mock
    private UserRepository userRepository;

    @Mock
    private PasswordEncoder encoder;

    @Mock
    private PasswordResetRepository passwordResetRepository;

    @Mock
    private EmailService emailService;

    @InjectMocks
    private UserServiceImpl userService;

    @BeforeEach
    void setUp() {
        MockitoAnnotations.openMocks(this);
    }

    @Test
    void testGetUserProfile_Success() {
        UUID userId = UUID.randomUUID();
        User user = new User();
        user.setId(userId);
        user.setUsername("testuser");
        user.setEmail("test@example.com");
        user.setRoles(Collections.emptySet());
        user.setIsActive(true);

        when(userRepository.findById(userId)).thenReturn(Optional.of(user));

        UserDTO result = userService.getUserProfile(userId);

        assertNotNull(result);
        assertEquals("testuser", result.getUsername());
        assertEquals("test@example.com", result.getEmail());
        verify(userRepository, times(1)).findById(userId);
    }

    @Test
    void testGetUserProfile_NotFound() {
        UUID userId = UUID.randomUUID();
        when(userRepository.findById(userId)).thenReturn(Optional.empty());

        assertThrows(ResourceNotFoundException.class, () -> userService.getUserProfile(userId));
    }

    @Test
    void testInitiatePasswordReset_Success() {
        String email = "test@example.com";
        User user = new User();
        user.setEmail(email);

        when(userRepository.findByEmail(email)).thenReturn(Optional.of(user));
        when(passwordResetRepository.findByUser(user)).thenReturn(Optional.empty());

        String token = userService.initiatePasswordReset(email);

        assertNotNull(token);
        verify(passwordResetRepository, times(1)).save(any(PasswordResetToken.class));
        verify(emailService, times(1)).sendPasswordResetEmail(eq(email), anyString());
    }

    @Test
    void testCompletePasswordReset_Success() {
        String token = "valid-token";
        String newPassword = "new-password";
        User user = new User();
        PasswordResetToken resetToken = new PasswordResetToken();
        resetToken.setToken(token);
        resetToken.setUser(user);
        resetToken.setExpiryDate(LocalDateTime.now().plusHours(1));

        when(passwordResetRepository.findByToken(token)).thenReturn(Optional.of(resetToken));
        when(encoder.encode(newPassword)).thenReturn("encoded-password");

        String result = userService.completePasswordReset(token, newPassword);

        assertEquals("Password reset successfully", result);
        assertEquals("encoded-password", user.getPassword());
        verify(userRepository, times(1)).save(user);
        verify(passwordResetRepository, times(1)).delete(resetToken);
    }

    @Test
    void testCompletePasswordReset_ExpiredToken() {
        String token = "expired-token";
        PasswordResetToken resetToken = new PasswordResetToken();
        resetToken.setExpiryDate(LocalDateTime.now().minusHours(1));

        when(passwordResetRepository.findByToken(token)).thenReturn(Optional.of(resetToken));

        assertThrows(RuntimeException.class, () -> userService.completePasswordReset(token, "password"));
    }
}
