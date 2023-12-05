export interface ProjectInfo {
  name: string;
  path: string;
  file_lists: [string];
}

export interface ProjectProps {
  project: ProjectInfo | null;
}
