package main

import (
	"bytes"
	"flag"
	"fmt"
	"os"
	"strings"
	"time"

	"github.com/codecrafters-io/git-starter-go/object"
)

func commitTreeCmd(args []string) error {
	tree, parent, message, err := parseCommitTreeFlags(args)
	if err != nil {
		return err
	}

	var buf []byte

	buf = fmt.Appendf(buf, "tree %s\n", tree)

	if parent != "" {
		buf = fmt.Appendf(buf, "parent %s\n", parent)
	}

	// git loads name and email from a config file
	name := "Your Name"
	email := "your_email@example.com"
	now := time.Now()

	buf = fmt.Appendf(buf, "author %s <%s> %d %s\n", name, email, now.Unix(), now.Format("-0700"))

	buf = fmt.Appendf(buf, "\n%s", message)
	if !strings.HasSuffix(message, "\n") {
		buf = append(buf, '\n')
	}

	hash, err := object.Store(bytes.NewReader(buf), "commit", int64(len(buf)))
	if err != nil {
		return fmt.Errorf("store object: %w", err)
	}

	fmt.Println(hash)

	return nil
}

func parseCommitTreeFlags(args []string) (tree, parent, message string, err error) {
	// Assuming that args is ["commit-tree", "<tree_hash>", "-p", "<parent_hash>", "-m", "<message>"]

	fs := flag.NewFlagSet(args[0], flag.ContinueOnError)

	if len(args) < 2 {
		commitTreeUsage()

		err = fmt.Errorf("bad usage: tree_hash required")
		return
	}

	// flag package doesn't support flags after arguments.
	// So assuming tree_hash is always the first.
	tree = args[1]

	fs.StringVar(&parent, "p", "", "parent commit")
	fs.StringVar(&message, "m", "", "commit message")

	// Flags
	err = fs.Parse(args[2:])
	if err != nil {
		commitTreeUsage()

		err = fmt.Errorf("bad usage: %w", err)
		return
	}

	if message == "" {
		commitTreeUsage()

		err = fmt.Errorf("bad usage: message required")
		return
	}

	if fs.NArg() != 0 {
		commitTreeUsage()

		err = fmt.Errorf("bad usage: unexpected args: %q", fs.Args())
		return
	}

	return
}

func commitTreeUsage() {
	fmt.Fprintf(os.Stderr, "usage: mygit commit-tree <tree_hash> -p <parent_hash> -m <message>\n")
}
