package main

import (
	"fmt"
	"io/ioutil"
	"os"
)

func Init() error {
	for _, dir := range []string{".git", ".git/objects", ".git/refs"} {
		if err := os.Mkdir(dir, 0755); err != nil {
			return fmt.Errorf("error creating directory: %s\n", err)
		}
	}

	headFileContents := []byte("ref: refs/heads/master\n")
	if err := ioutil.WriteFile(".git/HEAD", headFileContents, 0644); err != nil {
		return fmt.Errorf("error writing file: %s\n", err)
	}

	fmt.Println("Initialized git directory")
	return nil
}
