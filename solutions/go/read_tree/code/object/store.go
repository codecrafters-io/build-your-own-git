package object

import (
	"bytes"
	"compress/zlib"
	"crypto/sha1"
	"encoding/hex"
	"fmt"
	"io"
	"os"
	"path/filepath"
)

func Store(src io.Reader, typ string, size int64) (string, error) {
	var buf bytes.Buffer

	err := encodeObject(&buf, src, typ, size)

	fileContent, err := compress(buf.Bytes())
	if err != nil {
		return "", fmt.Errorf("compress: %w", err)
	}

	sum := sha1.Sum(buf.Bytes())
	name := hex.EncodeToString(sum[:])

	objPath := filepath.Join(".git", "objects", name[:2], name[2:])
	dirPath := filepath.Dir(objPath)

	err = os.MkdirAll(dirPath, 0755)
	if err != nil {
		return "", fmt.Errorf("mkdir: %w", err)
	}

	err = os.WriteFile(objPath, fileContent, 0644)
	if err != nil {
		return "", fmt.Errorf("write file: %w", err)
	}

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

func compress(data []byte) ([]byte, error) {
	var buf bytes.Buffer

	w := zlib.NewWriter(&buf)

	_, err := w.Write(data)
	if err != nil {
		return nil, err
	}

	err = w.Close()
	if err != nil {
		return nil, err
	}

	return buf.Bytes(), nil
}
