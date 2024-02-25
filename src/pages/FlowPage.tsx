import {
  Flex,
  SegmentedControl,
  Stack,
  Timeline,
  Text,
  Drawer,
  ScrollArea,
  ActionIcon,
  Group,
  Combobox,
  InputBase,
  useCombobox,
  Button,
} from "@mantine/core";
import { TbSettings, TbPlayerPlay, TbChevronDown, TbPlayerPlayFilled } from "react-icons/tb";
import { useDisclosure } from "@mantine/hooks";
import { useState } from "react";
import "./FlowPage.css";
import { useTranslation } from "react-i18next";
import { Command } from "@tauri-apps/api/shell";
import { useContext } from "react";
import { ProjectContext } from "../App";
import { resolveResource } from "@tauri-apps/api/path";
import { useEffect } from "react";
import { exists } from "@tauri-apps/api/fs";
import { update2FailedNotification, update2SuccessNotification } from "./Notifies";
import { notifications } from "@mantine/notifications";
import { ProjectInfo } from "../model/project";
import { useCallback } from "react";

const flowData = [
  { value: "DC", label: "DC" },
  { value: "Yosys", label: "Yosys" },
];

interface AbstractFlowProps {
  flowName: string;
  onRun: () => void;
  runAvailable: boolean;
  settingsPage: React.ReactNode;
  status: string;
}

function Flow(props: AbstractFlowProps) {
  const { t } = useTranslation();
  const [opened, { open, close }] = useDisclosure(false);

  return (
    <>
      <Drawer opened={opened} onClose={close} padding="md" size={350} position="right">
        <Stack gap="md">
          <Text size="md" className="flowSettingsTitle">
            <b>{t("flow.settings")}</b> - {t("flow." + props.flowName + ".title")}
          </Text>
          {props.settingsPage}
        </Stack>
      </Drawer>
      <Flex justify="space-between">
        <Text c="dimmed" size="sm">
          {t("flow." + props.flowName + ".description")}
        </Text>
        <Group>
          <ActionIcon size="md" variant="subtle" onClick={open} style={{ padding: "5px" }}>
            <TbSettings size={20} />
          </ActionIcon>
          <ActionIcon
            size="md"
            variant="subtle"
            onClick={props.onRun}
            style={{ padding: "5px" }}
            disabled={!props.runAvailable}
          >
            <TbPlayerPlay size={20} />
          </ActionIcon>
        </Group>
      </Flex>
      {props.status && (
        <Text size="sm" c="dimmed">
          {props.status}
        </Text>
      )}
    </>
  );
}

function EmptySettingsHint() {
  const { t } = useTranslation();
  return <Text c="dimmed">{t("flow.no-settings-available")}</Text>;
}

function SettingsItem({ label, component }: { label: string; component: React.ReactNode }) {
  return (
    <Group justify="space-between">
      <Text size="md">{label}</Text>
      {component}
    </Group>
  );
}

interface FlowProps {
  index: number;
  runAvailable: boolean;
  setActive: (index: number) => void;
}

async function runDCImportFlowCommand(project: ProjectInfo) {
  const files = project.file_lists
    ?.filter((file) => file.type === "verilog" || file.type === "systemverilog")
    .map((file) => file.path);

  const celllibfilePath = await resolveResource("resource/hw_lib/dc_cell.xml");
  const outputFileName = project.name + "_dc_" + "imp.xml";

  const command = Command.sidecar(
    "binaries/fde-cli/import",
    ["-x", outputFileName, "-l", celllibfilePath, "-e", files?.join(" ") ?? ""],
    { cwd: project.path }
  );

  return command;
}

