import React from "react";
import { useAuth } from "../auth/useAuth";

const HomePage: React.FC = () => {
  const { authenticated, login, register } = useAuth();

  return (
    <div style={styles.container}>
      <h1 style={styles.hero}>Keycloak Authentication POC</h1>
      <p style={styles.subtitle}>
        A production-ready authentication and authorization system using Keycloak,
        Spring Boot, and React.
      </p>

      {!authenticated && (
        <div style={styles.actions}>
          <button onClick={login} className="btn-primary">Login</button>
          <button onClick={register} className="btn-secondary">Register</button>
        </div>
      )}

      <div style={styles.features}>
        <div className="card" style={styles.featureCard}>
          <h3 style={styles.featureTitle}>OAuth2 + PKCE</h3>
          <p style={styles.featureDesc}>Authorization Code Flow with PKCE for secure SPA authentication</p>
        </div>
        <div className="card" style={styles.featureCard}>
          <h3 style={styles.featureTitle}>Role-Based Access</h3>
          <p style={styles.featureDesc}>USER, ADMIN, and SUPPORT roles with fine-grained access control</p>
        </div>
        <div className="card" style={styles.featureCard}>
          <h3 style={styles.featureTitle}>JWT Security</h3>
          <p style={styles.featureDesc}>Stateless backend API with JWT validation via Keycloak public keys</p>
        </div>
      </div>
    </div>
  );
};

const styles: Record<string, React.CSSProperties> = {
  container: { maxWidth: 960, margin: "0 auto", padding: "4rem 1.5rem", textAlign: "center" },
  hero: { fontSize: "2.5rem", fontWeight: 700, letterSpacing: "-0.025em", color: "#0f172a" },
  subtitle: { color: "#64748b", fontSize: "1.15rem", marginBottom: "2.5rem", maxWidth: 600, marginLeft: "auto", marginRight: "auto" },
  actions: { display: "flex", gap: "1rem", justifyContent: "center", marginBottom: "3.5rem" },
  features: {
    display: "grid",
    gridTemplateColumns: "repeat(auto-fit, minmax(250px, 1fr))",
    gap: "1.5rem",
    textAlign: "left",
  },
  featureCard: { padding: "1.75rem" },
  featureTitle: { color: "#6366f1", fontWeight: 600, marginBottom: "0.5rem" },
  featureDesc: { color: "#64748b", fontSize: "0.9rem", lineHeight: 1.6 },
};

export default HomePage;
