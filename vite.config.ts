import { defineConfig } from "vite";
import react from "@vitejs/plugin-react";

// https://vitejs.dev/config/
export default defineConfig(async () => ({
  plugins: [react()],

  // Vite options tailored for Tauri development and only applied in `tauri dev` or `tauri build`
  //
  // 1. prevent vite from obscuring rust errors
  clearScreen: false,
  // 2. tauri expects a fixed port, fail if that port is not available
  server: {
    port: 1420,
    strictPort: true,
  },
  build: {
    rollupOptions: {
      output: {
        manualChunks(id) {
          if (!id.includes("node_modules")) {
            return;
          }

          if (id.includes("ace-builds") || id.includes("react-ace")) {
            return "editor";
          }

          if (id.includes("@mantine")) {
            return "mantine";
          }

          if (id.includes("i18next") || id.includes("react-i18next")) {
            return "i18n";
          }

          if (id.includes("react-icons")) {
            return "icons";
          }

          if (id.includes("react") || id.includes("react-dom") || id.includes("react-router")) {
            return "react";
          }
        },
      },
    },
  }
}));
