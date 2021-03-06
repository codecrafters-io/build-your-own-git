package main

import (
	"bytes"
	"compress/zlib"
	"crypto/sha1"
	"fmt"
	"io"
	"os"
	"path"
)

func HashObject(args []string) error {
	filePath := args[1] // Assuming that args[0] is -w

	fileInfo, err := os.Stat(filePath)
	if err != nil {
		return err
	}

	file, err := os.Open(filePath)
	if err != nil {
		return err
	}

	contents := &bytes.Buffer{}
	contents.WriteString(fmt.Sprintf("blob %d\x00", fileInfo.Size()))

	_, err = io.Copy(contents, file)
	if err != nil {
		return err
	}

	blobSha := fmt.Sprintf("%x", sha1.Sum(contents.Bytes()))
	objectFilePath := path.Join(".git", "objects", blobSha[:2], blobSha[2:])

	err = os.MkdirAll(path.Dir(objectFilePath), 0755)
	if err != nil {
		return err
	}

	objectFile, err := os.Create(objectFilePath)
	if err != nil {
		return err
	}

	compressedFileWriter := zlib.NewWriter(objectFile)

	_, err = compressedFileWriter.Write(contents.Bytes())
	if err != nil {
		return err
	}

	err = compressedFileWriter.Close()
	if err != nil {
		return err
	}

	fmt.Println(blobSha)
	return nil
}
