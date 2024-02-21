import { Button, Card, Stack, Title, Text, Flex, ScrollArea, Table } from "@mantine/core";
import { invoke } from "@tauri-apps/api";

import StartUpPage from "./StartupPage";
import showProgramFailedNotification, { showSuccessNotification } from "./Notifies";
import { useTranslation } from "react-i18next";
import { useContext } from "react";
import { ProjectContext } from "../App";
import { Command } from "@tauri-apps/api/shell";
import "./ProjectPage.css";
import { TbFileImport } from "react-icons/tb";
import { WebviewWindow } from "@tauri-apps/api/window";

function SourceFileSection() {
  const { t } = useTranslation();
  const { project } = useContext(ProjectContext);

  function SourceFileTable() {
    const rows = project?.file_lists.map((file) => {
      return (
        <Table.Tr
          key={file.name}
          onDoubleClick={async ()=> {
            const content = "module top();\nendmodule";

            const webview = new WebviewWindow("editor", {
              url: "editor.html",
              title: "Editor",
              width: 800,
              height: 600,
            });
            webview.once("tauri://created", async () => {
              await webview.emit("content", content);
              console.log("content sent");
            });
            
          }}
        >
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
      <ScrollArea>
        <Table.ScrollContainer minWidth={300}>
          <Table striped highlightOnHover withTableBorder withColumnBorders>
            <Table.Thead>
              <Table.Tr>
                <Table.Th>{t("project.file_name")}</Table.Th>
                <Table.Th>{t("project.file_path")}</Table.Th>
                <Table.Th>{t("project.file_type")}</Table.Th>
              </Table.Tr>
            </Table.Thead>
            <Table.Tbody>{rows}</Table.Tbody>
          </Table>
        </Table.ScrollContainer>
      </ScrollArea>
    );
  }

  return (
    <>
      <Title className="sectionTitle">{t("project.source_files")}</Title>
      <Card radius={10} p="md" shadow="sm">
        <SourceFileTable />
        <Flex justify="flex-end">
          <Button variant="subtle" leftSection={<TbFileImport />} style={{ marginTop: "auto" }}>
            {t("project.import_files")}
          </Button>
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
      <Card radius="10" p="md" shadow="sm">
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
  const { t } = useTranslation();
  const { project } = useContext(ProjectContext);

  if (project !== null) {
    return (
      <Stack gap="sm">
        <ProjectInfoSection />
        <SourceFileSection />
        <Button
          variant="subtle"
          onClick={() => {
            invoke("program_fpga", { bitfile: "/Users/taruhi/Desktop/Dino/Dino_fde_yosys.bit" }).then(
              () => {
                showSuccessNotification({ translation: t, title: "program.success", message: "" });
              },
              (err) => {
                showProgramFailedNotification({ translation: t, message: "program.error." + err });
              }
            );
          }}
        >
          {t("program.program")}
        </Button>
        <Button
          variant="subtle"
          onClick={() => {
            const mapCommand = Command.sidecar("binaries/fde-cli/import", ["--help"]);
            mapCommand.stdout.on("data", (data) => {
              console.log(data);
            });
            mapCommand.execute();
          }}
        >
          test command
        </Button>
      </Stack>
    );
  } else {
    return <StartUpPage />;
  }
}

export default ProjectPage;
