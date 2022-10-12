package main

import (
	"bytes"
	"fmt"
	"os"

	"github.com/codecrafters-io/git-starter-go/object"
)

func lsTreeCmd(args []string) (err error) {
	// Assuming that args is ["ls-tree", "--name-only", "hash"], just like os.Args

	if len(args) < 3 || args[1] != "--name-only" {
		fmt.Fprintf(os.Stderr, "usage: mygit ls-tree --name-only <hash>\n")

		return fmt.Errorf("bad usage")
	}

	blobSha := args[2]

	typ, content, err := object.LoadByHash(blobSha)
	if err != nil {
		return fmt.Errorf("load by hash: %w", err)
	}

	if typ != "tree" {
		return fmt.Errorf("unsupported object type: %v", typ)
	}

	return dumpTree(content)
}

func dumpTree(d []byte) error {
	i := 0

	for i < len(d) {
		space := i + bytes.IndexByte(d[i:], ' ')
		if space < i { // IndexByte returned -1
			return fmt.Errorf("malformed tree")
		}

		// d[i:space] - mode

		zero := space + bytes.IndexByte(d[space:], '\000')
		if zero < space {
			return fmt.Errorf("malformed tree")
		}

		name := d[space+1 : zero] // after space until zero

		if zero+20 > len(d) {
			return fmt.Errorf("malformed tree")
		}

		// d[zero:zero+20] - hash sum

		fmt.Printf("%s\n", name)

		i = zero + 20 // next line
	}

	return nil
}
