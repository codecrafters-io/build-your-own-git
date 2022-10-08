package main

import (
	"compress/zlib"
	"crypto/sha1"
	"encoding/hex"
	"errors"
	"fmt"
	"io"
	"os"
	"path/filepath"
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

	name, err := hashObject(file, "blob", fileInfo.Size())
	if err != nil {
		return err
	}

	fmt.Println(name)

	return nil
}

func hashObject(src io.Reader, typ string, size int64) (name string, err error) {
	tmpPath := filepath.Join(".git", "objects", "tmpfile")

	name, err = hashObjectToFile(tmpPath, src, typ, size)
	if err != nil {
		return "", err
	}

	defer func() {
		if err != nil {
			_ = os.Remove(tmpPath) // best effort
		}
	}()

	objPath := filepath.Join(".git", "objects", name[:2], name[2:])
	dirPath := filepath.Dir(objPath)

	err = os.MkdirAll(dirPath, 0755)
	if err != nil {
		return "", fmt.Errorf("mkdir: %w", err)
	}

	err = os.Rename(tmpPath, objPath)
	if err != nil {
		return "", fmt.Errorf("rename: %w", err)
	}

	return name, nil
}

func hashObjectToFile(filePath string, src io.Reader, typ string, size int64) (name string, err error) {
	file, err := os.Create(filePath)
	if err != nil {
		return "", fmt.Errorf("create file: %w", err)
	}

	defer func() {
		e := file.Close()
		if err == nil && e != nil {
			err = fmt.Errorf("close file: %w", e)
		}

		if err != nil {
			_ = os.Remove(filePath) // best effort
		}
	}()

	zFile := zlib.NewWriter(file)

	defer func() {
		e := zFile.Close()
		if err == nil && e != nil {
			err = fmt.Errorf("close zlib writer: %w", e)
		}
	}()

	hash := sha1.New()
	w := io.MultiWriter(hash, zFile)

	err = encodeObject(w, src, typ, size)
	if err != nil {
		return "", err
	}

	sum := hash.Sum(nil)
	name = hex.EncodeToString(sum)

	return name, nil
}

func encodeObject(dst io.Writer, src io.Reader, typ string, size int64) error {
	_, err := fmt.Fprintf(dst, "%v %d\000", typ, size)
	if err != nil {
		return err
	}

	_, err = io.Copy(dst, src)
	if err != nil {
		return err
	}

	return nil
}
