import axios from "axios";
import keycloak from "../auth/keycloak";

const apiClient = axios.create({
  baseURL: process.env.REACT_APP_API_URL || "http://localhost:8081",
});

apiClient.interceptors.request.use(
  async (config) => {
    if (keycloak.authenticated) {
      try {
        await keycloak.updateToken(30);
      } catch {
        keycloak.logout();
        return Promise.reject(new Error("Token refresh failed"));
      }
      config.headers.Authorization = `Bearer ${keycloak.token}`;
    }
    return config;
  },
  (error) => Promise.reject(error)
);

export default apiClient;
