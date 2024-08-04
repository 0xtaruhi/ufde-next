import { AppShell, NavLink } from "@mantine/core";
import { useDisclosure } from "@mantine/hooks";
import { useTranslation } from "react-i18next";
import { createContext, useState, useContext } from "react";
import { TbSettings, TbChevronRight, TbFile, TbActivity } from "react-icons/tb";

import { ProjectInfo, RecentlyOpenedProjectsType } from "./model/project";

import SettingsPage from "./pages/SettingsPage";
import ProjectPage from "./pages/ProjectPage";
import HeaderBar from "./HeaderBar";
import FlowPage from "./pages/FlowPage";
import { useEffect } from "react";
import { appWindow } from "@tauri-apps/api/window";
import { modals } from "@mantine/modals";
import { writeTextFile } from "@tauri-apps/api/fs";

const ProjectContext = createContext<{
  project: ProjectInfo | null;
  setProject: (project: ProjectInfo | null) => void;
  recentlyOpenedProjects: RecentlyOpenedProjectsType[];
  setRecentlyOpenedProjects: (projects: RecentlyOpenedProjectsType[]) => void;
  setNavLabel: (navLabel: string) => void;
  projectModified: boolean;
  setProjectModified: (modified: boolean) => void;
}>({
  project: null,
  setProject: () => {},
  setNavLabel: () => {},
  recentlyOpenedProjects: [],
  setRecentlyOpenedProjects: () => {},
  projectModified: false,
  setProjectModified: () => {},
});

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

  const items = navLinksData.map((item) =>
    project === null && item.label === "nav.flow" ? null : (
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
        style={{ transition: "200ms" }}
      />
    )
  );

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
  const [recentlyOpenedProjects, setRecentlyOpenedProjects] = useState<RecentlyOpenedProjectsType[]>([]);

  const [projectModified, setProjectModified] = useState<boolean>(false);

  useEffect(() => {
    const projects = localStorage.getItem("recentlyOpenedProjects");
    if (projects) {
      setRecentlyOpenedProjects(JSON.parse(projects));
    }
  }, []);

  useEffect(() => {
    const unlisten = appWindow.onCloseRequested((e) => {
      e.preventDefault();
      if (project != null && projectModified) {
        console.log("Save project before exit");
        modals.openConfirmModal({
          title: "Save Project",
          centered: true,
          children: "Do you want to save the project before exit?",
          labels: { confirm: "Yes", cancel: "No" },
          confirmProps: { color: "red" },
          onConfirm: () => {
            const { path, ...rest } = project;
            writeTextFile(path, JSON.stringify(rest)).then(() => {
              appWindow.close();
            });
          },
          onCancel: () => {
            appWindow.close();
          },
        });
      } else {
        appWindow.close();
      }
    });

    return () => {
      unlisten.then((fn) => fn());
    };
  }, [project, projectModified]);

  useEffect(() => {
    if (project) {
      appWindow.setTitle("UFDE+ - " + project.name + (projectModified ? "*" : ""));
    } else {
      appWindow.setTitle("UFDE+");
    }
  }, [project, projectModified]);

  return (
    <div className="App">
      <ProjectContext.Provider
        value={{
          project,
          setProject,
          setNavLabel,
          recentlyOpenedProjects,
          setRecentlyOpenedProjects,
          projectModified,
          setProjectModified,
        }}
      >
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
