The entry point for your Git implementation is in `Sources/main.swift`.

Study and uncomment the relevant code:

```swift
// Uncomment this block to pass the first stage
if CommandLine.arguments.count < 2 {
   throw ArgumentError.missingCommand
}

switch CommandLine.arguments[1] {
case "init":
   try createGitDirectory()
default:
   throw ArgumentError.unknownCommand
}

enum ArgumentError: Error {
   case missingCommand
   case unknownCommand
}

func createGitDirectory() throws {
   let currentPath = FileManager.default.currentDirectoryPath
   let gitFolder = currentPath + "/.git"
   try FileManager.default.createDirectory(atPath: gitFolder, withIntermediateDirectories: true)
   let objectFolder = gitFolder + "/objects"
   try FileManager.default.createDirectory(atPath: objectFolder, withIntermediateDirectories: true)
   let refsFolder = gitFolder + "/refs"
   try FileManager.default.createDirectory(atPath: refsFolder, withIntermediateDirectories: true)

   let head = "ref: refs/heads/master\n"
   let headPath = gitFolder + "/HEAD"
   try head.write(toFile: headPath, atomically: true, encoding: .utf8)
}
```

Push your changes to pass the first stage:

```
git add .
git commit -m "pass 1st stage" # any msg
git push origin master
```
