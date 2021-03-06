package main

import (
	"fmt"
	"os"
)

// Usage: your_git.sh run <image> <command> <arg1> <arg2> ...
func main() {
	var err error

	switch command := os.Args[1]; command {
	case "init":
		err = Init()
	case "cat-file":
		err = CatFile(os.Args[2:])
	default:
		fmt.Println("Unknown command %s", command)
		os.Exit(1)
	}

	if err != nil {
		fmt.Println(err.Error())
		os.Exit(1)
	}
}
