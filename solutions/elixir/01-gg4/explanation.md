The entry point for your Git implementation is in `lib/main.ex`.

Study and uncomment the relevant code: 

```elixir
# Uncomment this block to pass the first stage

case argv do
  ["init" | _] ->
    :ok = File.mkdir_p(".git")
    :ok = File.mkdir_p(".git/objects")
    :ok = File.mkdir_p(".git/refs")
    :ok = File.write(".git/HEAD", "ref: refs/heads/main\n")
    IO.puts("Initialized git directory")

  [command | _] ->
    IO.puts("Unknown command: #{command}")
    System.halt(1)

  [] ->
    IO.puts("Usage: your_program.sh <command> <args>")
    System.halt(1)
end
```

Push your changes to pass the first stage:

```
git add .
git commit -m "pass 1st stage" # any msg
git push origin master
```
