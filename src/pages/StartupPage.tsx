import {
  Button,
  Title,
  Text,
  Image,
  useComputedColorScheme,
  List,
  ThemeIcon,
  Group,
  Menu,
  Center,
} from "@mantine/core";
import { useDisclosure } from "@mantine/hooks";
import { useTranslation } from "react-i18next";
import { TbCheck } from "react-icons/tb";
import { VscNewFile, VscFolderOpened } from "react-icons/vsc";

import "./StartupPage.css";
import light_image from "../assets/startup.svg";
import dark_image from "../assets/startup-dark.svg";
import NewProjectModal from "./NewProjectModal";
import {
  RecentlyOpenedProjectsType,
  openProject,
  openProjectWithSpecificPath,
} from "../model/project";
import { useContext } from "react";
import { ProjectContext } from "../App";
import { showFailedNotification } from "./Notifies";

function StartUpPage() {
  const { t } = useTranslation();
  const computedColorScheme = useComputedColorScheme("light");

  const [opened, { open, close }] = useDisclosure();
  const {
    setProject,
    recentlyOpenedProjects,
    setRecentlyOpenedProjects,
    setProjectModified,
  } = useContext(ProjectContext);

  const openOtherProject = () => {
    openProject({ recentlyOpenedProjects, setRecentlyOpenedProjects }).then(
      (p) => {
        if (p) {
          setProject(p);
          setProjectModified(false);
        }
      },
      (err) => {
        console.error(err);
        showFailedNotification({
          message: err,
          title: t("project.open_project_failed_title"),
        });
      }
    );
  };

  const openSelectedProject = (project: RecentlyOpenedProjectsType) => {
    // const fileName = project.path + "/" + project.name + ".json";
    openProjectWithSpecificPath(project.path, {
      recentlyOpenedProjects,
      setRecentlyOpenedProjects,
    }).then(
      (p) => {
        if (p) {
          setProject(p);
        }
      },
      (err) => {
        showFailedNotification({
          message: err,
          title: t("project.open_project_failed_title"),
        });
      }
    );
  };

  return (
    <>
      <Center style={{ height: "100vh", padding: "20px" }}>
        <div className="inner">
          <div className="content">
            <Title className="title">
              {t("startup.welcome_head")}{" "}
              <Text
                component="span"
                variant="gradient"
                gradient={{ from: "indigo", to: "cyan" }}
                inherit
              >
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
                <Button
                  variant="filled"
                  size="md"
                  onClick={open}
                  leftSection={<VscNewFile />}
                >
                  {t("project.new_project")}
                </Button>
                <Menu shadow="md" width={300} trigger="hover">
                  <Menu.Target>
                    <Button
                      size="md"
                      variant="outline"
                      leftSection={<VscFolderOpened />}
                      onClick={openOtherProject}
                    >
                      {t("project.open_project")}
                    </Button>
                  </Menu.Target>
                  <Menu.Dropdown>
                    {recentlyOpenedProjects.length !== 0 && (
                      <>
                        <Menu.Label>{t("startup.recent_projects")}</Menu.Label>
                        {recentlyOpenedProjects.map((project) => (
                          <Menu.Item
                            key={project.path}
                            onClick={() => openSelectedProject(project)}
                          >
                            {/* {project.name} */}
                            <Text size="sm">{project.name}</Text>
                            <Text size="xs" c="dimmed">
                              {project.path}
                            </Text>
                          </Menu.Item>
                        ))}
                        <Menu.Divider />
                        <Menu.Item
                          onClick={() => {
                            setRecentlyOpenedProjects([]);
                            localStorage.removeItem("recentlyOpenedProjects");
                          }}
                        >
                          {t("startup.remove_recent_projects")}
                        </Menu.Item>
                      </>
                    )}
                    {recentlyOpenedProjects.length === 0 && (
                      <Menu.Item disabled>
                        <Text size="sm" c="dimmed">
                          {t("startup.no_recent_projects")}
                        </Text>
                      </Menu.Item>
                    )}
                  </Menu.Dropdown>
                </Menu>
              </Group>
            </div>
          </div>
          {computedColorScheme === "dark" ? (
            <Image src={dark_image} alt="Startup" className="image" />
          ) : (
            <Image src={light_image} alt="Startup" className="image" />
          )}
        </div>
      </Center>
      <NewProjectModal
        opened={opened}
        onClose={close}
        size="lg"
        overlayProps={{ backgroundOpacity: 0.55, blur: 3 }}
        transitionProps={{ transition: "pop", duration: 400 }}
      />
    </>
  );
}

export default StartUpPage;
