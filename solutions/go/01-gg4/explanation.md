The entry point for your Git implementation is in `app/main.go`.

Study and uncomment the relevant code: 

```go
// Uncomment this block to pass the first stage!

for _, dir := range []string{".git", ".git/objects", ".git/refs"} {
	if err := os.MkdirAll(dir, 0755); err != nil {
		fmt.Fprintf(os.Stderr, "Error creating directory: %s\n", err)
	}
}

headFileContents := []byte("ref: refs/heads/main\n")
if err := os.WriteFile(".git/HEAD", headFileContents, 0644); err != nil {
	fmt.Fprintf(os.Stderr, "Error writing file: %s\n", err)
}

fmt.Println("Initialized git directory")
```

Push your changes to pass the first stage:

```
git add .
git commit -m "pass 1st stage" # any msg
git push origin master
```
