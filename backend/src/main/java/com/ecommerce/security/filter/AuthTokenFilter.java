package com.ecommerce.security.filter;

import com.ecommerce.security.UserDetailsServiceImpl;
import com.ecommerce.security.jwt.JwtUtils;
import org.springframework.http.MediaType;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.web.authentication.WebAuthenticationDetailsSource;
import org.springframework.util.StringUtils;
import org.springframework.web.filter.OncePerRequestFilter;

import java.io.IOException;

public class AuthTokenFilter extends OncePerRequestFilter {
    @Autowired
    private JwtUtils jwtUtils;

    @Autowired
    private UserDetailsServiceImpl userDetailsService;

    private static final Logger logger = LoggerFactory.getLogger(AuthTokenFilter.class);

    @Autowired
    private com.ecommerce.service.RefreshTokenService refreshTokenService;

    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain)
            throws ServletException, IOException {
        try {
            String jwt = parseJwt(request);
            if (jwt != null) {
                try {
                    jwtUtils.validateJwtTokenThrows(jwt);
                    authenticateUser(jwt, request);
                } catch (io.jsonwebtoken.ExpiredJwtException e) {
                    logger.debug("JWT token is expired: {}", e.getMessage());
                    // Try to refresh token using cookie
                    String refreshToken = getRefreshTokenFromCookies(request);
                    if (refreshToken != null) {
                        try {
                            com.ecommerce.entity.RefreshToken token = refreshTokenService.findByToken(refreshToken)
                                    .map(refreshTokenService::verifyExpiration)
                                    .orElse(null);

                            if (token != null) {
                                String newAccessToken = jwtUtils.generateTokenFromUsername(token.getUser().getEmail());
                                response.setHeader("New-Access-Token", newAccessToken);
                                authenticateUser(newAccessToken, request);
                                logger.debug("Token refreshed successfully for user: {}", token.getUser().getEmail());
                            }
                        } catch (Exception ex) {
                            logger.error("Could not refresh token: {}", ex.getMessage());
                        }
                    }
                } catch (Exception e) {
                    logger.error("Cannot set user authentication: {}", e.getMessage());
                }
            }
        } catch (Exception e) {
            logger.error("Cannot set user authentication: {}", e.getMessage());
        }

        filterChain.doFilter(request, response);
    }

    private void authenticateUser(String jwt, HttpServletRequest request) {
        String email = jwtUtils.getEmailFromJwtToken(jwt);
        UserDetails userDetails = userDetailsService.loadUserByUsername(email);
        UsernamePasswordAuthenticationToken authentication = new UsernamePasswordAuthenticationToken(
                userDetails, null, userDetails.getAuthorities());
        authentication.setDetails(new WebAuthenticationDetailsSource().buildDetails(request));
        SecurityContextHolder.getContext().setAuthentication(authentication);
    }

    private String getRefreshTokenFromCookies(HttpServletRequest request) {
        if (request.getCookies() != null) {
            for (jakarta.servlet.http.Cookie cookie : request.getCookies()) {
                if ("refresh_token".equals(cookie.getName())) {
                    return cookie.getValue();
                }
            }
        }
        return null;
    }

    private String parseJwt(HttpServletRequest request) {
        String headerAuth = request.getHeader("Authorization");

        if (StringUtils.hasText(headerAuth) && headerAuth.startsWith("Bearer ")) {
            return headerAuth.substring(7);
        }

        return null;
    }
}
