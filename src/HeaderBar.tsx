import { useMantineColorScheme, useComputedColorScheme, Flex } from "@mantine/core";
import { TbSun, TbMoon, TbFile } from "react-icons/tb";
import { ActionIcon } from "@mantine/core";
import { useTranslation } from "react-i18next";
import { Group, Menu, Button, Burger } from "@mantine/core";
import { VscClose, VscFolderOpened, VscNewFile, VscSave, VscSaveAs } from "react-icons/vsc";
import { useContext } from "react";
import { ProjectContext } from "./App";
import { openProject } from "./model/project";
import { showFailedNotification, showWarningNotification } from "./pages/Notifies";
import { useDisclosure } from "@mantine/hooks";
import NewProjectModal from "./pages/NewProjectModal";

function LightDarkToggleButton() {
  const { setColorScheme } = useMantineColorScheme();
  const computedColorScheme = useComputedColorScheme("light");
  const toggleColorScheme = () => {
    setColorScheme(computedColorScheme === "dark" ? "light" : "dark");
  };

  return (
    <ActionIcon size="md" variant="subtle" onClick={toggleColorScheme} style={{ marginLeft: "auto" }}>
      {computedColorScheme === "dark" ? <TbSun /> : <TbMoon />}
    </ActionIcon>
  );
}

function MenuArea() {
  const { t } = useTranslation();
  const { project, setProject, setNavLabel } = useContext(ProjectContext);

  const [opened, { open, close }] = useDisclosure();

  const menuItems = [
    {
      icon: <VscNewFile />,
      label: "menu.new_project",
      onClick: open,
    },
    {
      icon: <VscFolderOpened />,
      label: "menu.open_project",
      onClick: () => {
        openProject().then(
          (p) => {
            if (p) {
              setProject(p);
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
      },
    },
    {
      icon: <VscSave />,
      label: "menu.save_project",
      onClick: () => {},
    },
    {
      icon: <VscSaveAs />,
      label: "menu.save_project_as",
      onClick: () => {},
    },
    {
      icon: <VscClose />,
      label: "menu.close_project",
      onClick: () => {
        if (project === null) {
          showWarningNotification({
            message: t("project.close_project_no_project_content"),
            title: t("project.close_project_no_project_title"),
          });
        } else {
          setProject(null);
          setNavLabel("nav.project");
        }
      },
    },
  ];

  return (
    <>
      <Group>
        <Menu>
          <Menu.Target>
            <Button variant="subtle">
              <TbFile size={18} /> {t("menu.file")}
            </Button>
          </Menu.Target>
          <Menu.Dropdown>
            <Menu.Label>{t("menu.project")}</Menu.Label>
            {menuItems.map((item) => (
              <Menu.Item key={item.label} leftSection={item.icon} onClick={item.onClick}>
                {" "}
                {t(item.label)}
              </Menu.Item>
            ))}
          </Menu.Dropdown>
        </Menu>
      </Group>
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

function HeaderBar({ opened, toggle }: { opened: boolean; toggle: () => void }) {
  return (
    <Flex justify="flex-start" gap="md" align="center" style={{ padding: "10px 20px" }}>
      <Burger opened={opened} onClick={toggle} visibleFrom="sm" size="sm" />
      <MenuArea />
      <LightDarkToggleButton />
    </Flex>
  );
}

export default HeaderBar;
