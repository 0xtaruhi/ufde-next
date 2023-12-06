import { useTranslation } from "react-i18next";
import { useState } from "react";
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

async function getSelectedDirectory() {
  const result = open({
    multiple: false,
    directory: true,
  });
  return result;
}

function NewProjectStep1() {
  const { t } = useTranslation();

  const [projectPath, setProjectPath] = useState("");
  const [_projectName, setProjectName] = useState("");

  const onPathBrowseClick = async () => {
    const dir = await getSelectedDirectory();
    if (dir) {
      setProjectPath(dir as string);
    }
  };

  const [createSubDir, setCreateSubDir] = useState(true);

  return (
    <Stack gap="sm" style={{ marginBottom: 20 }}>
      <Input.Wrapper label={t("create_project.project_name")} withAsterisk>
        <Input
          placeholder={t("create_project.project_name_placeholder")}
          onChange={(event) => setProjectName(event.currentTarget.value)}
        />
      </Input.Wrapper>
      <Input.Wrapper label={t("create_project.project_path")} withAsterisk>
        <Flex align="center">
          <Input
            className="inputBox"
            value={projectPath}
            placeholder={t("create_project.project_path_placeholder")}
            readOnly={true}
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

function NewProjectStep2() {
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
    </Stack>
  );
}

function NewProjectStep3() {
  return (
    <Stack gap="sm" style={{ marginBottom: 20 }}>
      <InputWrapper label={t("create_project.target_device")} withAsterisk>
        <Input readOnly={true} value="FDP3P7"></Input>
      </InputWrapper>
    </Stack>
  );
}

function NewProjectModal(props: ModalProps) {
  const { t } = useTranslation();

  const [active, setActive] = useState(0);
  const nextStep = () => setActive((current) => (current < 3 ? current + 1 : current));
  const prevStep = () => setActive((current) => (current > 0 ? current - 1 : current));

  return (
    <Modal {...props} title={t("project.new_project")}>
      <Modal.Body>
        <Stepper active={active} onStepClick={setActive} allowNextStepsSelect={false}>
          <Stepper.Step label={t("common.first_step")} description={t("create_project.basic_info")}>
            <NewProjectStep1 />
          </Stepper.Step>
          <Stepper.Step label={t("common.second_step")} description={t("create_project.import_files")}>
            <NewProjectStep2 />
          </Stepper.Step>
          <Stepper.Step label={t("common.third_step")} description={t("create_project.target_device")}>
            <NewProjectStep3 />
          </Stepper.Step>
          <Stepper.Completed>{t("create_project.finish_hint")}</Stepper.Completed>
        </Stepper>

        <Group justify="center" mt="xl">
          <Button disabled={active === 0} variant="default" onClick={prevStep}>
            {t("common.back")}
          </Button>
          <Button onClick={nextStep}>{active === 3 ? t("common.finish") : t("common.next")} </Button>
        </Group>
      </Modal.Body>
    </Modal>
  );
}

export default NewProjectModal;
