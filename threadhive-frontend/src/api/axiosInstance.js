import axios from "axios";

const axiosInstance = axios.create({
  // Configurable at build time via VITE_API_BASE_URL (Vite inlines it into
  // the bundle). Falls back to the local dev backend when unset.
  baseURL: import.meta.env.VITE_API_BASE_URL || "http://localhost:5000/api",
});

export default axiosInstance;
