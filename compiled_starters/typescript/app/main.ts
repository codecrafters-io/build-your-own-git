const args = Deno.args;
const command = args[0];

enum Commands {
    Init = "init",
}

switch (command) {
    case Commands.Init:
        // You can use print statements as follows for debugging, they'll be visible when running tests.
        console.log("Logs from your program will appear here!");

        // Uncomment this block to pass the first stage
        // Deno.mkdirSync(".git", { recursive: true });
        // Deno.mkdirSync(".git/objects", { recursive: true });
        // Deno.mkdirSync(".git/refs", { recursive: true });
        // Deno.writeTextFileSync(".git/HEAD", "ref: refs/heads/main\n");
        // console.log("Initialized git directory");
        break;
    default:
        throw new Error(`Unknown command ${command}`);
}
