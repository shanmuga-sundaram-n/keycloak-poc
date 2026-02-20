package com.poc.keycloak.config;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.oauth2.core.DelegatingOAuth2TokenValidator;
import org.springframework.security.oauth2.core.OAuth2TokenValidator;
import org.springframework.security.oauth2.jwt.Jwt;
import org.springframework.security.oauth2.jwt.JwtClaimNames;
import org.springframework.security.oauth2.jwt.JwtClaimValidator;
import org.springframework.security.oauth2.jwt.JwtDecoder;
import org.springframework.security.oauth2.jwt.JwtTimestampValidator;
import org.springframework.security.oauth2.jwt.NimbusJwtDecoder;

import java.util.List;

@Configuration
public class JwtConfig {

    @Value("${spring.security.oauth2.resourceserver.jwt.jwk-set-uri}")
    private String jwkSetUri;

    @Value("${spring.security.oauth2.resourceserver.jwt.issuer-uri}")
    private String issuerUri;

    @Value("${app.jwt.accepted-issuers:}")
    private String acceptedIssuers;

    @Bean
    public JwtDecoder jwtDecoder() {
        NimbusJwtDecoder decoder = NimbusJwtDecoder.withJwkSetUri(jwkSetUri).build();

        // Build list of accepted issuers (handles Docker internal vs external URLs)
        List<String> issuers = new java.util.ArrayList<>();
        issuers.add(issuerUri);
        if (acceptedIssuers != null && !acceptedIssuers.isEmpty()) {
            for (String issuer : acceptedIssuers.split(",")) {
                String trimmed = issuer.trim();
                if (!trimmed.isEmpty()) {
                    issuers.add(trimmed);
                }
            }
        }

        OAuth2TokenValidator<Jwt> issuerValidator = new JwtClaimValidator<String>(
                JwtClaimNames.ISS, issuers::contains);
        OAuth2TokenValidator<Jwt> timestampValidator = new JwtTimestampValidator();

        decoder.setJwtValidator(new DelegatingOAuth2TokenValidator<>(timestampValidator, issuerValidator));
        return decoder;
    }
}
