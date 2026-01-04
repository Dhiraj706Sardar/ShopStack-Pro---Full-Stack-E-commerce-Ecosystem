package com.ecommerce.dto;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Data;
import java.util.UUID;
import java.util.Set;

@Data
public class UserDTO {
    private UUID id;
    private String username;
    private String email;
    private Set<String> roles;

    @JsonProperty("isActive")
    private boolean isActive;

    private String profileImageUrl;
}
