import React from "react";
import ReactDOM from "react-dom/client";

import "@mantine/core/styles.css";
import "@mantine/notifications/styles.css";

import "./i18n";
import { Flex, MantineProvider } from "@mantine/core";
import { Notifications } from "@mantine/notifications";

import ReactAce from "react-ace/lib/ace";
import "ace-builds/src-noconflict/mode-verilog";
import "ace-builds/src-noconflict/theme-github_dark";
import { appWindow } from "@tauri-apps/api/window";

const unlisten = await appWindow.listen("content", (event) => {
  console.log("111");
  console.log("content received", event.payload);
});
unlisten();

function Editor() {
  return (
    <Flex direction="column" style={{ height: "100vh" }}>
      <ReactAce
        mode="verilog"
        theme="github_dark"
        fontSize={16}
        width="100%"
        height="100%"
        setOptions={{
          enableBasicAutocompletion: true,
          enableLiveAutocompletion: true,
          enableSnippets: true,
          showLineNumbers: true,
          tabSize: 2,
          highlightActiveLine: false,
        }}
      />
    </Flex>
  );
}

ReactDOM.createRoot(document.getElementById("root") as HTMLElement).render(
  <React.StrictMode>
    <MantineProvider>
      <Notifications />
      <Editor />
    </MantineProvider>
  </React.StrictMode>
);
