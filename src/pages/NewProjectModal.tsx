import { useTranslation } from "react-i18next";
import { useState, useContext } from "react";
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
import { useForm } from "@mantine/form";

import { Input, Stack, Text, Table } from "@mantine/core";
import { TbBrowser, TbFileImport } from "react-icons/tb";
import { open } from "@tauri-apps/plugin-dialog";

import "./NewProjectModal.css";
import { t } from "i18next";
import { ProjectInfo, SourceFile, updateRecentlyOpenedProjects } from "../model/project";
import { ProjectContext } from "../App";
import { showFailedNotification, showSuccessNotification } from "./Notifies";
import { mkdir, writeTextFile } from "@tauri-apps/plugin-fs";
import isWindowsPlatform, { getFileInfoByPath, getSourceFilesByDialog } from "../utils/utils";

const newProject: ProjectInfo = {
  name: "",
  path: "",
  file_lists: [],
  target_device: "FDP3P7",
  settings: {
    route: {
      mode: "Direct Search",
    },
    place: {
      mode: "Timing Driven",
    },
  },
};

interface ExtraConfig {
  createSubDir: boolean;
}

let extraConfig: ExtraConfig = { createSubDir: false };

async function getSelectedDirectory() {
  const result = open({
    multiple: false,
    directory: true,
  });
  return result;
}

type PrevAndNextButtonProps = {
  totalSteps: number;
  currentStep: number;
  onPrevClick?: () => void;
  onNextClick?: () => void;
};

type StepProps = {
  totalSteps: number;
  currentStep: number;
  onPrevClick?: () => void;
  onNextClick?: () => void;
};

type StepContent = {
  label: string;
  description: string;
  content?: (props: StepProps) => JSX.Element;
};

function PrevAndNextButton(props: PrevAndNextButtonProps) {
  const { totalSteps, currentStep, onPrevClick, onNextClick } = props;

  return (
    <Group justify="center" mt="xl">
      <Button disabled={currentStep === 0} variant="default" onClick={onPrevClick}>
        {t("common.back")}
      </Button>
      <Button disabled={false} onClick={onNextClick} type="submit">
        {currentStep === totalSteps ? t("common.finish") : t("common.next")}
      </Button>
    </Group>
  );
}

function NewProjectStep1(props: StepProps) {
  const { t } = useTranslation();

  const form = useForm({
    initialValues: {
      projectName: newProject.name,
      projectPath: newProject.path,
    },
    validate: {
      projectName: (value) => {
        if (value === "") {
          return t("create_project.empty_project_name_error");
        } else if (value.match('[$-/:-?{-~!"^`\\\\\\[\\]]') !== null) {
          return t("create_project.invalid_project_name_error");
        }
        return null;
      },
      projectPath: (value) => {
        if (value === "") {
          return t("create_project.empty_project_path_error");
        }
        return null;
      },
    },
  });

  const onPathBrowseClick = async () => {
    const dir = await getSelectedDirectory();
    if (dir) {
      form.setFieldValue("projectPath", dir as string);
    }
  };

  const handleNextClick = () => {
    newProject.name = form.values.projectName;
    newProject.path = form.values.projectPath;
    if (!form.validate().hasErrors) {
      props.onNextClick?.();
    }
  };

  return (
    <Stack gap="sm" style={{ marginBottom: 20 }}>
      <Input.Wrapper label={t("create_project.project_name")} error={form.errors.projectName} withAsterisk>
        <Input
          placeholder={t("create_project.project_name_placeholder")}
          error={form.errors.projectName}
          {...form.getInputProps("projectName")}
        />
      </Input.Wrapper>
      <Input.Wrapper label={t("create_project.project_path")} error={form.errors.projectPath} withAsterisk>
        <Flex align="center">
          <Input
            className="inputBox"
            error={form.errors.projectPath}
            placeholder={t("create_project.project_path_placeholder")}
            readOnly={true}
            {...form.getInputProps("projectPath")}
          />
          <ActionIcon variant="subtle" size="lg" onClick={onPathBrowseClick}>
            <TbBrowser />
          </ActionIcon>
        </Flex>
      </Input.Wrapper>
      <Checkbox
        label={t("create_project.create_sub_dir")}
        onChange={(event) => {
          extraConfig.createSubDir = event.currentTarget.checked;
        }}
      />
      <PrevAndNextButton {...props} onNextClick={handleNextClick} />
    </Stack>
  );
}

function NewProjectStep2(props: StepProps) {
  const { t } = useTranslation();

  const [sourceFiles, setSourceFiles] = useState<SourceFile[]>([]);

  const onImportFilesClick = async () => {
    const selectedSourcefiles = (await getSourceFilesByDialog({
      dialogFilter: [
        { name: t("sourcefile.verilog"), extensions: ["v"] },
        { name: t("sourcefile.systemverilog"), extensions: ["sv"] },
        { name: t("sourcefile.constraint"), extensions: ["xml"] },
      ],
    })) as string[];

    if (selectedSourcefiles) {
      const files = selectedSourcefiles.map(
        (path) =>
          new Promise<SourceFile>((resolve) => {
            resolve(getFileInfoByPath(path));
          })
      );
      Promise.all(files).then((files) => {
        setSourceFiles((prev) => {
          const newFiles = files.filter((file) => prev.findIndex((f) => f.path === file.path) === -1);
          return [...prev, ...newFiles];
        });
      });
    }
  };

  const handleNextClick = () => {
    newProject.file_lists = sourceFiles;
    props.onNextClick?.();
  };

  const rows = sourceFiles.map((file) => (
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
      <PrevAndNextButton {...props} onNextClick={handleNextClick} />
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

  const { setProject, recentlyOpenedProjects, setRecentlyOpenedProjects } = useContext(ProjectContext);
  const [active, setActive] = useState(0);

  const nextStep = () => {
    setActive((current) => (current < 3 ? current + 1 : current));
  };
  const prevStep = () => setActive((current) => (current > 0 ? current - 1 : current));

  const handleProjectCreatedSuccess = () => {
    setProject(newProject);
    updateRecentlyOpenedProjects(newProject, recentlyOpenedProjects, setRecentlyOpenedProjects);

    showSuccessNotification({
      message: "",
      title: t("create_project.create_new_success_title"),
    });
  };

  const handleProjectCreatedFailed = (_: any) => {
    showFailedNotification({
      message: t("create_project.check_dir"),
      title: t("create_project.create_new_failed_title"),
    });
  };

  const handleCompleteButtonClicked = async () => {
    const splitChar = (await isWindowsPlatform()) ? "\\" : "/";
    var filepath = newProject.path + splitChar;

    if (extraConfig.createSubDir === true) {
      mkdir(newProject.path + splitChar + newProject.name).catch(() => {
        showFailedNotification({
          title: t("create_project.create_new_failed_title"),
          message: t("create_project.check_dir"),
        });
      });
      filepath = newProject.path + splitChar + newProject.name + splitChar;
    }

    filepath += newProject.name + ".json";
    newProject.path = filepath;

    const { path, ...rest } = newProject;
    writeTextFile(filepath, JSON.stringify(rest))
      .then(handleProjectCreatedSuccess, handleProjectCreatedFailed)
      .finally(() => {
        props.onClose();
      });
  };

  return (
    <Modal {...props} title={t("project.new_project")}>
      <Modal.Body>
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
              onNextClick={handleCompleteButtonClicked}
            />
          </Stepper.Completed>
        </Stepper>
      </Modal.Body>
    </Modal>
  );
}

export default NewProjectModal;
