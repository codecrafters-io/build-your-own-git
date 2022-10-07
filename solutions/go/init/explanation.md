The entry point for your Git implementation is in `cmd/mygit/main.go`.

Study and uncomment the relevant code: 

```go
// Uncomment this block to pass the first stage!
"os"
```

```go
// Uncomment this block to pass the first stage!

if len(os.Args) < 2 {
	fmt.Fprintf(os.Stderr, "usage: mygit <command> [<args>...]\n")
	os.Exit(1)
}

switch command := os.Args[1]; command {
case "init":
	for _, dir := range []string{".git", ".git/objects", ".git/refs"} {
		if err := os.Mkdir(dir, 0755); err != nil {
			fmt.Fprintf(os.Stderr, "Error creating directory: %s\n", err)
		}
	}

	headFileContents := []byte("ref: refs/heads/master\n")
	if err := os.WriteFile(".git/HEAD", headFileContents, 0644); err != nil {
		fmt.Fprintf(os.Stderr, "Error writing file: %s\n", err)
	}

	fmt.Println("Initialized git directory")

default:
	fmt.Fprintf(os.Stderr, "Unknown command %s\n", command)
	os.Exit(1)
}
```

Push your changes to pass the first stage:

```
git add .
git commit -m "pass 1st stage" # any msg
git push origin master
```
