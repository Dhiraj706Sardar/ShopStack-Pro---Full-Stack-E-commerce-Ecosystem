package com.ecommerce.service;

import java.util.Optional;
import java.util.UUID;

import com.ecommerce.entity.RefreshToken;

public interface RefreshTokenService {
    Optional<RefreshToken> findByToken(String token);

    RefreshToken createRefreshToken(UUID userId);

    RefreshToken verifyExpiration(RefreshToken token);

    int deleteByUserId(UUID userId);
}
