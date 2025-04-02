import {
  ActionIcon,
  Combobox,
  InputBase,
  SegmentedControl,
  Tooltip,
  useCombobox,
} from "@mantine/core";
import { TbArrowAutofitDown, TbChevronDown } from "react-icons/tb";
import {
  showFailedNotification,
  showSuccessNotification,
} from "../pages/Notifies";
import { invoke } from "@tauri-apps/api/core";
import { useContext } from "react";
import { getDirOfFile } from "../utils/utils";
import { ProjectContext } from "../App";
import { Command } from "@tauri-apps/plugin-shell";
import { resolveResource } from "@tauri-apps/api/path";
import { useTranslation } from "react-i18next";
import { ProjectInfo } from "../model/project";
import { SettingsItem } from "../pages/FlowPage";

async function runYosysYosysFlowCommand(project: ProjectInfo) {
  const xmlfileMap = project?.name + "_yosys_" + "syn.edf";
  const tclScript = await resolveResource("resource/yosys/yosys_fde.tcl");
  const simlibFile = await resolveResource("resource/yosys/fdesimlib.v");
  const techmapFile = await resolveResource("resource/yosys/techmap.v");
  const cellsMapFile = await resolveResource("resource/yosys/cells_map.v");
  const inputFiles = project?.file_lists
    ?.filter((file) => file.type === "verilog" || file.type === "systemverilog")
    .map((file) => file.path);
  const tclLine =
    "tcl " +
    tclScript +
    " -l " +
    simlibFile +
    " -m " +
    techmapFile +
    " -c " +
    cellsMapFile +
    " -o " +
    xmlfileMap;
  const command = Command.sidecar(
    "binaries/yosys",
    ["-p", tclLine, inputFiles.join(" ")],
    { cwd: await getDirOfFile(project.path) }
  );
  return command;
}

export async function runYosysMapFlowCommand(project: ProjectInfo) {
  // const files = project?.file_lists
  //     ?.filter((file) => file.type === "verilog" || file.type === "systemverilog")
  //     .map((file) => file.path);

  const celllibfilePath = await resolveResource("resource/hw_lib/dc_cell.xml");
  const mapArgs = "";
  const mapFileMode = "";

  const inputFileName = project?.name + "_yosys_" + "syn.edf";
  const outputFileName = project?.name + "_yosys_" + "map.xml";

  const command = Command.sidecar(
    "binaries/fde-cli/map",
    [
      "-y",
      "-i",
      inputFileName,
      "-o",
      outputFileName,
      "-c",
      celllibfilePath,
      mapArgs,
      mapFileMode,
      "-e",
      // files?.join(" ") ?? "",
    ],
    { cwd: await getDirOfFile(project.path) }
  );

  return command;
}

export async function runYosysPackFlowCommand(project: ProjectInfo) {
  const family = "fdp3";
  const yosyscelllibfilePath = await resolveResource(
    "resource/hw_lib/fdp3_cell.xml"
  );
  const yosysplibfilePath = await resolveResource(
    "resource/hw_lib/fdp3_dcplib.xml"
  );
  const xdlcfgfilePath = await resolveResource(
    "resource/hw_lib/fdp3_config.xml"
  );

  const inputFileName = project.name + "_yosys_" + "map.xml";
  const outputFileName = project.name + "_yosys_" + "pack.xml";

  const command = Command.sidecar(
    "binaries/fde-cli/pack",
    [
      "-c",
      family,
      "-n",
      inputFileName,
      "-l",
      yosyscelllibfilePath,
      "-r",
      yosysplibfilePath,
      "-o",
      outputFileName,
      "-g",
      xdlcfgfilePath,
      "-e",
    ],
    { cwd: await getDirOfFile(project.path) }
  );

  return command;
}

export function YosysPlaceFlowSettingsPage() {
  const { t } = useTranslation();

  const projectContext = useContext(ProjectContext);
  const { project, setProject, setProjectModified } = projectContext;

  const settings = (
    <>
      <SettingsItem
        label={t("flow.mode")}
        component={
          <SegmentedControl
            data={["Timing Driven", "Bounding Box"]}
            onChange={(value) => {
              var newProject = project!;
              newProject.settings.place.mode = value as
                | "Timing Driven"
                | "Bounding Box";
              setProject(newProject);
              setProjectModified(true);
            }}
            defaultValue={project?.settings.place.mode}
          />
        }
      />
    </>
  );
  return settings;
}

export async function runYosysPlaceFlowCommand(project: ProjectInfo) {
  const archfilePath = await resolveResource("resource/hw_lib/fdp3p7_arch.xml");
  const plcdelayfilePath = await resolveResource(
    "resource/hw_lib/fdp3p7_dly.xml"
  );
  const placecst = "-c";
  const placecstFilePath = project.file_lists.filter(
    (file) => file.type === "constraint"
  )[0].path;
  const getPlaceMode = () => {
    if (project.settings.place.mode === "Bounding Box") {
      return "-b";
    } else {
      return "-t";
    }
  };
  const placeMode = getPlaceMode();

  const inputFileName = project.name + "_yosys_" + "pack.xml";
  const outputFileName = project.name + "_yosys_" + "place.xml";

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
    { cwd: await getDirOfFile(project.path) }
  );

  return command;
}

