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
  Button,
  Collapse,
  Textarea,
} from "@mantine/core";
import {
  TbSettings,
  TbPlayerPlay,
  TbPlayerPlayFilled,
  TbInfoCircle,
  TbInfoCircleFilled,
} from "react-icons/tb";
import { useDisclosure } from "@mantine/hooks";
import { createRef, useState } from "react";
import "./FlowPage.css";
import { useTranslation } from "react-i18next";
import { Command } from "@tauri-apps/api/shell";
import { useContext } from "react";
import { ProjectContext } from "../App";
import { useEffect } from "react";
import { exists } from "@tauri-apps/api/fs";
import {
  update2FailedNotification,
  update2SuccessNotification,
} from "./Notifies";
import { notifications } from "@mantine/notifications";
import { ProjectInfo } from "../model/project";
import { useCallback } from "react";
import { dcFlows } from "../flows/dc";
import { getDirOfFile } from "../utils/utils";
import { yosysFlows } from "../flows/yosys";

const flowData: {
  value: string;
  label: string;
  data: FlowInfo[];
}[] = [
  { value: "DC", label: "DC", data: dcFlows },
  { value: "Yosys", label: "Yosys", data: yosysFlows },
];

const flowsNameMap = (name: string) => {
  return flowData.find((flow) => flow.value === name)?.data;
};

interface AbstractFlowProps {
  flowName: string;
  onRun: () => void;
  runAvailable: boolean;
  settingsPage: React.ReactNode;
  status: string;
  extraActions?: React.ReactNode;
}

export function Flow(props: AbstractFlowProps) {
  const { t } = useTranslation();
  const [opened, { open, close }] = useDisclosure(false);
  const [collapaseOpened, { toggle: toggleCollapse }] = useDisclosure(false);
  const textAreaRef = createRef<HTMLTextAreaElement>();

  return (
    <>
      <Drawer
        opened={opened}
        onClose={close}
        padding="md"
        size={350}
        position="right"
      >
        <Stack gap="md">
          <Text size="md" className="flowSettingsTitle">
            <b>{t("flow.settings")}</b> -{" "}
            {t("flow." + props.flowName + ".title")}
          </Text>
          {props.settingsPage}
        </Stack>
      </Drawer>
      <Flex justify="space-between">
        <Text c="dimmed" size="sm">
          {t("flow." + props.flowName + ".description")}
        </Text>
        <Group>
          {props.extraActions}
          <ActionIcon
            size="md"
            variant="subtle"
            onClick={() => {
              toggleCollapse();
              if (textAreaRef.current) {
                textAreaRef.current.scrollTop =
                  textAreaRef.current.scrollHeight;
              }
            }}
            style={{ padding: "5px" }}
          >
            {collapaseOpened ? (
              <TbInfoCircleFilled size={20} />
            ) : (
              <TbInfoCircle size={20} />
            )}
          </ActionIcon>
          <ActionIcon
            size="md"
            variant="subtle"
            onClick={open}
            style={{ padding: "5px" }}
          >
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
        <Collapse in={collapaseOpened}>
          <Textarea
            value={props.status}
            size="sm"
            readOnly
            rows={5}
            ref={textAreaRef}
          />
        </Collapse>
      )}
    </>
  );
}

export function EmptySettingsHint() {
  const { t } = useTranslation();
  return <Text c="dimmed">{t("flow.no-settings-available")}</Text>;
}

export function SettingsItem({
  label,
  component,
}: {
  label: string;
  component: React.ReactNode;
}) {
  return (
    <Group justify="space-between">
      <Text size="md">{label}</Text>
      {component}
    </Group>
  );
}

export interface FlowProps {
  index: number;
  runAvailable: boolean;
  setActive: (index: number) => void;
}

interface FlowInfo {
  name: string;
  target_file?: string;
  runFunc?: (project: ProjectInfo) => Promise<Command> | Promise<undefined>;
  settingsPage?: React.ReactNode;
  extraActions?: React.ReactNode;
}

