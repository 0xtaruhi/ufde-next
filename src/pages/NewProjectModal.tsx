import { useTranslation } from "react-i18next";
import { useState, createContext, useContext } from "react";
import {
  Button,
  Group,
  Modal,
  ModalProps,
  Stepper,
  ActionIcon,
  Flex,
  Checkbox,
  ScrollArea,
  InputWrapper,
} from "@mantine/core";
import { Input, Stack, Text, Table } from "@mantine/core";
import { TbBrowser, TbFileImport } from "react-icons/tb";
import { open } from "@tauri-apps/api/dialog";

import "./NewProjectModal.css";
import { t } from "i18next";
import { ProjectInfo } from "../model/project";

const NewProjectContext = createContext<{
  project: ProjectInfo;
  setProject: (_: ProjectInfo) => void;
}>({
  project: {
    name: "",
    path: "",
    file_lists: [],
    target_device: "FDP3P7",
  },
  setProject: () => {},
});

async function getSelectedDirectory() {
  const result = open({
    multiple: false,
    directory: true,
  });
  return result;
}

interface PrevAndNextButtonProps {
  totalSteps: number;
  currentStep: number;
  onPrevClick?: () => void;
  onNextClick?: () => void;
}

interface StepProps {
  totalSteps: number;
  currentStep: number;
  onPrevClick?: () => void;
  onNextClick?: () => void;
}

interface StepContent {
  label: string;
  description: string;
  content?: (props: StepProps) => JSX.Element;
}

function PrevAndNextButton(props: PrevAndNextButtonProps) {
  const { totalSteps, currentStep, onPrevClick, onNextClick } = props;

  return (
    <Group justify="center" mt="xl">
      <Button disabled={currentStep === 0} variant="default" onClick={onPrevClick}>
        {t("common.back")}
      </Button>
      <Button disabled={false} onClick={onNextClick}>
        {currentStep === totalSteps ? t("common.finish") : t("common.next")}
      </Button>
    </Group>
  );
}

function NewProjectStep1(props: StepProps) {
  const { t } = useTranslation();

  const [projectPath, setProjectPath] = useState("");
  const [projectName, setProjectName] = useState("");

  const { project, setProject } = useContext(NewProjectContext);

  const onPathBrowseClick = async () => {
    const dir = await getSelectedDirectory();
    if (dir) {
      setProjectPath(dir as string);
      checkProjectPathValid(dir as string);
    }
  };

  const [createSubDir, setCreateSubDir] = useState(true);
  const [projectNameErr, setProjectNameErr] = useState("");
  const [projectPathErr, setProjectPathErr] = useState("");

  const checkProjectNameValid = (name: string) => {
    if (name === "") {
      setProjectNameErr(t("create_project.empty_project_name_error"));
      return false;
    } else if (name.match('[$-/:-?{-~!"^_`\\\\\\[\\]]') !== null) {
      setProjectNameErr(t("create_project.invalid_project_name_error"));
      return false;
    } else {
      setProjectNameErr("");
    }
    return true;
  };

  const checkProjectPathValid = (path: string) => {
    if (path === "") {
      setProjectPathErr(t("create_project.empty_project_path_error"));
      return false;
    } else {
      setProjectPathErr("");
    }
    return true;
  };

  const handleNextClick = () => {
    const nameValid = checkProjectNameValid(projectName);
    const pathValid = checkProjectPathValid(projectPath);
    if (!(nameValid && pathValid)) {
      return;
    }
    setProject?.({
      name: projectName,
      path: projectPath,
      file_lists: project?.file_lists || [],
      target_device: project?.target_device || "FDP3P7",
    });
    console.log(project);
    props.onNextClick?.();
  };

  return (
    <Stack gap="sm" style={{ marginBottom: 20 }}>
      <Input.Wrapper label={t("create_project.project_name")} error={projectNameErr} withAsterisk>
        <Input
          placeholder={t("create_project.project_name_placeholder")}
          onChange={(event) => {
            const name = event.currentTarget.value;
            if (checkProjectNameValid(name)) {
              setProjectName(name);
            }
          }}
          error={projectNameErr}
        />
      </Input.Wrapper>
      <Input.Wrapper label={t("create_project.project_path")} error={projectPathErr} withAsterisk>
        <Flex align="center">
          <Input
            className="inputBox"
            value={projectPath}
            error={projectPathErr}
            placeholder={t("create_project.project_path_placeholder")}
            readOnly={true}
            onChange={(event) => {
              const path = event.currentTarget.value;
              if (checkProjectPathValid(path)) {
                setProjectPath(path);
              }
            }}
          />
          <ActionIcon variant="subtle" size="lg" onClick={onPathBrowseClick}>
            <TbBrowser />
          </ActionIcon>
        </Flex>
      </Input.Wrapper>
      <Checkbox
        checked={createSubDir}
        label={t("create_project.create_sub_dir")}
        onChange={(event) => setCreateSubDir(event.currentTarget.checked)}
      />
      <PrevAndNextButton {...props} onNextClick={handleNextClick} />
    </Stack>
  );
}

