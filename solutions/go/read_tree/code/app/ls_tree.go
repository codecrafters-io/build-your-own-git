package main

import (
	"bufio"
	"bytes"
	"fmt"
	"io"
)

func LsTree(args []string) error {
	treeSha := args[1] // Assuming that args[0] is --name-only

	objectReader, err := NewGitObjectReader(treeSha)
	if err != nil {
		return err
	}

	contents, err := objectReader.ReadContents()
	if err != nil {
		return err
	}

	contentsReader := bufio.NewReader(bytes.NewReader(contents))

	for {
		// Read the mode of the entry (including the space character after)
		_, err = contentsReader.ReadString(' ')
		if err == io.EOF {
			break // We've reached the end of the file
		} else if err != nil {
			return err
		}

		// Read the name of the entry (including the null-byte character after)
		entryName, err := contentsReader.ReadString(0)
		if err != nil {
			return err
		}

		entryName = entryName[:len(entryName)-1] // Trim the null-byte character
		fmt.Println(entryName)

		_, err = contentsReader.Discard(20) // Discard the SHA-1 hash
		if err != nil {
			return err
		}
	}

	return nil
}
