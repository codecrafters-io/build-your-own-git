The entry point for your Git implementation is in `app/main.go`.

Study and uncomment the relevant code: 

```go
// Uncomment this block to pass the first stage!
 "io/ioutil"
 "os"
```

```go
// Uncomment this block to pass the first stage!

switch command := os.Args[1]; command {
case "init":
    for _, dir := range []string{".git", ".git/objects", ".git/refs"} {
        if err := os.Mkdir(dir, 0755); err != nil {
            fmt.Printf("Error creating directory: %s\n", err)
        }
    }

    headFileContents := []byte("ref: refs/heads/master\n")
    if err := ioutil.WriteFile(".git/HEAD", headFileContents, 0644); err != nil {
	       fmt.Printf("Error writing file: %s\n", err)
	   }

    fmt.Println("Initialized git directory")

default:
    fmt.Printf("Unknown command %s\n", command)
    os.Exit(1)
}
```

Push your changes to pass the first stage:

```
git add .
git commit -m "pass 1st stage" # any msg
git push origin master
```
