import { platform } from "@tauri-apps/api/os";
import { SourceFile } from "../model/project";
import { DialogFilter } from "@tauri-apps/api/dialog";
import { open } from "@tauri-apps/api/dialog";

export default async function isWindowsPlatform() {
    const platformName = await platform();
    return platformName.startsWith("win");
}

export
    async function getDirOfFile(path: string) {
    if (await isWindowsPlatform()) {
        return path.split("\\").slice(0, -1).join("\\");
    } else {
        return path.split("/").slice(0, -1).join("/");
    }
}


export async function getSourceFilesByDialog({ dialogFilter }: { dialogFilter: DialogFilter[] | undefined }) {
  const result = open({
    multiple: true,
    filters: dialogFilter,
  });

  return result;
}

export async function getFileInfoByPath(path: string): Promise<SourceFile> {
    function getTypeByExtension(ext: string) {
        switch (ext) {
            case "v":
                return "verilog";
            case "sv":
                return "systemverilog";
            case "xml":
                return "constraint";
            default:
                return "unknown";
        }
    }
    const platformName = await platform();
    const splitChar = /^win/i.test(platformName) ? "\\" : "/";
    const arr = path.split(splitChar);
    const name = arr[arr.length - 1];
    const type = getTypeByExtension(name.split(".")[1]);
    return { name: name, path: path, type: type };
}