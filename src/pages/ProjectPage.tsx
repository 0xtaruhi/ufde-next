import { Button, Card, Stack, Title, Text } from "@mantine/core";
import { invoke } from "@tauri-apps/api";

import StartUpPage from "./StartupPage";
import showProgramFailedNotification, { showSuccessNotification } from "./Notifies";
import { useTranslation } from "react-i18next";
import { useContext } from "react";
import { ProjectContext } from "../App";
import { Command } from "@tauri-apps/api/shell";
import "./ProjectPage.css";

function ProjectPage() {
  const { t } = useTranslation();
  const { project } = useContext(ProjectContext);

  if (project !== null) {
    return (
      <Stack gap="sm">
        <Title className="sectionTitle">{t("project.basic_info")}</Title>
        <Card withBorder radius="md" p="md">
          <Stack gap="sm">
            <div>
              <Text className="projInfoField">{t("project.project_name")}</Text>
              <div>{project.name}</div>
            </div>
            <div>
              <Text className="projInfoField">{t("project.project_path")}</Text>
              <div>{project.path}</div>
            </div>
          </Stack>
        </Card>
        <Button
          variant="subtle"
          onClick={() => {
            invoke("program_fpga", { bitfile: "/Users/taruhi/Desktop/Dino/Dino_fde_yosys.bit" }).then(
              () => {
                showSuccessNotification({ translation: t, title: "program.success", message: "" });
              },
              (err) => {
                showProgramFailedNotification({ translation: t, message: "program.error." + err });
              }
            );
          }}
        >
          {t("program.program")}
        </Button>
        <Button
          variant="subtle"
          onClick={() => {
            const mapCommand = Command.sidecar("binaries/fde-cli/import", ["--help"]);
            mapCommand.stdout.on("data", (data) => {
              console.log(data);
            });
            mapCommand.execute();
          }}
        >
          test command
        </Button>
      </Stack>
    );
  } else {
    return <StartUpPage />;
  }
}

export default ProjectPage;
