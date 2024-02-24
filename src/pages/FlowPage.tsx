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
} from "@mantine/core";
import { TbSettings, TbPlayerPlay, TbChevronDown } from "react-icons/tb";
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
import { showSuccessNotification } from "./Notifies";

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

function DCImportFlow(props: FlowProps) {
  const projectContext = useContext(ProjectContext);
  const [statusText, setStatusText] = useState<string>("");

  const run = async () => {
    const files = projectContext.project?.file_lists?.map((file) => file.path);

    const celllibfilePath = await resolveResource("resource/hw_lib/dc_cell.xml");
    console.log(celllibfilePath);
    const outputFileName = projectContext.project?.name + "_dc_" + "imp.xml";

    const command = Command.sidecar(
      "binaries/fde-cli/import",
      ["-x", outputFileName, "-l", celllibfilePath, "-e", files?.join(" ") ?? ""],
      { cwd: projectContext.project?.path }
    );

    command.stdout.on("data", (data) => {
      setStatusText(data);
    });

    command.execute().then(() => {
      props.setActive(props.index + 1);
      showSuccessNotification({ title: "Import", message: "Import completed successfully" });
    }, (err) => {
      console.error(err);
      showSuccessNotification({ title: "Import", message: "Import failed" });
    });
  };

  return (
    <Flow
      flowName="dc.import"
      onRun={run}
      settingsPage={<EmptySettingsHint />}
      runAvailable={props.runAvailable}
      status={statusText}
    />
  );
}

function DCMapFlow(props: FlowProps) {
  return (
    <Flow
      flowName="dc.map"
      onRun={() => {}}
      settingsPage={<EmptySettingsHint />}
      runAvailable={props.runAvailable}
      status=""
    />
  );
}

function DCPackFlow(props: FlowProps) {
  return (
    <Flow
      flowName="dc.pack"
      onRun={() => {}}
      settingsPage={<EmptySettingsHint />}
      runAvailable={props.runAvailable}
      status=""
    />
  );
}

function DCPlaceFlow(props: FlowProps) {
  const { t } = useTranslation();

  const settings = (
    <>
      <SettingsItem
        label={t("flow.mode")}
        component={<SegmentedControl data={["Timing Driven", "Bounding Box"]} onChange={() => {}} />}
      />
    </>
  );

  return (
    <Flow flowName="dc.place" onRun={() => {}} settingsPage={settings} runAvailable={props.runAvailable} status="" />
  );
}

function DCRouteFlow(props: FlowProps) {
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

  const { t } = useTranslation();

  const settings = (
    <>
      <SettingsItem label={t("flow.mode")} component={<ModeSettingItem />} />
    </>
  );

  return (
    <Flow flowName="dc.route" onRun={() => {}} settingsPage={settings} runAvailable={props.runAvailable} status="" />
  );
}

function DCGenBitFlow(props: FlowProps) {
  return (
    <Flow
      flowName="dc.genbit"
      onRun={() => {}}
      settingsPage={<EmptySettingsHint />}
      runAvailable={props.runAvailable}
      status=""
    />
  );
}

function DCFlows() {
  const { t } = useTranslation();
  const [active, setActive] = useState(0);
  const projectContext = useContext(ProjectContext);
  const project = projectContext.project;

  const flows = [
    { name: "dc.import", component: DCImportFlow, target_file: "dc_imp.xml" },
    { name: "dc.map", component: DCMapFlow, target_file: "dc_map.xml" },
    { name: "dc.pack", component: DCPackFlow, target_file: "dc_pack.xml" },
    { name: "dc.place", component: DCPlaceFlow, target_file: "dc_place.xml" },
    { name: "dc.route", component: DCRouteFlow, target_file: "dc_route.xml" },
    { name: "dc.genbit", component: DCGenBitFlow, target_file: "dc_genbit.xml" },
  ];

  useEffect(() => {
    const projectName = project?.name;
    (async () => {
      for (let i = 0; i < flows.length; i++) {
        const flow = flows[i];
        if (flow.target_file) {
          const fileName = projectName + "_" + flow.target_file;
          if (await exists(project?.path + "/" + fileName)) {
            setActive(i + 1);
          }
        } else {
          break;
        }
      }
    })();
  });

  return (
    <Timeline bulletSize={24} style={{ padding: "20px 20px" }} active={active}>
      {flows.map((flow, index) => {
        return (
          <Timeline.Item title={t("flow." + flow.name + ".title")} color="blue" className="flowItem" key={index}>
            {flow.component ? (
              <flow.component runAvailable={active >= index} index={index} setActive={setActive} />
            ) : (
              <></>
            )}
          </Timeline.Item>
        );
      })}
    </Timeline>
  );
}

function FlowPage() {
  const [flow, setFlow] = useState("DC");
  return (
    <Stack gap="md">
      <SegmentedControl data={flowData} value={flow} onChange={setFlow} />
      <ScrollArea style={{ height: "calc(100vh - 150px)" }}>{flow === "DC" && <DCFlows />}</ScrollArea>
    </Stack>
  );
}

export default FlowPage;