async function runDCMapFlowCommand(project: ProjectInfo) {
  const files = project?.file_lists
    ?.filter((file) => file.type === "verilog" || file.type === "systemverilog")
    .map((file) => file.path);

  const celllibfilePath = await resolveResource("resource/hw_lib/dc_cell.xml");
  const mapArgs = "";
  const mapFileMode = "";

  const inputFileName = project?.name + "_dc_" + "imp.xml";
  const outputFileName = project?.name + "_dc_" + "map.xml";

  const command = Command.sidecar(
    "binaries/fde-cli/map",
    [
      "-i",
      inputFileName,
      "-o",
      outputFileName,
      "-c",
      celllibfilePath,
      mapArgs,
      mapFileMode,
      "-e",
      files?.join(" ") ?? "",
    ],
    { cwd: project?.path }
  );

  return command;
}

async function runDCPackFlowCommand(project: ProjectInfo) {
  const family = "fdp3";
  const dccelllibfilePath = await resolveResource("resource/hw_lib/fdp3_cell.xml");
  const dcplibfilePath = await resolveResource("resource/hw_lib/fdp3_dcplib.xml");
  const xdlcfgfilePath = await resolveResource("resource/hw_lib/fdp3_config.xml");

  const inputFileName = project.name + "_dc_" + "map.xml";
  const outputFileName = project.name + "_dc_" + "pack.xml";

  const command = Command.sidecar(
    "binaries/fde-cli/pack",
    [
      "-c",
      family,
      "-n",
      inputFileName,
      "-l",
      dccelllibfilePath,
      "-r",
      dcplibfilePath,
      "-o",
      outputFileName,
      "-g",
      xdlcfgfilePath,
      "-e",
    ],
    { cwd: project.path }
  );

  return command;
}

function DCPlaceFlowSettingsPage() {
  const { t } = useTranslation();

  const settings = (
    <>
      <SettingsItem
        label={t("flow.mode")}
        component={<SegmentedControl data={["Timing Driven", "Bounding Box"]} onChange={() => {}} />}
      />
    </>
  );
  return settings;
}

async function runDCPlaceFlowCommand(project: ProjectInfo) {
  const archfilePath = await resolveResource("resource/hw_lib/fdp3p7_arch.xml");
  const plcdelayfilePath = await resolveResource("resource/hw_lib/fdp3p7_dly.xml");
  const placecst = "-c";
  const placecstFilePath = project.file_lists.filter((file) => file.type === "constraint")[0].path;
  const placeMode = "-b";

  const inputFileName = project.name + "_dc_" + "pack.xml";
  const outputFileName = project.name + "_dc_" + "place.xml";

  const command = Command.sidecar(
    "binaries/fde-cli/place",
    [
      "-a",
      archfilePath,
      "-d",
      plcdelayfilePath,
      "-i",
      inputFileName,
      "-o",
      outputFileName,
      placecst,
      placecstFilePath,
      placeMode,
      "-e",
    ],
    { cwd: project.path }
  );

  return command;
}

async function runDCRouteFlowCommand(project: ProjectInfo) {
  const archfilePath = await resolveResource("resource/hw_lib/fdp3p7_arch.xml");
  const routeMode = "-d";
  const routecst = "-c";
  const routecstFilePath = project.file_lists.filter((file) => file.type === "constraint")[0].path;

  const inputFileName = project.name + "_dc_" + "place.xml";
  const outputFileName = project.name + "_dc_" + "route.xml";

  const command = Command.sidecar(
    "binaries/fde-cli/route",
    ["-a", archfilePath, "-n", inputFileName, "-o", outputFileName, routeMode, routecst, routecstFilePath, "-e"],
    { cwd: project.path }
  );

  return command;
}

