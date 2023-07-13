The entry point for your Git implementation is in `Sources/swift-git-challenge/Main.swift`.

Study and uncomment the relevant code: 

```swift
// Uncomment this block to pass the first stage

guard CommandLine.argc >= 2 else {
    print("usage: mygit <command> [<args>...]")
    return
}

let command = CommandLine.arguments[1]
switch command {
case "init":
    let fileManager = FileManager.default

    try fileManager.createDirectory(atPath: ".git", withIntermediateDirectories: false)
    try fileManager.createDirectory(atPath: ".git/objects", withIntermediateDirectories: false)
    try fileManager.createDirectory(atPath: ".git/refs", withIntermediateDirectories: false)
    fileManager.createFile(atPath: ".git/HEAD", contents: "ref: refs/heads/master\n".data(using: .utf8))

    print("Initialized git directory")
default:
    print("Unknown command \(command)")
    return
}
```

Push your changes to pass the first stage:

```
git add .
git commit -m "pass 1st stage" # any msg
git push origin master
```
