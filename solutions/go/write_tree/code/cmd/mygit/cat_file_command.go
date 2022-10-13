package main

import (
	"fmt"
	"os"

	"github.com/codecrafters-io/git-starter-go/object"
)

func catFileCmd(args []string) error {
	// Assuming that args is ["cat-file", "-p", "hash"], just like os.Args

	if len(args) < 3 || args[1] != "-p" {
		fmt.Fprintf(os.Stderr, "usage: mygit cat-file -p <blob_hash>\n")

		return fmt.Errorf("bad usage")
	}

	blobSha := args[2]

	typ, content, err := object.LoadByHash(blobSha)
	if err != nil {
		return fmt.Errorf("load by hash: %w", err)
	}

	if typ != "blob" {
		return fmt.Errorf("unsupported object type: %v", typ)
	}

	fmt.Printf("%s", content)

	return nil
}
