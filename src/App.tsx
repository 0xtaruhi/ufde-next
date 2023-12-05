import {
  AppShell,
  Flex,
  Burger,
  ActionIcon,
  NavLink,
  Menu,
  Button,
  useMantineColorScheme,
  useComputedColorScheme,
} from "@mantine/core";
import { useDisclosure } from "@mantine/hooks";
import { useTranslation } from "react-i18next";
import { useState } from "react";
import { TbSettings, TbChevronRight, TbFile, TbSun, TbMoon } from "react-icons/tb";

import { ProjectInfo } from "./model/project";

import SettingsPage from "./pages/SettingsPage";
import ProjectPage from "./pages/ProjectPage";

interface NavLinkData {
  label: string;
  icon?: React.ElementType;
  rightSection?: React.ElementType;
  description?: string;
}

const navLinksData: NavLinkData[] = [
  {
    label: "nav.project",
    icon: TbFile,
    rightSection: TbChevronRight,
    description: "",
  },
  { label: "nav.settings", icon: TbSettings, rightSection: TbChevronRight },
];

interface ContentAreaProps {
  currentNavIndex: number;
  project: ProjectInfo | null;
}

function ContentArea(props: ContentAreaProps) {
  switch (props.currentNavIndex) {
    case 0:
      return <ProjectPage project={props.project} />;
    case 1:
      return <SettingsPage />;
    default:
      return <></>;
  }
}

function NavbarArea({ setCurrentNavIndex }: { setCurrentNavIndex: (index: number) => void }) {
  const { t } = useTranslation();
  const [active, setActive] = useState(0);

  const items = navLinksData.map((item, index) => (
    <NavLink
      active={active === index}
      label={t(item.label)}
      key={item.label}
      leftSection={item.icon && <item.icon size={15} />}
      rightSection={item.rightSection && <item.rightSection size={15} />}
      description={item.description}
      onClick={() => {
        setActive(index);
        setCurrentNavIndex(index);
      }}
    />
  ));

  return <>{items}</>;
}

function MenuArea() {
  const { t } = useTranslation();

  return (
    <>
      <Menu>
        <Menu.Target>
          <Button variant="transparent">
            <TbFile size={18} /> {t("menu.file")}
          </Button>
        </Menu.Target>
        <Menu.Dropdown>
          <Menu.Label>{t("menu.project")}</Menu.Label>
          <Menu.Item>{t("menu.new_project")}</Menu.Item>
        </Menu.Dropdown>
      </Menu>
    </>
  );
}

function App() {
  const [opened, { toggle }] = useDisclosure(true);
  const [currentNavIndex, setCurrentNavIndex] = useState(0);

  // color scheme
  const { setColorScheme } = useMantineColorScheme();
  const computedColorScheme = useComputedColorScheme("light");
  const toggleColorScheme = () => {
    setColorScheme(computedColorScheme === "dark" ? "light" : "dark");
  };

  return (
    <div className="App">
      <AppShell
        header={{ height: 50 }}
        navbar={{
          width: 180,
          breakpoint: "sm",
          collapsed: { desktop: !opened },
        }}
        padding="md"
      >
        <AppShell.Header>
          <Flex justify="space-between" align="center" style={{ padding: "10px 20px" }}>
            <Burger opened={opened} onClick={toggle} visibleFrom="sm" size="sm" />
            <MenuArea />
            {/* light/dark mode toggle button */}
            <ActionIcon size="md" variant="subtle" onClick={toggleColorScheme}>
              {computedColorScheme === "dark" ? <TbSun /> : <TbMoon />}
            </ActionIcon>
          </Flex>
        </AppShell.Header>

        <AppShell.Navbar p="md">
          <NavbarArea setCurrentNavIndex={setCurrentNavIndex} />
        </AppShell.Navbar>

        <AppShell.Main>
          <ContentArea currentNavIndex={currentNavIndex} project={null} />
        </AppShell.Main>
      </AppShell>
    </div>
  );
}

export default App;
