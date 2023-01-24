package main

import (
	"bytes"
	"fmt"
	"os"
	"path/filepath"
	"strings"

	"github.com/codecrafters-io/git-starter-go/object"
)

const (
	ModeTree = 1 << 14
	ModeBlob = 1 << 15
)

func writeTreeCmd(args []string) error {
	// we don't use args here but keep them for consistency

	name, err := writeTree(".")
	if err != nil {
		return err
	}

	fmt.Println(name)

	return nil
}

func writeTree(dir string) (object.Hash, error) {
	files, err := os.ReadDir(dir)
	if err != nil {
		return object.Hash{}, fmt.Errorf("read dir %v: %w", dir, err)
	}

	var table []byte

	for _, f := range files {
		if strings.HasPrefix(f.Name(), ".") {
			continue
		}

		filePath := filepath.Join(dir, f.Name())

		inf, err := f.Info()
		if err != nil {
			return object.Hash{}, fmt.Errorf("file info %v: %w", filePath, err)
		}

		mode := inf.Mode()

		if !mode.IsRegular() && !mode.IsDir() {
			continue
		}

		var hash object.Hash
		var gitMode int

		if mode.IsDir() {
			gitMode |= ModeTree

			hash, err = writeTree(filePath)
			if err != nil {
				return object.Hash{}, err
			}
		} else {
			gitMode |= ModeBlob
			gitMode |= int(mode) & 0o777 // the actual git logic is a bit more complex

			hash, err = object.StoreFromFile(filePath, "blob")
			if err != nil {
				return object.Hash{}, fmt.Errorf("store file %v: %w", filePath, err)
			}
		}

		table = fmt.Appendf(table, "%o %v\000%s", gitMode, f.Name(), hash[:])
	}

	hash, err := object.Store(bytes.NewReader(table), "tree", int64(len(table)))
	if err != nil {
		return object.Hash{}, fmt.Errorf("store tree %v: %w", dir, err)
	}

	return hash, nil
}
