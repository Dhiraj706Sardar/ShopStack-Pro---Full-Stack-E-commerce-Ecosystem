package com.ecommerce.dto;

import com.fasterxml.jackson.databind.ObjectMapper;
import org.junit.jupiter.api.Test;

import java.util.Set;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertTrue;

public class SignupRequestTest {

    private final ObjectMapper objectMapper = new ObjectMapper();

    @Test
    public void testDeserializeRoleAsString() throws Exception {
        String json = "{\"username\":\"testuser\",\"email\":\"test@example.com\",\"password\":\"password123\",\"role\":\"ROLE_USER\"}";
        SignupRequest request = objectMapper.readValue(json, SignupRequest.class);

        assertTrue(request.getRole().contains("ROLE_USER"));
        assertEquals(1, request.getRole().size());
    }

    @Test
    public void testDeserializeRoleAsArray() throws Exception {
        String json = "{\"username\":\"testuser\",\"email\":\"test@example.com\",\"password\":\"password123\",\"role\":[\"ROLE_USER\", \"ROLE_ADMIN\"]}";
        SignupRequest request = objectMapper.readValue(json, SignupRequest.class);

        assertTrue(request.getRole().contains("ROLE_USER"));
        assertTrue(request.getRole().contains("ROLE_ADMIN"));
        assertEquals(2, request.getRole().size());
    }
}
