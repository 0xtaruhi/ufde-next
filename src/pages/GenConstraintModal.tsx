import { Button, Modal, ModalProps, Select, Stack, Table } from "@mantine/core";
import { SourceFile } from "../model/project";
import { PortInfo, getAllPorts } from "../utils/VerilogParser";
import { useEffect, useState } from "react";

interface GenConstraintModalProps extends ModalProps {
  file: SourceFile | undefined;
}

export default function GenConstraintModal(props: GenConstraintModalProps) {
  const [portsMap, setPortsMap] = useState<Map<string, PortInfo[]>>(new Map());
  const [selectedModule, setSelectedModule] = useState<string>();

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

  const tableData = expandPorts(portsMap.get(selectedModule ?? "") ?? []).map((port) => {
    return { name: port.name, direction: port.direction, pin: "" };
  });

  return (
    <>
      <Modal {...props}>
        <Stack gap="sm">
          <Select
            placeholder="Select module"
            data={Array.from(portsMap.keys())}
            label="Module"
            value={selectedModule}
            onChange={(e) => setSelectedModule(e ?? undefined)}
          />
          {selectedModule && (
            <>
              <Table>
                <Table.Thead>
                  <Table.Tr>
                    <Table.Th>Direction</Table.Th>
                    <Table.Th>Port Name</Table.Th>
                    <Table.Th>Pin</Table.Th>
                  </Table.Tr>
                </Table.Thead>
                {selectedModule &&
                  tableData.map((port) => {
                    return (
                      <Table.Tr key={port.name}>
                        <Table.Td>{port.direction}</Table.Td>
                        <Table.Td>{port.name}</Table.Td>
                        <Table.Td>{port.pin}</Table.Td>
                      </Table.Tr>
                    );
                  })}
              </Table>
              <Button variant="subtle">Generate</Button>
            </>
          )}
        </Stack>
      </Modal>
    </>
  );
}