export async function runYosysRouteFlowCommand(project: ProjectInfo) {
  const archfilePath = await resolveResource("resource/hw_lib/fdp3p7_arch.xml");
  const getRouteMode = () => {
    if (project.settings.route.mode === "Direct Search") {
      return "-d";
    } else if (project.settings.route.mode === "Breath First") {
      return "-b";
    } else {
      return "-t";
    }
  };
  const routeMode = getRouteMode();
  const routecst = "-c";
  const routecstFilePath = project.file_lists.filter(
    (file) => file.type === "constraint"
  )[0].path;

  const inputFileName = project.name + "_yosys_" + "place.xml";
  const outputFileName = project.name + "_yosys_" + "route.xml";

  const command = Command.sidecar(
    "binaries/fde-cli/route",
    [
      "-a",
      archfilePath,
      "-n",
      inputFileName,
      "-o",
      outputFileName,
      routeMode,
      routecst,
      routecstFilePath,
      "-e",
    ],
    { cwd: await getDirOfFile(project.path) }
  );

  return command;
}

export function YosysRouteFlowSettingsPage() {
  function ModeSettingItem() {
    const combobox = useCombobox({
      onDropdownClose: () => combobox.resetSelectedOption(),
    });

    const projectContext = useContext(ProjectContext);
    const { project, setProject, setProjectModified } = projectContext;

    const modes = ["Direct Search", "Breath First", "Timing Driven"];
    const options = modes.map((mode) => (
      <Combobox.Option key={mode} value={mode}>
        {mode}
      </Combobox.Option>
    ));

    return (
      <Combobox
        onOptionSubmit={(value) => {
          const newValue = value as
            | "Direct Search"
            | "Breath First"
            | "Timing Driven";
          var newProject = project!;
          newProject.settings.route.mode = newValue;
          setProject(newProject);
          setProjectModified(true);
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
            {project?.settings.route.mode}
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

export async function runYosysGenBitFlowCommand(project: ProjectInfo) {
  const archfilePath = await resolveResource("resource/hw_lib/fdp3p7_arch.xml");
  const cilfilePath = await resolveResource("resource/hw_lib/fdp3p7_cil.xml");

  const inputFileName = project.name + "_yosys_" + "route.xml";
  const outputFileName = project.name + "_yosys_" + "bit.bit";

  const command = Command.sidecar(
    "binaries/fde-cli/bitgen",
    [
      "-a",
      archfilePath,
      "-c",
      cilfilePath,
      "-n",
      inputFileName,
      "-b",
      outputFileName,
      "-e",
    ],
    { cwd: await getDirOfFile(project.path) }
  );

  return command;
}

function YosysDownloadBitAction() {
  const { project } = useContext(ProjectContext);

  if (!project || !project.path) {
    return null;
  }

  const { t } = useTranslation();

  const downloadBitFile = async () => {
    if (project) {
      const bitFile =
        (await getDirOfFile(project.path)) +
        project.name +
        "_yosys_" +
        "bit.bit";

      invoke("program_fpga", { bitfile: bitFile }).then(
        () => {
          showSuccessNotification({
            title: t("program.success"),
            message: bitFile,
          });
        },
        (err) => {
          showFailedNotification({
            title: t("program.failed"),
            message: t("program.error." + err),
          });
        }
      );
    }
  };

  return (
    <Tooltip label={t("program.program")}>
      <ActionIcon
        size="md"
        variant="subtle"
        onClick={downloadBitFile}
        style={{ padding: "5px" }}
      >
        <TbArrowAutofitDown size={20} />
      </ActionIcon>
    </Tooltip>
  );
}

export const yosysFlows = [
  {
    name: "yosys.yosys",
    target_file: "yosys_syn.edf",
    runFunc: runYosysYosysFlowCommand,
  },
  {
    name: "yosys.map",
    target_file: "yosys_map.xml",
    runFunc: runYosysMapFlowCommand,
  },
  {
    name: "yosys.pack",
    target_file: "yosys_pack.xml",
    runFunc: runYosysPackFlowCommand,
  },
  {
    name: "yosys.place",
    target_file: "yosys_place.xml",
    runFunc: runYosysPlaceFlowCommand,
    settingsPage: <YosysPlaceFlowSettingsPage />,
  },
  {
    name: "yosys.route",
    target_file: "yosys_route.xml",
    runFunc: runYosysRouteFlowCommand,
    settingsPage: <YosysRouteFlowSettingsPage />,
  },
  {
    name: "yosys.genbit",
    target_file: "yosys_bit.bit",
    runFunc: runYosysGenBitFlowCommand,
    extraActions: <YosysDownloadBitAction />,
  },
];
