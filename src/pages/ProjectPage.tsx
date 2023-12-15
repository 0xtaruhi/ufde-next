import { Button, Card, Title } from "@mantine/core";
import { invoke } from "@tauri-apps/api";

import StartUpPage from "./StartupPage";
import showProgramFailedNotification from "./Notifies";
import { useTranslation } from "react-i18next";
import { useContext } from "react";
import { ProjectContext } from "../App";
import { Command } from "@tauri-apps/api/shell";

function ProjectPage() {
  const { t } = useTranslation();
  const { project } = useContext(ProjectContext);

  if (project !== null) {
    return (
      <>
        <Card withBorder radius="md" p="md">
          <Title>{project.name}</Title>
        </Card>
        <Button
          variant="subtle"
          onClick={() => {
            invoke("program_fpga", { bitfile: "123" }).catch((err) => {
              showProgramFailedNotification({ translation: t, message: "program.error." + err });
            });
          }}
        >
          {t("program.program")}
        </Button>
        <Button
          variant="subtle"
          onClick={() => {
            const mapCommand = Command.sidecar("binaries/fde-cli/map");
            mapCommand.execute().then((res) => {
              console.log(res);
            });
          }}
        >
          test command
        </Button>
      </>
    );
  } else {
    return <StartUpPage />;
  }
}

export default ProjectPage;
