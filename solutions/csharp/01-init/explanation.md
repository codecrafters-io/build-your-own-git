The entry point for your Git implementation is in `src/Program.cs`.

Study and uncomment the relevant code: 

```csharp
// Uncomment this block to pass the first stage

Directory.CreateDirectory(".git");
Directory.CreateDirectory(".git/objects");
Directory.CreateDirectory(".git/refs");
File.WriteAllText(".git/HEAD", "ref: refs/heads/main\n");
Console.WriteLine("Initialized git directory");
```

Push your changes to pass the first stage:

```
git add .
git commit -m "pass 1st stage" # any msg
git push origin master
```
