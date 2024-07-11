const fs = require("fs");
const path = require("path");

// You can use print statements as follows for debugging, they'll be visible when running tests.
console.log("Logs from your program will appear here!");

// Uncomment this block to pass the first stage
// const command = process.argv[2];
//
// switch (command) {
//   case "init":
//     createGitDirectory();
//     break;
//   default:
//     throw new Error(`Unknown command ${command}`);
// }
//
// function createGitDirectory() {
//   fs.mkdirSync(path.join(process.cwd(), ".git"), { recursive: true });
//   fs.mkdirSync(path.join(process.cwd(), ".git", "objects"), { recursive: true });
//   fs.mkdirSync(path.join(process.cwd(), ".git", "refs"), { recursive: true });
//
//   fs.writeFileSync(path.join(process.cwd(), ".git", "HEAD"), "ref: refs/heads/main\n");
//   console.log("Initialized git directory");
// }
