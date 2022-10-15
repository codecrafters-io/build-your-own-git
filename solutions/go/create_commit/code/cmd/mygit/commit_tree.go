package main

import (
	"bytes"
	"fmt"
	"os"
	"strings"
	"time"

	"github.com/codecrafters-io/git-starter-go/object"
)

type commitTreeParams struct {
	Tree    string
	Parent  string
	Message string
}

func commitTreeCmd(args []string) error {
	params, err := parseCommitTreeFlags(args)
	if err != nil {
		return err
	}

	var buf []byte

	buf = fmt.Appendf(buf, "tree %s\n", params.Tree)

	if params.Parent != "" {
		buf = fmt.Appendf(buf, "parent %s\n", params.Parent)
	}

	// git loads name and email from a config file
	name := "Your Name"
	email := "your_email@example.com"
	now := time.Now()

	buf = fmt.Appendf(buf, "author %s <%s> %d", name, email, now.Unix())
	buf = now.AppendFormat(buf, " -0700\n")

	message := params.Message

	buf = fmt.Appendf(buf, "\n%s", message)
	if message != "" && message[len(message)-1] != '\n' {
		buf = append(buf, '\n')
	}

	hash, err := object.Store(bytes.NewReader(buf), "commit", int64(len(buf)))
	if err != nil {
		return fmt.Errorf("store object: %w", err)
	}

	fmt.Println(hash)

	return nil
}

func parseCommitTreeFlags(args []string) (commitTreeParams, error) {
	// Assuming that args is ["commit-tree", "<tree_root>", "-p", "<parent_hash>", "-m", "<message>"], just like os.Args

	var params commitTreeParams

	for i := 1; i < len(args); i++ {
		if !strings.HasPrefix(args[i], "-") { // non-flag argument: tree_root
			params.Tree = args[i]

			continue
		}

		flag := args[i]

		i++ // go to flag value

		if i >= len(args) { // check it is given
			return commitTreeParams{}, fmt.Errorf("value for flag %v expected", flag)
		}

		switch flag {
		case "-p":
			params.Parent = args[i]
		case "-m":
			params.Message = args[i]
		default:
			return commitTreeParams{}, fmt.Errorf("unsupported flag: %v", flag)
		}
	}

	if params.Tree == "" || params.Message == "" {
		fmt.Fprintf(os.Stderr, "usage: mygit commit-tree <tree_root> -p <parent_hash> -m <message>\n")

		return commitTreeParams{}, fmt.Errorf("tree_hash and message required")
	}

	return params, nil
}
