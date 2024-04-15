import { parse } from "https://deno.land/std/flags/mod.ts";
import { mkdirSync, writeFileSync } from "https://deno.land/std/fs/mod.ts";
import { join } from "https://deno.land/std/path/mod.ts";

const args = parse(Deno.args);
const command: string = args._[0] || "";

// switch (command) {
//   case "init":
//     createGitDirectory();
//     break;
//   default:
//     throw new Error(`Unknown command ${command}`);
// }

// function createGitDirectory(): void {
//   mkdirSync(join(Deno.cwd(), ".git"), { recursive: true });
//   mkdirSync(join(Deno.cwd(), ".git", "objects"), { recursive: true });
//   mkdirSync(join(Deno.cwd(), ".git", "refs"), { recursive: true });

//   writeFileSync(join(Deno.cwd(), ".git", "HEAD"), "ref: refs/heads/main\n");
//   console.log("Initialized git directory");
// }