function FlowInstance(props: FlowInfo & FlowProps) {
  const { t } = useTranslation();
  const projectContext = useContext(ProjectContext);

  const [statusText, setStatusText] = useState<string>("");

  const run = async () => {
    setStatusText("");
    const command = props.runFunc
      ? await props.runFunc(projectContext.project!)
      : undefined;
    if (command) {
      command.stdout.on("data", (data) => {
        setStatusText((prevTest) => prevTest + data);
      });
      command.stderr.on("data", (data) => {
        setStatusText((prevTest) => prevTest + data);
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

      const onSuccess = () => {
        props.setActive(props.index + 1);
        update2SuccessNotification({
          id: notifyId,
          title: t("flow." + props.name + ".title"),
          message:
            t("flow.notify.success.message_prefix") +
            t("flow." + props.name + ".title") +
            t("flow.notify.success.message_suffix"),
        });
      };

      const onError = (err: any) => {
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
      };

      command.execute().then((res) => {
        if (res.code !== 0) {
          onError("Code = " + res.code);
        } else {
          onSuccess();
        }
      }, onError);
    }
  };

  return (
    <Flow
      flowName={props.name}
      onRun={run}
      settingsPage={
        props.settingsPage ? props.settingsPage : <EmptySettingsHint />
      }
      // runAvailable={true}
      runAvailable={props.runAvailable}
      status={statusText}
      extraActions={props.extraActions}
    />
  );
}

function FlowItems(props: {
  flows: FlowInfo[];
  active: number;
  setActive: (index: number) => void;
}) {
  const { t } = useTranslation();
  const projectContext = useContext(ProjectContext);
  const project = projectContext.project;

  useEffect(() => {
    const projectName = project?.name;
    let tmpActive = 0;
    (async () => {
      const projectDir = await getDirOfFile(project?.path!);
      for (let i = 0; i < props.flows.length; i++) {
        const flow = props.flows[i];
        if (flow.target_file) {
          const fileName = projectName + "_" + flow.target_file;
          if (await exists(projectDir + "/" + fileName)) {
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
    <Timeline
      bulletSize={24}
      style={{ padding: "20px 20px" }}
      active={props.active}
    >
      {props.flows.map((flow, index) => {
        return (
          <Timeline.Item
            title={t("flow." + flow.name + ".title")}
            className="flowItem"
            key={index}
          >
            <FlowInstance
              name={flow.name}
              runFunc={flow.runFunc}
              runAvailable={props.active >= index}
              index={index}
              setActive={props.setActive}
              settingsPage={flow.settingsPage}
              extraActions={flow.extraActions}
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
    let runSuccess = false;

    const onSuccess = () => {
      setActive(active + 1);
      update2SuccessNotification({
        id: notifyId,
        title: t("flow." + flow.name + ".title"),
        message:
          t("flow.notify.success.message_prefix") +
          t("flow." + flow.name + ".title") +
          t("flow.notify.success.message_suffix"),
      });
      runSuccess = true;
    };

    const onError = (err: any) => {
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
    };

    if (command) {
      await command.execute().then((res) => {
        if (res.code !== 0) {
          onError("Code = " + res.code);
        } else {
          onSuccess();
        }
      }, onError);
    }
    return runSuccess;
  };

  const [active, setActive] = useState(0);

  const runAll = useCallback(async () => {
    const flows = flowsNameMap(flowName)!;
    setActive(0);

    for (let i = 0; i < flows.length; i++) {
      const flow = flows[i];
      if (!(await run(flow))) {
        break;
      }
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
            style={{ width: "200px", marginRight: "auto" }}
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
          {
            <FlowItems
              flows={flowsNameMap(flowName)!}
              active={active}
              setActive={setActive}
            />
          }
        </ScrollArea>
      </Stack>
    </>
  );
}

export default FlowPage;
