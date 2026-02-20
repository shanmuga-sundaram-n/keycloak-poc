import React, { createContext, useEffect, useState, useCallback, useRef } from "react";
import keycloak from "./keycloak";

interface AuthContextType {
  authenticated: boolean;
  initialized: boolean;
  token: string | undefined;
  username: string | undefined;
  email: string | undefined;
  roles: string[];
  login: () => void;
  logout: () => void;
  register: () => void;
  hasRole: (role: string) => boolean;
}

export const AuthContext = createContext<AuthContextType>({
  authenticated: false,
  initialized: false,
  token: undefined,
  username: undefined,
  email: undefined,
  roles: [],
  login: () => {},
  logout: () => {},
  register: () => {},
  hasRole: () => false,
});

interface AuthProviderProps {
  children: React.ReactNode;
}

export const AuthProvider: React.FC<AuthProviderProps> = ({ children }) => {
  const [authenticated, setAuthenticated] = useState(false);
  const [initialized, setInitialized] = useState(false);
  const didInit = useRef(false);

  useEffect(() => {
    if (didInit.current) return;
    didInit.current = true;

    keycloak
      .init({
        onLoad: "check-sso",
        silentCheckSsoRedirectUri:
          window.location.origin + "/silent-check-sso.html",
        pkceMethod: "S256",
        checkLoginIframe: false,
      })
      .then((auth: boolean) => {
        setAuthenticated(auth);
        setInitialized(true);

        if (auth) {
          // Refresh token before it expires
          setInterval(() => {
            keycloak
              .updateToken(60)
              .catch(() => keycloak.logout());
          }, 30000);
        }
      })
      .catch((err: unknown) => {
        console.error("Keycloak init failed:", err);
        setInitialized(true);
      });
  }, []);

  const login = useCallback(() => {
    keycloak.login();
  }, []);

  const logout = useCallback(() => {
    keycloak.logout({ redirectUri: window.location.origin });
  }, []);

  const register = useCallback(() => {
    keycloak.register();
  }, []);

  const hasRole = useCallback((role: string) => {
    return keycloak.hasRealmRole(role);
  }, []);

  const getRoles = (): string[] => {
    return keycloak.realmAccess?.roles || [];
  };

  return (
    <AuthContext.Provider
      value={{
        authenticated,
        initialized,
        token: keycloak.token,
        username: keycloak.tokenParsed?.preferred_username,
        email: keycloak.tokenParsed?.email,
        roles: getRoles(),
        login,
        logout,
        register,
        hasRole,
      }}
    >
      {children}
    </AuthContext.Provider>
  );
};
