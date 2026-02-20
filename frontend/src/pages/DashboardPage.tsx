import React, { useEffect, useState } from "react";
import { useAuth } from "../auth/useAuth";
import apiClient from "../api/client";

const DashboardPage: React.FC = () => {
  const { username, email, roles } = useAuth();
  const [dashboard, setDashboard] = useState<any>(null);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    apiClient
      .get("/api/user/dashboard")
      .then((res) => setDashboard(res.data))
      .catch((err) => setError(err.response?.status === 403 ? "Access denied" : "Failed to load dashboard"));
  }, []);

  return (
    <div style={styles.container}>
      <div className="page-header">
        <h1>Dashboard</h1>
      </div>
      <div className="card" style={styles.profile}>
        <h3>Profile</h3>
        <p><strong>Username:</strong> {username}</p>
        <p><strong>Email:</strong> {email}</p>
        <p><strong>Roles:</strong> {roles.filter(r => ["USER","ADMIN","SUPPORT"].includes(r)).join(", ")}</p>
      </div>

      {error && <div className="alert-error">{error}</div>}

      {dashboard && (
        <div className="card">
          <h3>{dashboard.message}</h3>
          <h4 style={{ marginTop: "1rem" }}>Notifications</h4>
          <ul style={styles.list}>
            {dashboard.notifications?.map((n: any) => (
              <li key={n.id}>{n.text}</li>
            ))}
          </ul>
          <h4 style={{ marginTop: "1.25rem" }}>Stats</h4>
          <div style={styles.statsGrid}>
            <div style={styles.statCard}>
              <span style={styles.statValue}>{dashboard.stats?.loginCount}</span>
              <span style={styles.statLabel}>Login Count</span>
            </div>
            <div style={styles.statCard}>
              <span style={styles.statValue}>{dashboard.stats?.lastActive}</span>
              <span style={styles.statLabel}>Last Active</span>
            </div>
          </div>
        </div>
      )}
    </div>
  );
};

const styles: Record<string, React.CSSProperties> = {
  container: { maxWidth: 900, margin: "0 auto", padding: "2rem 1.5rem" },
  profile: {
    marginBottom: "1.5rem",
    marginTop: "1rem",
    background: "linear-gradient(135deg, #eef2ff, #f8fafc)",
  },
  list: { paddingLeft: "1.25rem", color: "#334155" },
  statsGrid: {
    display: "grid",
    gridTemplateColumns: "repeat(auto-fit, minmax(180px, 1fr))",
    gap: "1rem",
    marginTop: "0.75rem",
  },
  statCard: {
    display: "flex",
    flexDirection: "column",
    padding: "1rem",
    backgroundColor: "#f8fafc",
    borderRadius: "8px",
    textAlign: "center",
  },
  statValue: { fontSize: "1.5rem", fontWeight: 700, color: "#6366f1" },
  statLabel: { fontSize: "0.8rem", color: "#64748b", marginTop: "0.25rem", textTransform: "uppercase", letterSpacing: "0.05em" },
};

export default DashboardPage;
