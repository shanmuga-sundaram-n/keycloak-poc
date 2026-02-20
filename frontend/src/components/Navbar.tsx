import React from "react";
import { Link } from "react-router-dom";
import { useAuth } from "../auth/useAuth";

const Navbar: React.FC = () => {
  const { authenticated, username, roles, login, logout, register } = useAuth();

  return (
    <nav className="site-header">
      <div className="site-header-brand">
        <Link to="/">Keycloak POC</Link>
      </div>
      <div className="site-header-links">
        <Link to="/" className="nav-link">Home</Link>
        {authenticated && (
          <>
            <Link to="/dashboard" className="nav-link">Dashboard</Link>
            {roles.includes("ADMIN") && (
              <Link to="/admin" className="nav-link">Admin</Link>
            )}
            {(roles.includes("SUPPORT") || roles.includes("ADMIN")) && (
              <Link to="/support" className="nav-link">Support</Link>
            )}
          </>
        )}
      </div>
      <div className="site-header-auth">
        {authenticated ? (
          <>
            <span className="username">{username}</span>
            <span className="roles-badge">{roles.filter(r => ["USER","ADMIN","SUPPORT"].includes(r)).join(", ")}</span>
            <button onClick={logout} className="nav-btn">Logout</button>
          </>
        ) : (
          <>
            <button onClick={login} className="nav-btn">Login</button>
            <button onClick={register} className="nav-btn nav-btn-primary">Register</button>
          </>
        )}
      </div>
    </nav>
  );
};

export default Navbar;
