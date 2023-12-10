import { useMantineColorScheme, useComputedColorScheme, Flex } from "@mantine/core";
import { TbSun, TbMoon, TbFile } from "react-icons/tb";
import { ActionIcon } from "@mantine/core";
import { useTranslation } from "react-i18next";
import { Group, Menu, Button, Burger } from "@mantine/core";
import { VscClose, VscFolderOpened, VscNewFile, VscSave, VscSaveAs } from "react-icons/vsc";

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

const menuItems = [
  {
    icon: <VscNewFile />,
    label: "menu.new_project",
    onClick: () => {},
  },
  {
    icon: <VscFolderOpened />,
    label: "menu.open_project",
    onClick: () => {},
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
    onClick: () => {},
  }
];

function MenuArea() {
  const { t } = useTranslation();

  return (
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
