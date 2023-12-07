import { ProjectProps } from "../model/project";

import StartUpPage from "./StartupPage";

function ProjectPage(props: ProjectProps) {
  console.log(props.project);
  if (props.project !== null) {
    return <></>;
  } else {
    return <StartUpPage />;
  }
}

export default ProjectPage;
