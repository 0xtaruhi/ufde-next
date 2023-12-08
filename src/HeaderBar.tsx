import { useMantineColorScheme, useComputedColorScheme, Flex } from "@mantine/core";
import { TbSun, TbMoon, TbFile } from "react-icons/tb";
import { ActionIcon } from "@mantine/core";
import { useTranslation } from "react-i18next";
import { Group, Menu, Button, Burger } from "@mantine/core";
import { VscNewFile } from "react-icons/vsc";

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
          <Menu.Item leftSection={<VscNewFile />}>{t("menu.new_project")}</Menu.Item>
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
