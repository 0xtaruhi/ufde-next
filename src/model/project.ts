import { open } from "@tauri-apps/plugin-dialog";
import { readTextFile } from "@tauri-apps/plugin-fs";

export type SourceFile = {
  name: string;
  path: string;
  type: "verilog" | "systemverilog" | "constraint" | "unknown";
};

export type ProjectSettings = {
  route: {
    mode: "Direct Search" | "Breath First" | "Timing Driven";
  };
  place: {
    mode: "Timing Driven" | "Bounding Box";
  }
}

export type ProjectInfo = {
  name: string;
  path: string;
  file_lists: SourceFile[];
  target_device: "FDP3P7";
  settings: ProjectSettings;
};

export type RecentlyOpenedProjectsType = {
  name: string;
  path: string;
};


const maxRecentlyOpenedProjects = 7;

export function updateRecentlyOpenedProjects(
  project: ProjectInfo,
  recentlyOpenedProjects: RecentlyOpenedProjectsType[],
  setRecentlyOpenedProjects: (projects: RecentlyOpenedProjectsType[]) => void
) {
  // if the project is already in the list, don't add it again
  if (recentlyOpenedProjects.find((p) => p.path === project.path)) {
    return;
  }

  const newProject: RecentlyOpenedProjectsType = {
    name: project.name,
    path: project.path,
  };

  let updatedResult = [];

  if (recentlyOpenedProjects.length >= maxRecentlyOpenedProjects) {
    updatedResult = [newProject, ...recentlyOpenedProjects.slice(0, maxRecentlyOpenedProjects - 1)];
  } else {
    updatedResult = [newProject, ...recentlyOpenedProjects];
  }
  setRecentlyOpenedProjects(updatedResult);

  localStorage.setItem("recentlyOpenedProjects", JSON.stringify(updatedResult));
}

export async function openProject(
  { recentlyOpenedProjects, setRecentlyOpenedProjects }: { recentlyOpenedProjects: RecentlyOpenedProjectsType[], setRecentlyOpenedProjects: (projects: RecentlyOpenedProjectsType[]) => void }
) {
  const validPath = await open({
    multiple: false,
    filters: [
      {
        name: "Project",
        extensions: ["json"],
      },
    ],
  }) as string;

  if (validPath) {
    const content = await readTextFile(validPath);
    const openedProject = JSON.parse(content) as ProjectInfo;
    openedProject.path = validPath;
    updateRecentlyOpenedProjects(openedProject, recentlyOpenedProjects, setRecentlyOpenedProjects);
    return openedProject;
  }
  return null;
}

export async function openProjectWithSpecificPath(
  path: string,
  { recentlyOpenedProjects, setRecentlyOpenedProjects }: { recentlyOpenedProjects: RecentlyOpenedProjectsType[], setRecentlyOpenedProjects: (projects: RecentlyOpenedProjectsType[]) => void }
) {
  const content = await readTextFile(path);
  const openedProject = JSON.parse(content) as ProjectInfo;
  openedProject.path = path;
  updateRecentlyOpenedProjects(openedProject, recentlyOpenedProjects, setRecentlyOpenedProjects);
  return openedProject;
}
