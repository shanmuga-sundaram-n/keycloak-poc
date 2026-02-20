package com.poc.keycloak.controller;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/admin")
public class AdminController {

    @GetMapping("/users")
    public ResponseEntity<Map<String, Object>> users() {
        return ResponseEntity.ok(Map.of(
                "users", List.of(
                        Map.of("id", 1, "username", "testuser", "roles", List.of("USER"), "active", true),
                        Map.of("id", 2, "username", "testadmin", "roles", List.of("USER", "ADMIN"), "active", true),
                        Map.of("id", 3, "username", "testsupport", "roles", List.of("USER", "SUPPORT"), "active", true)
                ),
                "total", 3
        ));
    }

    @GetMapping("/settings")
    public ResponseEntity<Map<String, Object>> settings() {
        return ResponseEntity.ok(Map.of(
                "settings", Map.of(
                        "registrationEnabled", true,
                        "emailVerificationRequired", true,
                        "passwordPolicy", "8 characters minimum",
                        "sessionTimeout", "30 minutes"
                )
        ));
    }
}
