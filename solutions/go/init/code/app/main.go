package main

import (
	"fmt"
	 "io/ioutil"
	 "os"
)

// Usage: your_git.sh run <image> <command> <arg1> <arg2> ...
func main() {
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
}
