package com.ecommerce.service.impl;

import com.ecommerce.dto.AuthResponse;
import com.ecommerce.dto.LoginRequest;
import com.ecommerce.dto.MessageResponse;
import com.ecommerce.dto.SignupRequest;
import com.ecommerce.exception.APIException;
import com.ecommerce.entity.ERole;
import com.ecommerce.entity.Role;
import com.ecommerce.entity.User;
import com.ecommerce.repository.RoleRepository;
import com.ecommerce.repository.UserRepository;
import com.ecommerce.security.UserDetailsImpl;
import com.ecommerce.security.jwt.JwtUtils;
import com.ecommerce.service.AuthService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

@Service
public class AuthServiceImpl implements AuthService {

    @Autowired
    private AuthenticationManager authenticationManager;

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private RoleRepository roleRepository;

    @Autowired
    private PasswordEncoder encoder;

    @Autowired
    private JwtUtils jwtUtils;

    @Autowired
    private com.ecommerce.service.RefreshTokenService refreshTokenService;

    @Override
    public AuthResponse authenticateUser(LoginRequest loginRequest) {
        // Check if user exists and is active
        User user = userRepository.findByEmail(loginRequest.getEmail())
                .orElseThrow(() -> new APIException("User Not Found with email: " + loginRequest.getEmail()));

        if (!user.getIsActive()) {
            throw new APIException("Your account is banned. Please contact admin@gmail.com");
        }

        Authentication authentication = authenticationManager.authenticate(
                new UsernamePasswordAuthenticationToken(loginRequest.getEmail(),
                        loginRequest.getPassword()));

        SecurityContextHolder.getContext().setAuthentication(authentication);
        String jwt = jwtUtils.generateJwtToken(authentication);

        UserDetailsImpl userDetails = (UserDetailsImpl) authentication.getPrincipal();
        List<String> roles = userDetails.getAuthorities().stream()
                .map(item -> item.getAuthority())
                .collect(Collectors.toList());

        com.ecommerce.entity.RefreshToken refreshToken = refreshTokenService.createRefreshToken(userDetails.getId());

        return new AuthResponse(jwt, refreshToken.getToken(), "Bearer", "Login successful",
                userDetails.getId(),
                userDetails.getUsername(),
                userDetails.getEmail(),
                roles);
    }

    @Override
    public AuthResponse registerUser(SignupRequest signUpRequest) {
        if (userRepository.existsByEmail(signUpRequest.getEmail())) {
            throw new APIException("Error: Email is already in use!");
        }

        // Create new user's account
        User user = new User();
        user.setUsername(signUpRequest.getUsername());
        user.setEmail(signUpRequest.getEmail());
        user.setPassword(encoder.encode(signUpRequest.getPassword()));

        Set<String> strRoles = signUpRequest.getRole();
        Set<Role> roles = new HashSet<>();

        if (strRoles == null) {
            roles.add(getOrCreateRole(ERole.ROLE_USER));
        } else {
            for (String role : strRoles) {
                switch (role) {
                    case "admin":
                        roles.add(getOrCreateRole(ERole.ROLE_ADMIN));
                        break;
                    case "seller":
                        roles.add(getOrCreateRole(ERole.ROLE_SELLER));
                        break;
                    default:
                        roles.add(getOrCreateRole(ERole.ROLE_USER));
                }
            }
        }

        user.setRoles(roles);
        userRepository.save(user);

        // Authenticate the user
        Authentication authentication = authenticationManager.authenticate(
                new UsernamePasswordAuthenticationToken(signUpRequest.getEmail(),
                        signUpRequest.getPassword()));

        SecurityContextHolder.getContext().setAuthentication(authentication);
        String jwt = jwtUtils.generateJwtToken(authentication);

        UserDetailsImpl userDetails = (UserDetailsImpl) authentication.getPrincipal();
        List<String> userRoles = userDetails.getAuthorities().stream()
                .map(item -> item.getAuthority())
                .collect(Collectors.toList());

        com.ecommerce.entity.RefreshToken refreshToken = refreshTokenService.createRefreshToken(userDetails.getId());

        return new AuthResponse(jwt, refreshToken.getToken(), "Bearer", "User registered successfully!",
                userDetails.getId(),
                userDetails.getUsername(),
                userDetails.getEmail(),
                userRoles);
    }

    private Role getOrCreateRole(ERole roleName) {
        return roleRepository.findByName(roleName)
                .orElseGet(() -> {
                    Role newRole = new Role();
                    newRole.setName(roleName);
                    return roleRepository.save(newRole);
                });
    }
}
