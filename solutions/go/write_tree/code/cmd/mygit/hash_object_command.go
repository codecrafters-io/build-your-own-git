package main

import (
	"errors"
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

	filePath := args[2]

	fileInfo, err := os.Stat(filePath)
	if errors.Is(err, os.ErrNotExist) {
		return fmt.Errorf("no such file: %v", filePath)
	}
	if err != nil {
		return fmt.Errorf("get file info: %w", err)
	}

	file, err := os.Open(filePath)
	if err != nil {
		return fmt.Errorf("read file: %w", err)
	}

	defer func() {
		e := file.Close()
		if err == nil && e != nil {
			err = fmt.Errorf("close file: %w", e)
		}
	}()

	name, err := object.Store(file, "blob", fileInfo.Size())
	if err != nil {
		return err
	}

	fmt.Println(name)

	return nil
}
