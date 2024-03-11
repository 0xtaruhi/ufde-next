import { Button, Card, Stack, Title, Text, Flex, ScrollArea, Table, Checkbox, Group } from "@mantine/core";

import StartUpPage from "./StartupPage";
import { showFailedNotification } from "./Notifies";
import { useTranslation } from "react-i18next";
import { useContext, useState } from "react";
import { ProjectContext } from "../App";
import { Command } from "@tauri-apps/api/shell";
import "./ProjectPage.css";
import { TbFileCode, TbFileImport, TbTrash } from "react-icons/tb";
import { platform } from "@tauri-apps/api/os";
import { getFileInfoByPath, getSourceFilesByDialog } from "../utils/utils";
import { SourceFile } from "../model/project";
import { modals } from "@mantine/modals";
import GenConstraintModal from "./GenConstraintModal";

function SourceFileSection() {
  const { t } = useTranslation();
  const { project, setProject, setProjectModified } = useContext(ProjectContext);

  const [selectedRows, setSelectedRows] = useState<number[]>([]);

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
        let newProject = { ...project! };
        newProject.file_lists = [...newProject.file_lists, ...files];
        setProject(newProject);
        setProjectModified(true);
      });
    }
  };

  const onDeleteFiles = async () => {
    modals.openConfirmModal({
      title: t("project.delete_files"),
      centered: true,
      children: <Text size="sm">{t("project.delete_files_confirm")}</Text>,
      labels: { confirm: t("common.confirm_yes"), cancel: t("common.confirm_no") },
      confirmProps: { color: "red" },
      onConfirm: () => {
        let newProject = { ...project! };
        newProject.file_lists = newProject.file_lists.filter((_, index) => !selectedRows.includes(index));
        setProject(newProject);
        setProjectModified(true);
        setSelectedRows([]);
      },
    });
  };

  function SourceFileTable() {
    const rows = project?.file_lists.map((file, index) => {
      return (
        <Table.Tr
          key={file.name}
          onDoubleClick={async () => {
            const platformName = await platform();
            const cmdStr = /^win/i.test(platformName) ? "vscode.cmd" : "vscode";
            const command = new Command(cmdStr, file.path);
            command.spawn().catch((_) => {
              showFailedNotification({ message: "other.vscode_not_found", title: "" });
            });
          }}
          bg={selectedRows.includes(index) ? "var(--mantine-color-blue-light)" : undefined}
        >
          <Table.Td>
            <Checkbox
              aria-label="Select row"
              checked={selectedRows.includes(index)}
              onChange={(e) => {
                if (e.target.checked) {
                  setSelectedRows([...selectedRows, index]);
                } else {
                  setSelectedRows(selectedRows.filter((i) => i !== index));
                }
              }}
            />
          </Table.Td>
          <Table.Td>{file.name}</Table.Td>
          <Table.Td>{file.path}</Table.Td>
          <Table.Td>{file.type}</Table.Td>
        </Table.Tr>
      );
    });

    return project?.file_lists.length === 0 ? (
      <Text c="dimmed" style={{ textAlign: "center" }}>
        {t("project.no_files")}
      </Text>
    ) : (
      <Stack gap="sm">
        <Text
          c="dimmed"
          size="xs"
          style={{
            textAlign: "right",
          }}
        >
          {t("project.double_click_to_open")}
        </Text>
        <ScrollArea>
          <Table.ScrollContainer minWidth={300}>
            <Table highlightOnHover withTableBorder withColumnBorders>
              <Table.Thead>
                <Table.Tr>
                  <Table.Th></Table.Th>
                  <Table.Th>{t("project.file_name")}</Table.Th>
                  <Table.Th>{t("project.file_path")}</Table.Th>
                  <Table.Th>{t("project.file_type")}</Table.Th>
                </Table.Tr>
              </Table.Thead>
              <Table.Tbody>{rows}</Table.Tbody>
            </Table>
          </Table.ScrollContainer>
        </ScrollArea>
      </Stack>
    );
  }

  const canGenerateConstraint = () => {
    return selectedRows.length === 1 && project?.file_lists.filter((file) => file.type === "constraint").length === 0;
  };

  const onGenerateConstraint = async () => {
    setGenConstraintModalOpened(true);
  };

  const [genConstraintModalOpened, setGenConstraintModalOpened] = useState(false);

  return (
    <>
      <Title className="sectionTitle">{t("project.source_files")}</Title>
      <Card withBorder radius={10} p="md" className="projectCard">
        <SourceFileTable />
        <GenConstraintModal
          opened={genConstraintModalOpened}
          file={project?.file_lists[selectedRows[0]]}
          onClose={() => {
            setGenConstraintModalOpened(false);
          }}
          title={(
            <Text size="lg" fw={700}>
              {t("project.generate_constraint")}
            </Text>
          )}
        />
        <Flex justify="flex-end">
          <Group>
            {canGenerateConstraint() && (
              <Button
                variant="subtle"
                leftSection={<TbFileCode />}
                disabled={
                  !(
                    selectedRows.length === 1 &&
                    project?.file_lists.filter((file) => file.type === "constraint").length === 0 &&
                    project?.file_lists[selectedRows[0]].type === "verilog"
                  )
                }
                hidden={true}
                onClick={onGenerateConstraint}
              >
                {t("project.generate_constraint")}
              </Button>
            )}
            <Button
              variant="subtle"
              leftSection={<TbTrash />}
              disabled={selectedRows.length === 0}
              onClick={onDeleteFiles}
            >
              {t("project.delete_files")}
            </Button>
            <Button
              variant="subtle"
              leftSection={<TbFileImport />}
              style={{ marginTop: "auto" }}
              onClick={onImportFilesClick}
            >
              {t("project.import_files")}
            </Button>
          </Group>
        </Flex>
      </Card>
    </>
  );
}

function ProjectInfoSection() {
  const { t } = useTranslation();
  const { project } = useContext(ProjectContext);

  return (
    <>
      <Title className="sectionTitle">{t("project.basic_info")}</Title>
      <Card withBorder radius="10" p="md" className="projectCard">
        <Stack gap="xs">
          <div>
            <Flex gap="sm">
              <Text className="projInfoField">{t("project.project_name")}</Text>
              <Text>{project!.name}</Text>
            </Flex>
            <Flex gap="sm">
              <Text className="projInfoField">{t("project.project_path")}</Text>
              <div>{project!.path}</div>
            </Flex>
          </div>
        </Stack>
      </Card>
    </>
  );
}

function ProjectPage() {
  const { project } = useContext(ProjectContext);

  if (project !== null) {
    return (
      <Stack gap="sm">
        <ProjectInfoSection />
        <SourceFileSection />
      </Stack>
    );
  } else {
    return <StartUpPage />;
  }
}

export default ProjectPage;
