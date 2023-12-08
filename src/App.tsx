import { AppShell, NavLink } from "@mantine/core";
import { useDisclosure } from "@mantine/hooks";
import { useTranslation } from "react-i18next";
import { createContext, useContext, useState } from "react";
import { TbSettings, TbChevronRight, TbFile } from "react-icons/tb";
import { Route, Routes, Link } from "react-router-dom";

import { ProjectInfo } from "./model/project";

import SettingsPage from "./pages/SettingsPage";
import ProjectPage from "./pages/ProjectPage";
import HeaderBar from "./HeaderBar";

const ProjectContext = createContext<{
  project: ProjectInfo | null;
  setProject: (_: ProjectInfo | null) => void;
}>({ project: null, setProject: (_: ProjectInfo | null) => {} });

interface NavLinkData {
  label: string;
  icon?: React.ElementType;
  rightSection?: React.ElementType;
  description?: string;
  link: string;
}

const navLinksData: NavLinkData[] = [
  {
    label: "nav.project",
    icon: TbFile,
    rightSection: TbChevronRight,
    description: "",
    link: "/",
  },
  { label: "nav.settings", icon: TbSettings, rightSection: TbChevronRight, link: "/settings" },
];

function NavbarArea() {
  const { t } = useTranslation();
  const [active, setActive] = useState(0);

  const items = navLinksData.map((item, index) => (
    <Link to={item.link} key={item.label} style={{ textDecoration: "none", color: "inherit" }}>
      <NavLink
        active={active === index}
        label={t(item.label)}
        leftSection={item.icon && <item.icon size={15} />}
        rightSection={item.rightSection && <item.rightSection size={15} />}
        description={item.description}
        onClick={() => {
          setActive(index);
        }}
      />
    </Link>
  ));

  return <>{items}</>;
}

function App() {
  const [opened, { toggle }] = useDisclosure(false);

  const [project, setProject] = useState<ProjectInfo | null>(null);
  useContext(ProjectContext);

  return (
    <div className="App">
      <AppShell
        header={{ height: 50 }}
        navbar={{
          width: 200,
          breakpoint: "sm",
          collapsed: { desktop: !opened },
        }}
        padding="md"
      >
        <AppShell.Header>
          <HeaderBar opened={opened} toggle={toggle} />
        </AppShell.Header>

        <AppShell.Navbar p="md">
          <NavbarArea />
        </AppShell.Navbar>

        <AppShell.Main>
          <ProjectContext.Provider value={{ project, setProject }}>
            <Routes>
              <Route path="/" Component={() => ProjectPage({ project })} />
              <Route path="/settings" Component={SettingsPage} />
            </Routes>
          </ProjectContext.Provider>
        </AppShell.Main>
      </AppShell>
    </div>
  );
}

export default App;
export { ProjectContext };
