import { useTranslation } from "react-i18next";

import { ProjectProps } from "../model/project";

function emptyProjectPage() {
  const { t } = useTranslation();
  return (
    <>
      {" "}
      <h1>{t("project.create_a_new_project")}</h1>
    </>
  );
}

function ProjectPage(props: ProjectProps) {
  console.log(props.project);
  if (props.project !== null) {
    return <></>;
  } else {
    return emptyProjectPage();
  }
}

export default ProjectPage;
