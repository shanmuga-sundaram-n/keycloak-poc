declare module "keycloak-js" {
  interface KeycloakConfig {
    url?: string;
    realm: string;
    clientId: string;
  }

  interface KeycloakInitOptions {
    onLoad?: "check-sso" | "login-required";
    silentCheckSsoRedirectUri?: string;
    pkceMethod?: "S256";
    checkLoginIframe?: boolean;
  }

  interface KeycloakTokenParsed {
    preferred_username?: string;
    email?: string;
    given_name?: string;
    family_name?: string;
    realm_access?: { roles: string[] };
    [key: string]: unknown;
  }

  interface KeycloakRealmAccess {
    roles: string[];
  }

  class Keycloak {
    constructor(config?: KeycloakConfig);
    init(options?: KeycloakInitOptions): Promise<boolean>;
    login(options?: { redirectUri?: string }): Promise<void>;
    logout(options?: { redirectUri?: string }): Promise<void>;
    register(options?: { redirectUri?: string }): Promise<void>;
    updateToken(minValidity: number): Promise<boolean>;
    hasRealmRole(role: string): boolean;

    authenticated?: boolean;
    token?: string;
    tokenParsed?: KeycloakTokenParsed;
    realmAccess?: KeycloakRealmAccess;
  }

  export default Keycloak;
}
