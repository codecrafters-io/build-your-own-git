The entry point for your Git implementation is in `app/main.js`.

Study and uncomment the relevant code: 

```javascript
// Uncomment this block to pass the first stage
const command = process.argv[2];

switch (command) {
  case "init":
    createGitDirectory();
    break;
  default:
    throw new Error(`Unknown command ${command}`);
}

function createGitDirectory() {
  fs.mkdirSync(path.join(__dirname, ".git"), { recursive: true });
  fs.mkdirSync(path.join(__dirname, ".git", "objects"), { recursive: true });
  fs.mkdirSync(path.join(__dirname, ".git", "refs"), { recursive: true });

  fs.writeFileSync(
    path.join(__dirname, ".git", "HEAD"),
    "ref: refs/heads/master\n",
  );
  console.log("Initialized git directory");
}
```

Push your changes to pass the first stage:

```
git add .
git commit -m "pass 1st stage" # any msg
git push origin master
```
