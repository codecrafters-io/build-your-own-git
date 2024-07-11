import * as fs from 'fs';

const args = process.argv.slice(2);
const command = args[0];

enum Commands {
    Init = "init",
}

switch (command) {
    case Commands.Init:
        // You can use print statements as follows for debugging, they'll be visible when running tests.
        console.log("Logs from your program will appear here!");

        // Uncomment this block to pass the first stage
        // fs.mkdirSync(".git", { recursive: true });
        // fs.mkdirSync(".git/objects", { recursive: true });
        // fs.mkdirSync(".git/refs", { recursive: true });
        // fs.writeFileSync(".git/HEAD", "ref: refs/heads/main\n");
        // console.log("Initialized git directory");
        break;
    default:
        throw new Error(`Unknown command ${command}`);
}
