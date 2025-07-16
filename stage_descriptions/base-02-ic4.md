In this stage, you'll add support for reading a blob using the `git cat-file` command.

### Git objects

<details>
  <summary>Click to expand/collapse</summary>

  In this challenge, we'll deal with three [Git
  objects](https://git-scm.com/book/en/v2/Git-Internals-Git-Objects):

  - Blobs (**This stage**)
    - These are used to store file data.
    - Blobs only store the contents of a file, not its name or permissions.
  - Trees (Future stages)
    - These are used to store directory structures.
    - The information stored can include things like what files/directories are in a tree, their names and permissions.
  - Commits (Future stages)
    - These are used to store commit data.
    - The information stored can include things like the commit message, author, committer, parent commit(s) and more.


  All Git objects are identifiable by a 40-character SHA-1 hash, also known as the "object hash".

  Here's an example of an object hash: `e88f7a929cd70b0274c4ea33b209c97fa845fdbc`.
</details>

### Git Object Storage

<details>
  <summary>Click to expand/collapse</summary>

  Git objects are stored in the `.git/objects` directory. The path to an object is derived from its hash.

  The path for the object with the hash `e88f7a929cd70b0274c4ea33b209c97fa845fdbc` would be:

  ```bash
  .git/objects/e8/8f7a929cd70b0274c4ea33b209c97fa845fdbc
  ```

  You'll see that the file isn't placed directly in the `.git/objects` directory. Instead, it's placed in a directory named with the
  first two characters of the object's hash. The remaining 38 characters are used as the file name.

  Each Git object has its own format for storage. We'll look at how Blobs are stored in this stage, and we'll cover
  other objects in future stages.
</details>

### Blob Object Storage

<details>
  <summary>Click to expand/collapse</summary>

  Each Git Blob is stored as a separate file in the `.git/objects` directory. The file contains a header and the contents of
  the blob object, compressed using Zlib.

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

### The cat-file command

<details>
  <summary>Click to expand/collapse</summary>

  In this stage, you'll read a blob from a git repository by reading its contents from the `.git/objects` directory.

  You'll do this using the first of multiple ["plumbing" commands](https://git-scm.com/book/en/v2/Git-Internals-Plumbing-and-Porcelain)
  we'll encounter in this challenge: [`git cat-file`](https://git-scm.com/docs/git-cat-file).

  `git cat-file` is used to view the type of an object, its size, and its content. Example usage:

  ```bash
  $ git cat-file -p <blob_sha>
  hello world # This is the contents of the blob
  ```

  To implement this, you'll need to:

  - Read the contents of the blob object file from the `.git/objects` directory
  - Decompress the contents using Zlib
  - Extract the actual "content" from the decompressed data
  - Print the content to stdout

</details>

### Tests

The tester will first initialize a new git repository using your program, and then insert a blob with random contents into the `.git/objects` directory:

```bash
$ mkdir /tmp/test_dir && cd /tmp/test_dir
$ /path/to/your_program.sh init
$ echo "hello world" > test.txt # The tester will use a random string, not "hello world"
$ git hash-object -w test.txt
3b18e512dba79e4c8300dd08aeb37f8e728b8dad
```

After that, it'll run your program like this:

```bash
$ /path/to/your_program.sh cat-file -p 3b18e512dba79e4c8300dd08aeb37f8e728b8dad
hello world
```

The tester will verify that the output of your program matches the contents of the blob.

### Notes

- In many programming languages the default print function (like [`fmt.Println`](https://pkg.go.dev/fmt#example-Println))
  will append a newline to the output. The output of `cat-file` must not contain a
  newline at the end, so you might need to use a different function to print the output.

{{#lang_is_python}}
- Keep in mind that Git uses [Zlib](https://en.wikipedia.org/wiki/Zlib) to
  compress objects. You can use Python's built-in
  [zlib](https://docs.python.org/3/library/zlib.html) library to read these
  compressed files.
{{/lang_is_python}}

{{#lang_is_ruby}}
- Keep in mind that Git uses [Zlib](https://en.wikipedia.org/wiki/Zlib) to
  compress objects. You can use Ruby's built-in
  [Zlib](https://ruby-doc.org/stdlib-2.7.0/libdoc/zlib/rdoc/Zlib.html)
  library to read these compressed files.
{{/lang_is_ruby}}

{{#lang_is_go}}
- Keep in mind that Git uses [Zlib](https://en.wikipedia.org/wiki/Zlib) to
  compress objects. You can use Go's built-in
  [compress/zlib](https://golang.org/pkg/compress/zlib/) package to read
 these compressed files.
{{/lang_is_go}}

{{#lang_is_rust}}
- Keep in mind that Git uses [Zlib](https://en.wikipedia.org/wiki/Zlib) to
  compress objects. You can use the
  [flate2](https://crates.io/crates/flate2) crate to read these compressed
  files, we've included it in the `Cargo.toml` file.
{{/lang_is_rust}}

{{^lang_is_python}}
{{^lang_is_ruby}}
{{^lang_is_go}}
{{^lang_is_rust}}
- Keep in mind that Git uses [Zlib](https://en.wikipedia.org/wiki/Zlib) to
  compress objects. Many languages have utils for dealing with zlib data in their standard library. If not,
  you might need to use a third-party library to read these compressed files.
{{/lang_is_rust}}
{{/lang_is_go}}
{{/lang_is_ruby}}
{{/lang_is_python}}