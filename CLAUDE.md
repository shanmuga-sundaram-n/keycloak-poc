# CLAUDE.md
## AI Assistant Instructions for This Repository

This repository contains a **production-ready Keycloak Authentication & Authorization POC**
covering frontend and backend authentication, signup, login, and role-based access control (RBAC).

---

## 1. Project Goal

Build a **secure, production-ready authentication system** using:
- Keycloak as Identity Provider
- Frontend SPA authentication
- Backend API authorization
- OAuth2 + OpenID Connect
- JWT-based security
- Role-based access control

---

## 2. Tech Stack (Non-Negotiable)

### Identity & Security
- Keycloak (latest stable)
- OAuth2 Authorization Code Flow with PKCE
- OpenID Connect (OIDC)
- JWT

### Backend
- Java 17+
- Spring Boot
- Spring Security
- OAuth2 Resource Server

### Frontend
- React (SPA)
- Keycloak JS adapter
- Protected routes

### Infrastructure
- Docker & Docker Compose
- PostgreSQL for Keycloak

---

## 3. Architectural Principles

- Keycloak is the single source of truth for identity
- Backend APIs must be stateless
- No access tokens stored in localStorage
- Authorization enforced on backend
- Production security defaults only

---

## 4. Authentication Rules

- Signup & login via Keycloak only
- Authorization Code Flow + PKCE for SPA
- JWT validation via Keycloak public keys
- Secure refresh token handling
- Proper logout with session invalidation

---

## 5. Authorization Rules

- Realm roles for coarse access
- Client roles for fine-grained access
- Backend enforces RBAC
- Frontend role checks are UX-only

---

## 6. Environment Strategy

- Separate realms per environment
- Config via environment variables
- No hardcoded secrets

---

## 7. Code Quality

- Clean architecture
- Explicit security configuration
- No demo shortcuts
