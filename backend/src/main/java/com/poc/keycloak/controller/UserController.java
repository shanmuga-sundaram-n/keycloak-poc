package com.poc.keycloak.controller;

import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.oauth2.jwt.Jwt;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/user")
public class UserController {

    @GetMapping("/profile")
    public ResponseEntity<Map<String, Object>> profile(@AuthenticationPrincipal Jwt jwt) {
        return ResponseEntity.ok(Map.of(
                "sub", jwt.getSubject(),
                "name", jwt.getClaimAsString("preferred_username"),
                "email", jwt.getClaimAsString("email"),
                "firstName", jwt.getClaimAsString("given_name"),
                "lastName", jwt.getClaimAsString("family_name"),
                "roles", jwt.getClaimAsMap("realm_access").get("roles")
        ));
    }

    @GetMapping("/dashboard")
    public ResponseEntity<Map<String, Object>> dashboard(@AuthenticationPrincipal Jwt jwt) {
        return ResponseEntity.ok(Map.of(
                "message", "Welcome to your dashboard, " + jwt.getClaimAsString("preferred_username") + "!",
                "notifications", List.of(
                        Map.of("id", 1, "text", "Your profile is complete"),
                        Map.of("id", 2, "text", "New features available")
                ),
                "stats", Map.of(
                        "loginCount", 42,
                        "lastActive", "2024-01-15T10:30:00Z"
                )
        ));
    }
}
