import { useTranslation } from "react-i18next";
import { Center, Title, Button, Group } from "@mantine/core";

import { ProjectProps } from "../model/project";
import { useDisclosure } from "@mantine/hooks";

import NewProjectModal from "../modal/NewProjectModal";

function emptyProjectPage() {
  const { t } = useTranslation();
  const [opened, { open, close }] = useDisclosure();

  return (
    <>
      <Center h={500} style={{ textAlign: "center" }}>
        <Group align="center">
          <Title order={1}>{t("project.create_a_new_project")}</Title>
          <Button variant="outline" color="blue" size="md" onClick={open}>
            {t("project.new_project")}
          </Button>
        </Group>
      </Center>
      <NewProjectModal
        opened={opened}
        onClose={close}
        size="lg"
        overlayProps={{ backgroundOpacity: 0.55, blur: 3 }}
        transitionProps={{ transition: "rotate-left", duration: 300 }}
      />
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
