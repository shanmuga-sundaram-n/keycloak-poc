import Keycloak from "keycloak-js";

const keycloak = new Keycloak({
  url: process.env.REACT_APP_KEYCLOAK_URL || "http://localhost:8080",
  realm: process.env.REACT_APP_KEYCLOAK_REALM || "poc-realm",
  clientId: process.env.REACT_APP_KEYCLOAK_CLIENT_ID || "poc-frontend",
});

export default keycloak;
