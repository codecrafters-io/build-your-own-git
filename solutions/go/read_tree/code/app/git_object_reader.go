package main

import (
	"bufio"
	"compress/zlib"
	"io"
	"os"
	"path"
	"strconv"
)

type GitObjectReader struct {
	objectFileReader *bufio.Reader
	ContentsSize     int64
	Type             string
	Sha              string
}

func NewGitObjectReader(objectSha string) (GitObjectReader, error) {
	objectFilePath := path.Join(".git", "objects", objectSha[:2], objectSha[2:])

	objectFile, err := os.Open(objectFilePath)
	if err != nil {
		return GitObjectReader{}, err
	}

	objectFileDecompressed, err := zlib.NewReader(objectFile)
	if err != nil {
		return GitObjectReader{}, err
	}

	objectFileReader := bufio.NewReader(objectFileDecompressed)

	// Read the object type (includes the space character after)
	objectType, err := objectFileReader.ReadString(' ')
	if err != nil {
		return GitObjectReader{}, err
	}

	objectType = objectType[:len(objectType)-1] // Remove the trailing space character

	// Read the object size (includes the null byte after)
	objectSizeStr, err := objectFileReader.ReadString(0)
	if err != nil {
		return GitObjectReader{}, err
	}

	objectSizeStr = objectSizeStr[:len(objectSizeStr)-1] // Remove the trailing null byte

	size, err := strconv.ParseInt(objectSizeStr, 10, 64)
	if err != nil {
		return GitObjectReader{}, err
	}

	return GitObjectReader{
		objectFileReader: objectFileReader,
		Type:             objectType,
		Sha:              objectSha,
		ContentsSize:     size,
	}, nil
}

func (g *GitObjectReader) ReadContents() ([]byte, error) {
	contents := make([]byte, g.ContentsSize)

	_, err := io.ReadFull(g.objectFileReader, contents)
	if err != nil {
		return []byte{}, err
	}

	return contents, nil
}
