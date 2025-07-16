In this stage, you'll implement support for creating a blob using the [`git
hash-object`](https://git-scm.com/docs/git-hash-object) command.

### The `git hash-object` command

<details>
  <summary>Click to expand/collapse</summary>

  `git hash-object` is used to compute the SHA-1 hash of a Git object. When used with the `-w` flag, it
  also writes the object to the `.git/objects` directory.

  Here's an example of using `git hash-object`:

  ```bash
  # Create a file with some content
  $ echo -n "hello world" > test.txt

  # Compute the SHA-1 hash of the file + write it to .git/objects
  $ git hash-object -w test.txt
  95d09f2b10159347eece71399a7e2e907ea3df4f

  # Verify that the file was written to .git/objects
  $ file .git/objects/95/d09f2b10159347eece71399a7e2e907ea3df4f
  .git/objects/95/d09f2b10159347eece71399a7e2e907ea3df4f: zlib compressed data
  ```

</details>

### Blob Object Storage (Recap)

<details>
  <summary>Click to expand/collapse</summary>

  As mentioned in the previous stage, each Git Blob is stored as a separate file in the `.git/objects` directory. The file
  contains a header and the contents of the blob object, compressed using Zlib.

  The format of a blob object file looks like this (after Zlib decompression):

  ```
  blob <size>\0<content>
  ```

  - `<size>` is the size of the content (in bytes)
  - `\0` is a null byte
  - `<content>` is the actual content of the file

  For example, if the contents of a file are `hello world`, the blob object file would look like this (after Zlib decompression):

  ```
  blob 11\0hello world
  ```

</details>

### Tests

The tester will first initialize a new git repository using your program:

```bash
$ mkdir test_dir && cd test_dir
$ /path/to/your_program.sh init
```

It'll write some random data to a file:

```bash
$ echo "hello world" > test.txt
```

It'll then run your program like this:

```bash
$ ./your_program.sh hash-object -w test.txt
3b18e512dba79e4c8300dd08aeb37f8e728b8dad
```

The tester will verify that:

- Your program prints a 40-character SHA-1 hash to stdout
- The file written to `.git/objects` matches what the official `git` implementation would write

### Notes

- Although the object file is stored with zlib compression, the SHA-1 hash needs to be computed over
  the "uncompressed" contents of the file, not the compressed version.
- The input for the SHA-1 hash is the header (`blob <size>\0`) + the actual contents of the file,
  not just the contents of the file.
{{#lang_is_c}}
- You can use `#include <openssl/sha.h>` to access OpenSSL’s [SHA1()](https://www.openssl.org/docs/man3.0/man3/SHA1.html) hashing function.
{{/lang_is_c}}
{{#lang_is_cpp}}
- You can use `#include <openssl/sha.h>` to access OpenSSL’s [SHA1()](https://www.openssl.org/docs/man3.0/man3/SHA1.html) hashing function.
{{/lang_is_cpp}}