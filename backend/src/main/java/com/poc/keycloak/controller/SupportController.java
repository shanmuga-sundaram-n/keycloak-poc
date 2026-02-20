package com.poc.keycloak.controller;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/support")
public class SupportController {

    @GetMapping("/tickets")
    public ResponseEntity<Map<String, Object>> tickets() {
        return ResponseEntity.ok(Map.of(
                "tickets", List.of(
                        Map.of("id", "TKT-001", "subject", "Login issue", "status", "OPEN", "priority", "HIGH"),
                        Map.of("id", "TKT-002", "subject", "Password reset not working", "status", "IN_PROGRESS", "priority", "MEDIUM"),
                        Map.of("id", "TKT-003", "subject", "Account locked", "status", "RESOLVED", "priority", "LOW")
                ),
                "total", 3
        ));
    }
}