interface FileItem {
  name: string;
  path: string;
  type: "verilog" | "vhdl" | "systemverilog" | "unknown";
}

const files: FileItem[] = [
  { name: "test.v", path: "/home/abc/test.v", type: "verilog" },
  { name: "test.vhd", path: "/home/abc/test.vhd", type: "vhdl" },
  { name: "test.sv", path: "/home/abc/test.sv", type: "systemverilog" },
];

function NewProjectStep2(props: StepProps) {
  const { t } = useTranslation();

  const onImportFilesClick = async () => {
    const result = await open({
      multiple: true,
    });
    console.log(result);
  };

  const rows = files.map((file) => (
    <Table.Tr key={file.path}>
      <Table.Td>{file.name}</Table.Td>
      <Table.Td>{file.path}</Table.Td>
      <Table.Td>{file.type}</Table.Td>
    </Table.Tr>
  ));

  return (
    <Stack gap="sm" style={{ marginBottom: 20 }}>
      <Text size="sm" fw={700}>
        {t("create_project.source_files")}
      </Text>
      <ScrollArea h={150}>
        <Table.ScrollContainer minWidth={300}>
          <Table striped highlightOnHover withTableBorder withColumnBorders>
            <Table.Thead>
              <Table.Tr>
                <Table.Th>{t("create_project.file_name")}</Table.Th>
                <Table.Th>{t("create_project.file_path")}</Table.Th>
                <Table.Th>{t("create_project.file_type")}</Table.Th>
              </Table.Tr>
            </Table.Thead>
            <Table.Tbody>{rows}</Table.Tbody>
          </Table>
        </Table.ScrollContainer>
      </ScrollArea>
      <Button
        variant="subtle"
        color="blue"
        onClick={onImportFilesClick}
        leftSection={<TbFileImport />}
        style={{ marginLeft: "auto" }}
      >
        {t("create_project.import_files")}
      </Button>
      <PrevAndNextButton {...props} />
    </Stack>
  );
}

function NewProjectStep3(props: StepProps) {
  return (
    <Stack gap="sm" style={{ marginBottom: 20 }}>
      <InputWrapper label={t("create_project.target_device")} withAsterisk>
        <Input readOnly={true} value="FDP3P7"></Input>
      </InputWrapper>
      <PrevAndNextButton {...props} />
    </Stack>
  );
}

const steps: StepContent[] = [
  { label: "common.first_step", description: "create_project.basic_info", content: NewProjectStep1 },
  { label: "common.second_step", description: "create_project.import_files", content: NewProjectStep2 },
  { label: "common.third_step", description: "create_project.target_device", content: NewProjectStep3 },
];

function NewProjectModal(props: ModalProps) {
  const { t } = useTranslation();

  const [active, setActive] = useState(0);
  const nextStep = () => setActive((current) => (current < 3 ? current + 1 : current));
  // const nextStep = () => {};
  const prevStep = () => setActive((current) => (current > 0 ? current - 1 : current));

  const [project, setProject] = useState<ProjectInfo>({
    name: "",
    path: "",
    file_lists: [],
    target_device: "FDP3P7",
  });

  return (
    <Modal {...props} title={t("project.new_project")}>
      <Modal.Body>
        <NewProjectContext.Provider value={{ project, setProject }}>
          <Stepper active={active} onStepClick={setActive} allowNextStepsSelect={false}>
            {steps.map((step, index) => (
              <Stepper.Step key={step.label} label={t(step.label)} description={t(step.description)}>
                {step.content
                  ? step.content({
                      currentStep: index,
                      totalSteps: steps.length,
                      onPrevClick: prevStep,
                      onNextClick: nextStep,
                    })
                  : null}
              </Stepper.Step>
            ))}
            <Stepper.Completed>
              {t("create_project.finish_hint")}
              <PrevAndNextButton
                currentStep={steps.length}
                totalSteps={steps.length}
                onPrevClick={prevStep}
                onNextClick={nextStep}
              />
            </Stepper.Completed>
          </Stepper>
        </NewProjectContext.Provider>
      </Modal.Body>
    </Modal>
  );
}

export default NewProjectModal;
