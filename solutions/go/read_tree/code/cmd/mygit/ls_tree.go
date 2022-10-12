package main

import (
	"bufio"
	"bytes"
	"crypto/sha1"
	"errors"
	"fmt"
	"io"
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

		// d[i:space] is mode

		zero := space + bytes.IndexByte(d[space:], '\000')
		if zero < space { // IndexByte returned -1
			return fmt.Errorf("malformed tree")
		}

		name := d[space+1 : zero] // after space until zero

		if zero+sha1.Size > len(d) {
			return fmt.Errorf("malformed tree")
		}

		// d[zero:zero+sha1.Size] is hash sum

		fmt.Printf("%s\n", name)

		i = zero + sha1.Size // next line
	}

	return nil
}

func dumpTreeBufferedReader(d []byte) error {
	r := bufio.NewReader(bytes.NewReader(d))

	for {
		_, err := r.ReadString(' ') // mode
		if errors.Is(err, io.EOF) {
			break
		}
		if err != nil {
			return err
		}

		name, err := r.ReadString('\000')
		if err != nil {
			return err
		}

		name = name[:len(name)-1] // cut delimiter

		_, err = r.Discard(sha1.Size) // hash sum
		if err != nil {
			return err
		}

		fmt.Printf("%s\n", name)
	}

	return nil
}
