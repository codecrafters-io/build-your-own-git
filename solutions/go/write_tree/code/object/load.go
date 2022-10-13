package object

import (
	"bufio"
	"compress/zlib"
	"errors"
	"fmt"
	"io"
	"os"
	"path/filepath"
	"strconv"
)

func LoadByHash(h Hash) (typ string, content []byte, err error) {
	name := h.String()

	path := filepath.Join(".git", "objects", name[:2], name[2:])

	file, err := os.Open(path)
	if errors.Is(err, os.ErrNotExist) {
		return "", nil, fmt.Errorf("not a valid object name")
	}
	if err != nil {
		return "", nil, fmt.Errorf("read file: %w", err)
	}

	defer func() {
		e := file.Close()
		if err == nil && e != nil {
			err = fmt.Errorf("close file: %w", e)
		}
	}()

	return Load(file)
}

func Load(r io.Reader) (typ string, content []byte, err error) {
	zr, err := zlib.NewReader(r)
	if err != nil {
		return "", nil, fmt.Errorf("new zlib reader: %w", err)
	}

	defer func() {
		e := zr.Close()
		if err == nil && e != nil {
			err = fmt.Errorf("close zlib reader: %w", e)
		}
	}()

	typ, content, err = parseObject(zr)
	if err != nil {
		return "", nil, fmt.Errorf("parse object: %w", err)
	}

	return typ, content, nil
}

func parseObject(r io.Reader) (string, []byte, error) {
	br := bufio.NewReader(r)

	typ, err := br.ReadString(' ')
	if err != nil {
		return "", nil, err
	}

	typ = typ[:len(typ)-1] // cut ' '

	sizeStr, err := br.ReadString('\000')
	if err != nil {
		return typ, nil, err
	}

	sizeStr = sizeStr[:len(sizeStr)-1] // cut '\000'

	size, err := strconv.ParseInt(sizeStr, 10, 64)
	if err != nil {
		return typ, nil, fmt.Errorf("parse size: %w", err)
	}

	content := make([]byte, size)

	_, err = io.ReadFull(br, content)
	if err != nil {
		return typ, nil, err
	}

	return typ, content, nil
}
