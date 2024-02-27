import { platform } from "@tauri-apps/api/os";

export default async function isWindowsPlatform() {
    const platformName = await platform();
    return platformName.startsWith("win");
}
