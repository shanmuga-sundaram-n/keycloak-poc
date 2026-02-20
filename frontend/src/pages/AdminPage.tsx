import React, { useEffect, useState } from "react";
import apiClient from "../api/client";

const AdminPage: React.FC = () => {
  const [users, setUsers] = useState<any>(null);
  const [settings, setSettings] = useState<any>(null);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    Promise.all([
      apiClient.get("/api/admin/users"),
      apiClient.get("/api/admin/settings"),
    ])
      .then(([usersRes, settingsRes]) => {
        setUsers(usersRes.data);
        setSettings(settingsRes.data);
      })
      .catch((err) => setError(err.response?.status === 403 ? "Access denied" : "Failed to load admin data"));
  }, []);

  if (error) return (
    <div style={styles.container}>
      <div className="alert-error">{error}</div>
    </div>
  );

  return (
    <div style={styles.container}>
      <div className="page-header">
        <h1>Admin Panel</h1>
      </div>

      {users && (
        <div className="card" style={styles.section}>
          <h3>Users ({users.total})</h3>
          <table>
            <thead>
              <tr>
                <th>ID</th>
                <th>Username</th>
                <th>Roles</th>
                <th>Active</th>
              </tr>
            </thead>
            <tbody>
              {users.users.map((u: any) => (
                <tr key={u.id}>
                  <td>{u.id}</td>
                  <td>{u.username}</td>
                  <td>{u.roles.join(", ")}</td>
                  <td>
                    <span style={{
                      display: "inline-block",
                      width: 8,
                      height: 8,
                      borderRadius: "50%",
                      backgroundColor: u.active ? "#22c55e" : "#94a3b8",
                      marginRight: 6,
                    }} />
                    {u.active ? "Active" : "Inactive"}
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      )}

      {settings && (
        <div className="card" style={styles.section}>
          <h3>Settings</h3>
          {Object.entries(settings.settings).map(([key, value]) => (
            <p key={key} style={styles.setting}><strong>{key}:</strong> {String(value)}</p>
          ))}
        </div>
      )}
    </div>
  );
};

const styles: Record<string, React.CSSProperties> = {
  container: { maxWidth: 900, margin: "0 auto", padding: "2rem 1.5rem" },
  section: { marginBottom: "1.5rem", marginTop: "1rem" },
  setting: { color: "#334155", margin: "0.5rem 0" },
};

export default AdminPage;
