The entry point for your Git implementation is in `src/Program.cs`.

Study and uncomment the relevant code: 

```csharp
// Uncomment this block to pass the first stage

if (args.Length < 1) {
    Console.WriteLine("Please provide a command.");
    return;
}
string command = args[0];
if (command == "init") {
    Directory.CreateDirectory(".git");
    Directory.CreateDirectory(".git/objects");
    Directory.CreateDirectory(".git/refs");
    File.WriteAllText(".git/HEAD", "ref: refs/heads/main\n");
    Console.WriteLine("Initialized git directory");
} else {
    throw new ArgumentException($"Unknown command {command}");
}
```

Push your changes to pass the first stage:

```
git add .
git commit -m "pass 1st stage" # any msg
git push origin master
```
