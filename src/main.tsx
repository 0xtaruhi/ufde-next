import React from "react";
import ReactDOM from "react-dom/client";
import { createTheme, MantineProvider } from "@mantine/core";
import { Notifications } from "@mantine/notifications";
import { ModalsProvider } from '@mantine/modals';

import "@mantine/core/styles.css";
import "@mantine/notifications/styles.css";

import "./i18n";
import App from "./App";
import "./App.css";

const theme = createTheme({
  primaryColor: "indigo",
})

ReactDOM.createRoot(document.getElementById("root") as HTMLElement).render(
  <React.StrictMode>
    <MantineProvider theme={theme}>
      <ModalsProvider>
        <Notifications />
        <App />
      </ModalsProvider>
    </MantineProvider>
  </React.StrictMode>
);
