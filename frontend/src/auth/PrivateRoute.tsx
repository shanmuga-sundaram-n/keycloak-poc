import React from "react";
import { Navigate } from "react-router-dom";
import { useAuth } from "./useAuth";
import Unauthorized from "../components/Unauthorized";

interface PrivateRouteProps {
  children: React.ReactNode;
  roles?: string[];
}

const PrivateRoute: React.FC<PrivateRouteProps> = ({ children, roles }) => {
  const { authenticated, initialized, hasRole } = useAuth();

  if (!initialized) {
    return <div style={{ padding: "2rem", textAlign: "center" }}>Loading...</div>;
  }

  if (!authenticated) {
    return <Navigate to="/" replace />;
  }

  if (roles && roles.length > 0) {
    const hasRequiredRole = roles.some((role) => hasRole(role));
    if (!hasRequiredRole) {
      return <Unauthorized />;
    }
  }

  return <>{children}</>;
};

export default PrivateRoute;
