export interface ProjectInfo {
  name: string;
  path: string;
  file_lists: string[] | undefined;
  target_device: "FDP3P7" | undefined;
}

export interface ProjectProps {
  project: ProjectInfo | null;
}
