import { BaseDirectory, writeTextFile } from "@tauri-apps/api/fs";

type SourceFile = {
  name: string;
  path: string;
  type: "verilog" | "systemverilog" | "constraint" | "other";
};

export type ProjectInfo = {
  name: string;
  path: string;
  file_lists: SourceFile[];
  target_device: "FDP3P7";
};

type recentlyOpenedProjectsType = {
  name: string;
  path: string;
};

const recentlyOpenedProjects: recentlyOpenedProjectsType[] = [];

export function getRecentlyOpenedProjects(): recentlyOpenedProjectsType[] {
  return recentlyOpenedProjects;
}

export function addRecentlyOpenedProject(project: ProjectInfo) {
  const index = recentlyOpenedProjects.findIndex((p) => p.path === project.path);
  if (index !== -1) {
    recentlyOpenedProjects.splice(index, 1);
  }
  recentlyOpenedProjects.unshift({ name: project.name, path: project.path });
  saveRecentlyOpenedProjects();
}

export function saveRecentlyOpenedProjects() {
  console.log(BaseDirectory.AppData);
  writeTextFile("recent_projects.json", JSON.stringify(recentlyOpenedProjects), { dir: BaseDirectory.AppData });
}
