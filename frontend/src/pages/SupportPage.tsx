import React, { useEffect, useState } from "react";
import apiClient from "../api/client";

const SupportPage: React.FC = () => {
  const [tickets, setTickets] = useState<any>(null);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    apiClient
      .get("/api/support/tickets")
      .then((res) => setTickets(res.data))
      .catch((err) => setError(err.response?.status === 403 ? "Access denied" : "Failed to load tickets"));
  }, []);

  if (error) return (
    <div style={styles.container}>
      <div className="alert-error">{error}</div>
    </div>
  );

  return (
    <div style={styles.container}>
      <div className="page-header">
        <h1>Support Tickets</h1>
      </div>

      {tickets && (
        <div className="card" style={{ marginTop: "1rem" }}>
          <h3>Tickets ({tickets.total})</h3>
          <table>
            <thead>
              <tr>
                <th>ID</th>
                <th>Subject</th>
                <th>Status</th>
                <th>Priority</th>
              </tr>
            </thead>
            <tbody>
              {tickets.tickets.map((t: any) => (
                <tr key={t.id}>
                  <td>{t.id}</td>
                  <td>{t.subject}</td>
                  <td>
                    <span className="badge" style={{ backgroundColor: statusColor(t.status) }}>
                      {t.status}
                    </span>
                  </td>
                  <td>{t.priority}</td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      )}
    </div>
  );
};

const statusColor = (status: string): string => {
  switch (status) {
    case "OPEN": return "#ef4444";
    case "IN_PROGRESS": return "#f59e0b";
    case "RESOLVED": return "#22c55e";
    default: return "#94a3b8";
  }
};

const styles: Record<string, React.CSSProperties> = {
  container: { maxWidth: 900, margin: "0 auto", padding: "2rem 1.5rem" },
};

export default SupportPage;
