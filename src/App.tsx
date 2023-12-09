import { AppShell, NavLink } from "@mantine/core";
import { useDisclosure } from "@mantine/hooks";
import { useTranslation } from "react-i18next";
import { createContext, useContext, useState } from "react";
import { TbSettings, TbChevronRight, TbFile } from "react-icons/tb";

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

function NavbarArea({ navLabel, setNavLabel }: { navLabel: string; setNavLabel: (arg0: string) => void }) {
  const { t } = useTranslation();

  const items = navLinksData.map((item) => (
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

function MainContextArea({ navLabel, project }: { navLabel: string; project: ProjectInfo | null }) {
  if (navLabel === "nav.project") {
    return <ProjectPage project={project} />;
  } else if (navLabel === "nav.settings") {
    return <SettingsPage />;
  }
  return <></>;
}

function App() {
  const [opened, { toggle }] = useDisclosure(false);

  const [project, setProject] = useState<ProjectInfo | null>(null);
  useContext(ProjectContext);

  const [navLabel, setNavLabel] = useState<string>("nav.project");

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
          <NavbarArea navLabel={navLabel} setNavLabel={setNavLabel} />
        </AppShell.Navbar>

        <AppShell.Main>
          <ProjectContext.Provider value={{ project, setProject }}>
            <MainContextArea navLabel={navLabel} project={project} />
          </ProjectContext.Provider>
        </AppShell.Main>
      </AppShell>
    </div>
  );
}

export default App;
export { ProjectContext };
