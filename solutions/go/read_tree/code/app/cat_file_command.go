package main

import (
	"os"
)

func CatFile(args []string) error {
	blobSha := args[1] // Assuming that args[0] is -p

	objectReader, err := NewGitObjectReader(blobSha)
	if err != nil {
		return err
	}

	contents, err := objectReader.ReadContents()
	if err != nil {
		return err
	}

	_, err = os.Stdout.Write(contents)
	return err
}
