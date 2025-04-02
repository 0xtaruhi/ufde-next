import { Button, Group, Modal, ModalProps, ScrollArea, Select, Stack, Table, Text } from "@mantine/core";
import { ProjectInfo, SourceFile } from "../model/project";
import { PortInfo, getAllPorts } from "../utils/VerilogParser";
import { useContext, useEffect, useMemo, useState } from "react";
import { useTranslation } from "react-i18next";
import { devicePorts, maybeClockNames } from "../utils/Pins";
import { writeTextFile } from "@tauri-apps/plugin-fs";
import { ProjectContext } from "../App";
import { getDirOfFile } from "../utils/utils";
import { TbFileReport, TbRobot } from "react-icons/tb";

interface GenConstraintModalProps extends ModalProps {
  file: SourceFile | undefined;
}

export default function GenConstraintModal(props: GenConstraintModalProps) {
  const [portsMap, setPortsMap] = useState<Map<string, PortInfo[]>>(new Map());
  const [selectedModule, setSelectedModule] = useState<string>();
  const { t } = useTranslation();

  useEffect(() => {
    const fetchPortsMap = async () => {
      if (!props.file) {
        return;
      }
      const newPortsMap = await getAllPorts(props.file.path);
      setPortsMap(newPortsMap);
    };
    if (props.opened) {
      fetchPortsMap();
    }
    setSelectedModule(undefined);
  }, [props.opened, props.file]);

  const expandPorts = (ports: PortInfo[]) => {
    let expandedPorts: PortInfo[] = new Array();
    ports.forEach((port) => {
      if (port.leftBound !== port.rightBound) {
        const small = Math.min(port.leftBound, port.rightBound);
        const large = Math.max(port.leftBound, port.rightBound);
        for (let i = small; i <= large; i++) {
          expandedPorts.push({ ...port, name: port.name + "[" + i + "]" });
        }
      } else {
        expandedPorts.push(port);
      }
    });
    return expandedPorts;
  };

  const inputPortList = devicePorts.FDP3P7.input.concat(devicePorts.FDP3P7.clock);
  const outputPortList = devicePorts.FDP3P7.output;
  const clockPort = devicePorts.FDP3P7.clock;

  const [mappedPins, setMappedPins] = useState<Map<string, string>>(new Map());

  const expandedPorts = useMemo(() => {
    return expandPorts(portsMap.get(selectedModule ?? "") ?? []);
  }, [selectedModule]);

  const tableDataRaw = expandedPorts.map((port) => {
    return {
      direction: port.direction,
      name: port.name,
    };
  });

  const { project, setProject, setProjectModified } = useContext(ProjectContext);

  const onGenerateBtnClick = async () => {
    const xml = `<design name="${selectedModule}">
  ${expandedPorts
    .map((port) => {
      return `<port name="${port.name}" position="${mappedPins.get(port.name)}"/>`;
    })
    .join("\n")}
    </design>`;
    const xmlFileName = project?.name + "_cons.xml";
    const xmlPath = (await getDirOfFile(project?.path ?? "")) + xmlFileName;
    writeTextFile(xmlPath, xml);

    const fileList = project?.file_lists;
    const newFileList = fileList?.concat([{ name: xmlFileName, path: xmlPath, type: "constraint" }]);
    setProject({ ...project, file_lists: newFileList } as ProjectInfo);
    setProjectModified(true);
    props.onClose();
  };

  const onAutoAssignBtnClick = () => {
    const mappedPins = new Map<string, string>();
    let inputIdx = 0,
      outputIdx = 0;
    for (let i = 0; i < expandedPorts.length; i++) {
      const port = expandedPorts[i];
      if (maybeClockNames.includes(port.name)) {
        mappedPins.set(port.name, clockPort);
        continue;
      }
      if (port.direction === "input") {
        if (inputIdx >= inputPortList.length) {
          break;
        }
        mappedPins.set(port.name, inputPortList[inputIdx]);
        inputIdx++;
      } else {
        if (outputIdx >= outputPortList.length) {
          break;
        }
        mappedPins.set(port.name, outputPortList[outputIdx]);
        outputIdx++;
      }
    }
    setMappedPins(mappedPins);
  };

  return (
    <Modal {...props} size="lg">
      <Stack gap="sm">
        <Group gap="sm">
          <Select
            placeholder={t("constraint.select_module")}
            data={Array.from(portsMap.keys())}
            value={selectedModule}
            onChange={(e) => setSelectedModule(e ?? undefined)}
            allowDeselect={false}
          />
          <Button
            variant="subtle"
            onClick={onAutoAssignBtnClick}
            style={{ marginLeft: "auto" }}
            disabled={!selectedModule}
            leftSection={<TbRobot size={18} />}
          >
            {t("constraint.auto_assign")}
          </Button>
        </Group>
        {selectedModule && (
          <>
            <ScrollArea h={400}>
              <Table.ScrollContainer minWidth={500}>
                <Table highlightOnHover withTableBorder withColumnBorders>
                  <Table.Thead>
                    <Table.Tr>
                      <Table.Th>{t("constraint.direction")}</Table.Th>
                      <Table.Th>{t("constraint.port_name")}</Table.Th>
                      <Table.Th>{t("constraint.pin")}</Table.Th>
                    </Table.Tr>
                  </Table.Thead>
                  <Table.Tbody>
                    {selectedModule &&
                      tableDataRaw.map((data) => {
                        return (
                          <Table.Tr key={data.name}>
                            <Table.Td>{data.direction}</Table.Td>
                            {/* <Table.Td>{data.name}</Table.Td> */}
                            <Table.Td>
                              {data.name}
                              {mappedPins.get(data.name) === clockPort && (
                                <Text c="dimmed" fs="italic">
                                  clock
                                </Text>
                              )}
                            </Table.Td>
                            <Table.Td>
                              <Select
                                data={data.direction === "input" ? inputPortList : outputPortList}
                                withScrollArea
                                searchable
                                placeholder={t("constraint.select_pin")}
                                onChange={(e) => {
                                  if (e) {
                                    setMappedPins(new Map(mappedPins.set(data.name, e)));
                                  }
                                }}
                                allowDeselect={false}
                                value={mappedPins.get(data.name)}
                              />
                            </Table.Td>
                          </Table.Tr>
                        );
                      })}
                  </Table.Tbody>
                </Table>
              </Table.ScrollContainer>
            </ScrollArea>
            <Button variant="subtle" onClick={onGenerateBtnClick} leftSection={<TbFileReport size={18} />}>
              {t("constraint.generate")}
            </Button>
          </>
        )}
      </Stack>
    </Modal>
  );
}