function DCRouteFlowSettingsPage() {
  function ModeSettingItem() {
    const combobox = useCombobox({
      onDropdownClose: () => combobox.resetSelectedOption(),
    });

    const modes = ["Direct Search", "Breath First", "Timing Driven"];
    const options = modes.map((mode) => (
      <Combobox.Option key={mode} value={mode}>
        {mode}
      </Combobox.Option>
    ));

    const [value, setValue] = useState<string>("Direct Search");

    return (
      <Combobox
        onOptionSubmit={(value) => {
          setValue(value);
          combobox.closeDropdown();
        }}
        store={combobox}
      >
        <Combobox.Target>
          <InputBase
            component="button"
            type="button"
            rightSection={<TbChevronDown size={20} />}
            rightSectionPointerEvents="none"
            pointer
            onClick={() => combobox.toggleDropdown()}
          >
            {value}
          </InputBase>
        </Combobox.Target>
        <Combobox.Dropdown>
          <Combobox.Options>{options}</Combobox.Options>
        </Combobox.Dropdown>
      </Combobox>
    );
  }

  const settings = (
    <>
      <SettingsItem label="Mode" component={<ModeSettingItem />} />
    </>
  );

  return settings;
}

async function runDCGenBitFlowCommand(project: ProjectInfo) {
  const archfilePath = await resolveResource("resource/hw_lib/fdp3p7_arch.xml");
  const cilfilePath = await resolveResource("resource/hw_lib/fdp3p7_cil.xml");

  const inputFileName = project.name + "_dc_" + "route.xml";
  const outputFileName = project.name + "_dc_" + "bit.xml";

  const command = Command.sidecar(
    "binaries/fde-cli/bitgen",
    ["-a", archfilePath, "-c", cilfilePath, "-n", inputFileName, "-b", outputFileName, "-e"],
    { cwd: project.path }
  );

  return command;
}

interface FlowInfo {
  name: string;
  target_file?: string;
  runFunc?: (project: ProjectInfo) => Promise<Command>;
  settingsPage?: React.ReactNode;
}

function FlowInstance(props: FlowInfo & FlowProps) {
  const { t } = useTranslation();
  const projectContext = useContext(ProjectContext);

  const [statusText, setStatusText] = useState<string>("");

  const run = async () => {
    const command = props.runFunc ? await props.runFunc(projectContext.project!) : undefined;
    if (command) {
      command.stdout.on("data", (data) => {
        setStatusText(data);
      });
      command.stderr.on("data", (data) => {
        setStatusText(data);
      });

      const notifyId = notifications.show({
        title: t("flow.notify.running.title"),
        message:
          t("flow.notify.running.message_prefix") +
          t("flow." + props.name + ".title") +
          t("flow.notify.running.message_suffix"),
        autoClose: false,
        loading: true,
      });

      command.execute().then(
        () => {
          props.setActive(props.index + 1);
          update2SuccessNotification({
            id: notifyId,
            title: t("flow." + props.name + ".title"),
            message:
              t("flow.notify.success.message_prefix") +
              t("flow." + props.name + ".title") +
              t("flow.notify.success.message_suffix"),
          });
        },
        (err) => {
          update2FailedNotification({
            id: notifyId,
            title: t("flow." + props.name + ".title"),
            message:
              t("flow.notify.failed.message_prefix") +
              t("flow." + props.name + ".title") +
              t("flow.notify.failed.message_suffix") +
              ": " +
              err,
          });
        }
      );
    }
  };

  return (
    <Flow
      flowName={props.name}
      onRun={run}
      settingsPage={props.settingsPage ? props.settingsPage : <EmptySettingsHint />}
      runAvailable={true}
      status={statusText}
    />
  );
}

const dcFlows = [
  { name: "dc.import", target_file: "dc_imp.xml", runFunc: runDCImportFlowCommand },
  { name: "dc.map", target_file: "dc_map.xml", runFunc: runDCMapFlowCommand },
  { name: "dc.pack", target_file: "dc_pack.xml", runFunc: runDCPackFlowCommand },
  {
    name: "dc.place",
    target_file: "dc_place.xml",
    runFunc: runDCPlaceFlowCommand,
    SettingsPage: <DCPlaceFlowSettingsPage />,
  },
  {
    name: "dc.route",
    target_file: "dc_route.xml",
    runFunc: runDCRouteFlowCommand,
    settingsPage: <DCRouteFlowSettingsPage />,
  },
  {
    name: "dc.genbit",
    target_file: "dc_genbit.xml",
    runFunc: runDCGenBitFlowCommand,
  },
];

