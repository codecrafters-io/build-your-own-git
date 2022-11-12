package main

import (
	"fmt"
	"os"

	"github.com/codecrafters-io/git-starter-go/object"
)

func hashObjectCmd(args []string) (err error) {
	// Assuming that args is ["hash-object", "-w", "file"], just like os.Args

	if len(args) < 3 || args[1] != "-w" {
		fmt.Fprintf(os.Stderr, "usage: mygit hash-object -w <file>\n")

		return fmt.Errorf("bad usage")
	}

	file := args[2]

	name, err := object.StoreFromFile(file, "blob")
	if err != nil {
		return err
	}

	fmt.Println(name)

	return nil
}
