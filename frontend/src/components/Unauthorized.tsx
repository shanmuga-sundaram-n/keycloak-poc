import React from "react";
import { Link } from "react-router-dom";

const Unauthorized: React.FC = () => {
  return (
    <div style={styles.container}>
      <h1 style={styles.code}>403</h1>
      <h2>Access Denied</h2>
      <p style={styles.message}>You do not have the required permissions to access this page.</p>
      <Link to="/dashboard" className="btn-primary">Go to Dashboard</Link>
    </div>
  );
};

const styles: Record<string, React.CSSProperties> = {
  container: { textAlign: "center", padding: "5rem 2rem" },
  code: {
    fontSize: "5rem",
    fontWeight: 800,
    margin: 0,
    background: "linear-gradient(135deg, #6366f1, #ec4899)",
    WebkitBackgroundClip: "text",
    WebkitTextFillColor: "transparent",
  },
  message: { color: "#64748b", margin: "1rem 0 2.5rem" },
};

export default Unauthorized;
