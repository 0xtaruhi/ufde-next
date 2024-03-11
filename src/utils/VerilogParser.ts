import { readTextFile } from "@tauri-apps/api/fs";

interface PortInfo {
    direction: "input" | "output" | "inout" | unknown;
    leftBound: number;
    rightBound: number;
    name: string;
}

export async function getAllPorts(file: string) {
    const fileContent = await readTextFile(file);

    // split by module
    const modules = fileContent.match(/module[\s\S]*?endmodule/g);
    if (!modules) {
        return [];
    }

    const ports: Map<string, PortInfo[]> = new Map();
    for (const module of modules) {
        const moduleName = module.match(/module\s+(\w+)\s*\(/);
        if (!moduleName) {
            continue;
        }

        const regExpPorts = /(input|output|inout)\s+((reg|wire|logic)\s+)?(\[\d+:\d+\]\s+)?((\w+\s*,\s*)*\w+\s*[;,\)])/g;
        const modulePorts = module.matchAll(regExpPorts);

        if (!modulePorts) {
            ports.set(moduleName[1], []);
        }

        const portInfo: PortInfo[] = [];
        for (const port of modulePorts) {
            const direction = port[1] as "input" | "output" | "inout";
            const leftBound = port[4] ? Number(port[4].match(/\d+/)) : 0;
            const rightBound = port[4] ? Number(port[4].match(/:(\d+)/)) : 0;
            const names = port[5].split(",").map((name: string) => name.trim().replace(/[;,]/, ""));

            for (const name of names) {
                portInfo.push({
                    direction,
                    leftBound,
                    rightBound,
                    name,
                });
            }
        }
        ports.set(moduleName[1], portInfo);
    }

    return ports;
}
