import { useTranslation } from "react-i18next";
import { Center, Title, Button, Group } from "@mantine/core";

import { ProjectProps } from "../model/project";

function emptyProjectPage() {
  const { t } = useTranslation();
  return (
    <>
      <Center h={500} style={{ textAlign: "center" }}>
        <Group align="center" >
          <Title order={1}>{t("project.create_a_new_project")}</Title>
          <Button variant="outline" color="blue" size="md">
            {t("project.new_project")}
          </Button>
        </Group>
      </Center>
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
