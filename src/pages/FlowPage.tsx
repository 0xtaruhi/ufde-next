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

const flowData = [
  { value: "DC", label: "DC" },
  { value: "Yosys", label: "Yosys" },
];

function Flow({
  flowName,
  onRun,
  runAvailable,
  settingsPage,
}: {
  flowName: string;
  onRun: () => void;
  runAvailable: boolean;
  settingsPage: React.ReactNode;
}) {
  const { t } = useTranslation();
  const [opened, { open, close }] = useDisclosure(false);

  return (
    <>
      <Drawer opened={opened} onClose={close} padding="md" size={350} position="right">
        <Stack gap="md">
          <Text size="md" className="flowSettingsTitle">
            <b>{t("flow.settings")}</b> - {t("flow." + flowName + ".title")}
          </Text>
          {settingsPage}
        </Stack>
      </Drawer>
      <Flex justify="space-between">
        <Text c="dimmed" size="sm">
          {t("flow." + flowName + ".description")}
        </Text>
        <Group>
          <ActionIcon size="sm" variant="subtle" onClick={open} style={{ padding: "5px" }}>
            <TbSettings size={20} />
          </ActionIcon>
          <ActionIcon size="sm" variant="subtle" onClick={onRun} style={{ padding: "5px" }} disabled={!runAvailable}>
            <TbPlayerPlay size={20} />
          </ActionIcon>
        </Group>
      </Flex>
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

function DCImportFlow({
  runAvailable,
  active,
  setActive,
}: {
  runAvailable: boolean;
  active: number;
  setActive: (arg0: number) => void;
}) {
  return (
    <Flow
      flowName="dc.import"
      onRun={() => {
        setActive(active + 1);
      }}
      settingsPage={<EmptySettingsHint />}
      runAvailable={runAvailable}
    />
  );
}

function DCMapFlow({
  runAvailable,
  active,
  setActive,
}: {
  runAvailable: boolean;
  active: number;
  setActive: (arg0: number) => void;
}) {
  return (
    <Flow
      flowName="dc.map"
      onRun={() => {
        setActive(active + 1);
      }}
      settingsPage={<EmptySettingsHint />}
      runAvailable={runAvailable}
    />
  );
}

function DCPackFlow({
  runAvailable,
  active,
  setActive,
}: {
  runAvailable: boolean;
  active: number;
  setActive: (arg0: number) => void;
}) {
  return (
    <Flow
      flowName="dc.pack"
      onRun={() => {
        setActive(active + 1);
      }}
      settingsPage={<EmptySettingsHint />}
      runAvailable={runAvailable}
    />
  );
}

function DCPlaceFlow({
  runAvailable,
  active,
  setActive,
}: {
  runAvailable: boolean;
  active: number;
  setActive: (arg0: number) => void;
}) {
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
    <Flow
      flowName="dc.place"
      onRun={() => {
        setActive(active + 1);
      }}
      settingsPage={settings}
      runAvailable={runAvailable}
    />
  );
}

function DCRouteFlow({
  runAvailable,
  active,
  setActive,
}: {
  runAvailable: boolean;
  active: number;
  setActive: (arg0: number) => void;
}) {
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
    <Flow
      flowName="dc.route"
      onRun={() => {
        setActive(active + 1);
      }}
      settingsPage={settings}
      runAvailable={runAvailable}
    />
  );
}

function DCGenBitFlow({
  runAvailable,
  active,
  setActive,
}: {
  runAvailable: boolean;
  active: number;
  setActive: (arg0: number) => void;
}) {
  return (
    <Flow
      flowName="dc.genbit"
      onRun={() => {
        setActive(active + 1);
      }}
      settingsPage={<EmptySettingsHint />}
      runAvailable={runAvailable}
    />
  );
}

function DCFlows() {
  const { t } = useTranslation();
  const [active, setActive] = useState(1);

  const flows = [
    { name: "dc.import", component: DCImportFlow },
    { name: "dc.map", component: DCMapFlow },
    { name: "dc.pack", component: DCPackFlow },
    { name: "dc.place", component: DCPlaceFlow },
    { name: "dc.route", component: DCRouteFlow },
    { name: "dc.genbit", component: DCGenBitFlow },
  ];

  return (
    <Timeline bulletSize={24} style={{ padding: "20px 20px" }} active={active}>
      {flows.map((flow, index) => {
        return (
          <Timeline.Item title={t("flow." + flow.name + ".title")} color="blue" className="flowItem">
            {flow.component ? (
              <flow.component runAvailable={active === index + 1} active={active} setActive={setActive} />
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
