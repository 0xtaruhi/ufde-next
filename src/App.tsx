import { AppShell, NavLink } from "@mantine/core";
import { useDisclosure } from "@mantine/hooks";
import { useTranslation } from "react-i18next";
import { createContext, useState, useContext } from "react";
import { TbSettings, TbChevronRight, TbFile, TbActivity } from "react-icons/tb";

import { ProjectInfo } from "./model/project";

import SettingsPage from "./pages/SettingsPage";
import ProjectPage from "./pages/ProjectPage";
import HeaderBar from "./HeaderBar";
import FlowPage from "./pages/FlowPage";

const ProjectContext = createContext<{
  project: ProjectInfo | null;
  setProject: (project: ProjectInfo | null) => void;
}>({ project: null, setProject: () => {} });

type NavLinkData = {
  label: string;
  icon?: React.ElementType;
  rightSection?: React.ElementType;
  description?: string;
};

const navLinksData: NavLinkData[] = [
  {
    label: "nav.project",
    icon: TbFile,
    rightSection: TbChevronRight,
  },
  { label: "nav.flow", icon: TbActivity, rightSection: TbChevronRight },
  { label: "nav.settings", icon: TbSettings, rightSection: TbChevronRight },
];

function NavbarArea({ navLabel, setNavLabel }: { navLabel: string; setNavLabel: (arg0: string) => void }) {
  const { t } = useTranslation();
  const { project } = useContext(ProjectContext);

  const items = navLinksData.map((item) => (
    project === null && item.label === "nav.flow" ? null :
    <NavLink
      active={navLabel === item.label}
      label={t(item.label)}
      key={item.label}
      leftSection={item.icon && <item.icon size={15} />}
      rightSection={item.rightSection && <item.rightSection size={15} />}
      description={item.description}
      onClick={() => {
        setNavLabel(item.label);
      }}
    />
  ));

  return <>{items}</>;
}

function MainContextArea({ navLabel }: { navLabel: string }) {
  if (navLabel === "nav.project") {
    return <ProjectPage />;
  } else if (navLabel === "nav.flow") {
    return <FlowPage />;
  } else if (navLabel === "nav.settings") {
    return <SettingsPage />;
  }
  return <></>;
}

function App() {
  const [opened, { toggle }] = useDisclosure(true);
  const [project, setProject] = useState<ProjectInfo | null>(null);
  const [navLabel, setNavLabel] = useState<string>("nav.project");

  return (
    <div className="App">
      <ProjectContext.Provider value={{ project, setProject }}>
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
            <NavbarArea navLabel={navLabel} setNavLabel={setNavLabel} />
          </AppShell.Navbar>

          <AppShell.Main>
            <MainContextArea navLabel={navLabel} />
          </AppShell.Main>
        </AppShell>
      </ProjectContext.Provider>
    </div>
  );
}

export default App;
export { ProjectContext };
