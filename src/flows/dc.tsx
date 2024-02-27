import { resolveResource } from "@tauri-apps/api/path";
import { ProjectInfo } from "../model/project";
import { Command } from "@tauri-apps/api/shell";
import { Combobox, InputBase, SegmentedControl, useCombobox } from "@mantine/core";
import { useState } from "react";
import { TbChevronDown } from "react-icons/tb";
import { SettingsItem } from "../pages/FlowPage";
import { useTranslation } from "react-i18next";
import { getDirOfFile } from "../utils/utils";

export async function runDCImportFlowCommand(project: ProjectInfo) {
  const files = project.file_lists
    ?.filter((file) => file.type === "verilog" || file.type === "systemverilog")
    .map((file) => file.path);

  const celllibfilePath = await resolveResource("resource/hw_lib/dc_cell.xml");
  const outputFileName = project.name + "_dc_" + "imp.xml";

  const command = Command.sidecar(
    "binaries/fde-cli/import",
    ["-x", outputFileName, "-l", celllibfilePath, "-e", files?.join(" ") ?? ""],
    { cwd: await getDirOfFile(project.path) }
  );

  return command;
}

export async function runDCMapFlowCommand(project: ProjectInfo) {
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
    { cwd: await getDirOfFile(project.path) }
  );

  return command;
}

export async function runDCPackFlowCommand(project: ProjectInfo) {
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
    { cwd: await getDirOfFile(project.path) }
  );

  return command;
}

export function DCPlaceFlowSettingsPage() {
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

export async function runDCPlaceFlowCommand(project: ProjectInfo) {
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
    { cwd: await getDirOfFile(project.path) }
  );

  return command;
}

export async function runDCRouteFlowCommand(project: ProjectInfo) {
  const archfilePath = await resolveResource("resource/hw_lib/fdp3p7_arch.xml");
  const routeMode = "-d";
  const routecst = "-c";
  const routecstFilePath = project.file_lists.filter((file) => file.type === "constraint")[0].path;

  const inputFileName = project.name + "_dc_" + "place.xml";
  const outputFileName = project.name + "_dc_" + "route.xml";

  const command = Command.sidecar(
    "binaries/fde-cli/route",
    ["-a", archfilePath, "-n", inputFileName, "-o", outputFileName, routeMode, routecst, routecstFilePath, "-e"],
    { cwd: await getDirOfFile(project.path) }
  );

  return command;
}

export function DCRouteFlowSettingsPage() {
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

export async function runDCGenBitFlowCommand(project: ProjectInfo) {
  const archfilePath = await resolveResource("resource/hw_lib/fdp3p7_arch.xml");
  const cilfilePath = await resolveResource("resource/hw_lib/fdp3p7_cil.xml");

  const inputFileName = project.name + "_dc_" + "route.xml";
  const outputFileName = project.name + "_dc_" + "bit.xml";

  const command = Command.sidecar(
    "binaries/fde-cli/bitgen",
    ["-a", archfilePath, "-c", cilfilePath, "-n", inputFileName, "-b", outputFileName, "-e"],
    { cwd: await getDirOfFile(project.path) }
  );

  return command;
}

export const dcFlows = [
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
