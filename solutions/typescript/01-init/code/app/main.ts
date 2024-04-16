const args = Deno.args;
const command = args[0];

enum Commands {
  Init = "init",
}

switch (command) {
  case Commands.Init:
    createGitDirectory();
    break;
  default:
    throw new Error(`Unknown command ${command}`);
}

function createGitDirectory() {
  Deno.mkdirSync(".git", { recursive: true });
  Deno.mkdirSync(".git/objects", { recursive: true });
  Deno.mkdirSync(".git/refs", { recursive: true });

  const encoder = new TextEncoder();
  const data = encoder.encode("ref: refs/heads/main\n");
  Deno.writeFileSync(".git/HEAD", data);
  console.log("Initialized git directory");
}