const flowsNameMap: { [key: string]: FlowInfo[] } = {
  DC: dcFlows,
  Yosys: [],
};

function FlowItems(props: { flows: FlowInfo[]; active: number; setActive: (index: number) => void }) {
  const { t } = useTranslation();
  const projectContext = useContext(ProjectContext);
  const project = projectContext.project;

  useEffect(() => {
    const projectName = project?.name;
    let tmpActive = 0;
    (async () => {
      for (let i = 0; i < props.flows.length; i++) {
        const flow = props.flows[i];
        if (flow.target_file) {
          const fileName = projectName + "_" + flow.target_file;
          if (await exists(project?.path + "/" + fileName)) {
            tmpActive = i + 1;
          }
        } else {
          break;
        }
      }
      props.setActive(tmpActive);
    })();
  });

  return (
    <Timeline bulletSize={24} style={{ padding: "20px 20px" }} active={props.active}>
      {props.flows.map((flow, index) => {
        return (
          <Timeline.Item title={t("flow." + flow.name + ".title")} color="blue" className="flowItem" key={index}>
            <FlowInstance
              name={flow.name}
              runFunc={flow.runFunc}
              runAvailable={props.active >= index}
              index={index}
              setActive={props.setActive}
              settingsPage={flow.settingsPage}
            />
          </Timeline.Item>
        );
      })}
    </Timeline>
  );
}

function FlowPage() {
  const [flowName, setFlowName] = useState("DC");
  const projectContext = useContext(ProjectContext);
  const project = projectContext.project;
  const { t } = useTranslation();

  const run = async (flow: FlowInfo) => {
    const notifyId = notifications.show({
      title: t("flow.notify.running.title"),
      message:
        t("flow.notify.running.message_prefix") +
        t("flow." + flow.name + ".title") +
        t("flow.notify.running.message_suffix"),
      autoClose: false,
      loading: true,
    });

    const command = flow.runFunc ? await flow.runFunc(project!) : undefined;

    if (command) {
      command.execute().then(
        () => {
          update2SuccessNotification({
            id: notifyId,
            title: t("flow." + flow.name + ".title"),
            message:
              t("flow.notify.success.message_prefix") +
              t("flow." + flow.name + ".title") +
              t("flow.notify.success.message_suffix"),
          });
        },
        (err) => {
          update2FailedNotification({
            id: notifyId,
            title: t("flow." + flow.name + ".title"),
            message:
              t("flow.notify.failed.message_prefix") +
              t("flow." + flow.name + ".title") +
              t("flow.notify.failed.message_suffix") +
              ": " +
              err,
          });
        }
      );
    }
  };

  const [active, setActive] = useState(0);

  const runAll = useCallback(async () => {
    const flows = flowsNameMap[flowName];
    setActive(0);

    for (let i = 0; i < flows.length; i++) {
      const flow = flows[i];
      await run(flow);
      setActive(i + 1);
    }
  }, []);

  return (
    <>
      <Stack gap="md">
        <Flex style={{ paddingLeft: "20px", paddingRight: "20px" }}>
          <SegmentedControl
            data={flowData}
            value={flowName}
            onChange={setFlowName}
            style={{ width: "500px", marginRight: "auto" }}
          />
          <Button
            size="sm"
            color="green"
            variant="filled"
            style={{ marginLeft: "auto" }}
            leftSection={<TbPlayerPlayFilled size={20} />}
            onClick={runAll}
          >
            {useTranslation().t("flow.run_all")}
          </Button>
        </Flex>
        <ScrollArea style={{ height: "calc(100vh - 150px)" }}>
          {<FlowItems flows={flowsNameMap[flowName]} active={active} setActive={setActive} />}
        </ScrollArea>
      </Stack>
    </>
  );
}

export default FlowPage;
