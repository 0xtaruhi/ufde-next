import { Button } from "@mantine/core";
import { invoke } from "@tauri-apps/api";

import { ProjectProps } from "../model/project";
import StartUpPage from "./StartupPage";
import showProgramFailedNotification from "./Notifies";
import { useTranslation } from "react-i18next";

function ProjectPage(props: ProjectProps) {
  const { t } = useTranslation();
  if (props.project !== null) {
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
