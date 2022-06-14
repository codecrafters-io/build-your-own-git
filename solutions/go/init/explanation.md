The entry point for your Docker implementation is in `app/main.go`.

Study and uncomment the relevant code: 

```go
// Uncomment this block to pass the first stage!
 "os"
 "os/exec"
```

```go
// Uncomment this block to pass the first stage!

command := os.Args[3]
args := os.Args[4:len(os.Args)]

cmd := exec.Command(command, args...)
output, err := cmd.Output()
if err != nil {
	fmt.Printf("Err: %v", err)
	os.Exit(1)
}

fmt.Println(string(output))
```

Push your changes to pass the first stage:

```
git add .
git commit -m "pass 1st stage" # any msg
git push origin master
```
