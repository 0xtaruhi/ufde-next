import { Button } from "@mantine/core";
import { invoke } from "@tauri-apps/api";

import StartUpPage from "./StartupPage";
import showProgramFailedNotification from "./Notifies";
import { useTranslation } from "react-i18next";
import { useContext } from "react";
import { ProjectContext } from "../App";

function ProjectPage() {
  const { t } = useTranslation();
  const { project } = useContext(ProjectContext);

  if (project !== null) {
    return (
      <>
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
      </>
    );
  } else {
    return <StartUpPage />;
  }
}

export default ProjectPage;
