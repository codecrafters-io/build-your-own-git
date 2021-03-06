package main

import (
	"bufio"
	"compress/zlib"
	"io"
	"os"
	"path"
	"strconv"
)

func CatFile(args []string) error {
	blobSha := args[1] // Assuming that args[0] is -p
	objectFilePath := path.Join(".git", "objects", blobSha[:2], blobSha[2:])

	objectFile, err := os.Open(objectFilePath)
	if err != nil {
		return err
	}

	objectFileDecompressed, err := zlib.NewReader(objectFile)
	if err != nil {
		return err
	}

	objectFileReader := bufio.NewReader(objectFileDecompressed)

	// Read the object type (includes the space character after)
	_, err = objectFileReader.ReadString(' ')
	if err != nil {
		return err
	}

	// Read the object size (includes the null byte after)
	objectSizeStr, err := objectFileReader.ReadString(0)
	if err != nil {
		return err
	}

	objectSizeStr = objectSizeStr[:len(objectSizeStr)-1] // Remove the trailing null byte

	size, err := strconv.ParseInt(objectSizeStr, 10, 64)
	if err != nil {
		return err
	}

	_, err = io.CopyN(os.Stdout, objectFileReader, size)
	return err
}
