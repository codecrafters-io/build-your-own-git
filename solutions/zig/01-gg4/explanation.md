The entry point for your Git implementation is in `src/main.zig`.

Study and uncomment the relevant code: 

```zig
// Uncomment this block to pass the first stage
const cwd = std.fs.cwd();
_ = try cwd.makeDir("./.git");
_ = try cwd.makeDir("./.git/objects");
_ = try cwd.makeDir("./.git/refs");
{
    const head = try cwd.createFile("./.git/HEAD", .{});
    defer head.close();
    _ = try head.write("ref: refs/heads/main\n");
}
_ = try stdout.print("Initialized git directory\n", .{});
```

Push your changes to pass the first stage:

```
git add .
git commit -m "pass 1st stage" # any msg
git push origin master
```
