import {
  Button,
  Container,
  Title,
  Text,
  Image,
  useComputedColorScheme,
  List,
  ThemeIcon,
  Group,
} from "@mantine/core";
import { useDisclosure } from "@mantine/hooks";
import { useTranslation } from "react-i18next";
import { TbCheck } from "react-icons/tb";
import { VscNewFile, VscFolderOpened } from "react-icons/vsc";

import "./StartupPage.css";
import light_image from "../assets/startup.svg";
import dark_image from "../assets/startup-dark.svg";
import NewProjectModal from "./NewProjectModal";
import { openProject } from "../model/project";
import { useContext } from "react";
import { ProjectContext } from "../App";
import { showFailedNotification } from "./Notifies";

function StartUpPage() {
  const { t } = useTranslation();
  const computedColorScheme = useComputedColorScheme("light");

  const [opened, { open, close }] = useDisclosure();
  const { setProject } = useContext(ProjectContext);

  return (
    <>
      <Container size="lg">
        <div className="inner">
          <div className="content">
            <Title className="title">
              {t("startup.welcome_head")}{" "}
              <Text component="span" variant="gradient" gradient={{ from: "blue", to: "cyan" }} inherit>
                UFDE+
              </Text>{" "}
              {t("startup.welcome_tail")}
            </Title>
            <Text c="dimmed" mt="md">
              {t("startup.intro")}
            </Text>

            <List
              mt={30}
              spacing="sm"
              size="sm"
              icon={
                <ThemeIcon size={20} radius="xl">
                  <TbCheck />
                </ThemeIcon>
              }
            >
              <List.Item>
                <b>{t("startup.tag1.title")}</b> - {t("startup.tag1.content")}
              </List.Item>
              <List.Item>
                <b>{t("startup.tag2.title")}</b> - {t("startup.tag2.content")}
              </List.Item>
            </List>
            <div style={{ paddingTop: 20 }}>
              <Group gap={10}>
                <Button variant="filled" size="md" onClick={open} leftSection={<VscNewFile />}>
                  {t("project.new_project")}
                </Button>
                <Button
                  size="md"
                  variant="outline"
                  leftSection={<VscFolderOpened />}
                  onClick={() => {
                    openProject().then(
                      (p) => {
                        if (p) {
                          setProject(p);
                        }
                      },
                      (err) => {
                        console.error(err);
                        showFailedNotification({
                          translation: t,
                          message: err,
                          title: t("project.open_project_failed_title"),
                        });
                      }
                    );
                  }}
                >
                  {t("project.open_project")}
                </Button>
              </Group>
            </div>
          </div>
          {computedColorScheme === "dark" ? (
            <Image src={dark_image} alt="Startup" className="image" />
          ) : (
            <Image src={light_image} alt="Startup" className="image" />
          )}
        </div>
      </Container>
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

export default StartUpPage;
