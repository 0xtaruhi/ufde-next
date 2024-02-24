import { platform } from "@tauri-apps/api/os";

export default async function isWindowsPlatform() {
    const platformName = await platform();
    return platformName.includes("win");
}

export
    async function getDirOfFile(path: string) {
    if (await isWindowsPlatform()) {
        return path.split("\\").slice(0, -1).join("\\");
    } else {
        return path.split("/").slice(0, -1).join("/");
    }
}