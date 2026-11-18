Your repository now has an object directory. In this stage, you'll implement
`cat-file -p` to read a blob object and print the file contents it stores.

### Git objects

<details>
  <summary>Click to expand/collapse</summary>

In this challenge, we'll deal with three
[Git objects](https://git-scm.com/book/en/v2/Git-Internals-Git-Objects):

- Blobs store file contents. You'll read one in this stage. Names and
  permissions belong to tree entries.
- Trees store directory structures, including entries' names, permissions, and
  object hashes. You'll work with them in later stages.
- Commits link a snapshot's tree to parent commits and record a message, author,
  and committer. They also come in later stages.

This challenge uses Git's SHA-1 object format. Each object has a 20-byte
identifier, usually written as 40 hexadecimal characters and called its "object
hash". The identifier is calculated from the object's type, size, and contents.

Here's an example of an object hash: `e88f7a929cd70b0274c4ea33b209c97fa845fdbc`.

</details>

### Git object storage

<details>
  <summary>Click to expand/collapse</summary>

An object stored in its own file is called a loose object. These files live in
`.git/objects`, at paths derived from their hashes.

The path for the object with the hash `e88f7a929cd70b0274c4ea33b209c97fa845fdbc`
would be:

```bash
.git/objects/e8/8f7a929cd70b0274c4ea33b209c97fa845fdbc
```

The first two characters of the object's hash name a subdirectory of
`.git/objects`. The remaining 38 characters name the file inside it.

Each Git object has its own format for storage. We'll look at how blobs are
stored in this stage, and we'll cover other objects in future stages.

</details>

### Blob object storage

<details>
  <summary>Click to expand/collapse</summary>

A loose blob file contains a header followed by the file's bytes. The whole
sequence is compressed using zlib.

The format of a blob object file looks like this (after Zlib decompression):

```
blob <size>\0<content>
```

- `<size>` is the size of the content in bytes, written as decimal text. It
  excludes the header.
- `\0` represents one null byte (`0x00`). The two printed characters are only
  notation.
- `<content>` is the actual content of the file

For example, if the contents of a file are `hello world`, the blob object file
would look like this (after Zlib decompression):

```
blob 11\0hello world
```

</details>

### The cat-file command

<details>
  <summary>Click to expand/collapse</summary>

`cat-file` is the first of several
["plumbing" commands](https://git-scm.com/book/en/v2/Git-Internals-Plumbing-and-Porcelain)
in this challenge. These commands expose Git's internal objects and operations.

[`git cat-file`](https://git-scm.com/docs/git-cat-file) can display an object's
type, size, or content. Example usage:

```bash
$ git cat-file -p <blob_sha>
hello world
```

For `cat-file -p <blob_sha>`, stdout must contain the blob's content bytes
exactly. The object header and compressed representation stay out of the output.
Other `cat-file` options and object types are outside this stage.

</details>

### Tests

The tester will first initialize a new Git repository using your program, and
then insert a blob with random contents into the `.git/objects` directory:

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

The tester will verify that your program exits successfully and that stdout
matches the blob's contents. The string and object hash vary between tests.

### Notes

- Many print functions, such as
  [`fmt.Println`](https://pkg.go.dev/fmt#example-Println), append a newline. Do
  not add one to the blob's contents. Preserve a newline when it is already part
  of the blob, as in the `echo` example above.
- Keep diagnostics on stderr so they do not change the content on stdout.

{{#lang_is_python}}

- Keep in mind that Git uses [Zlib](https://en.wikipedia.org/wiki/Zlib) to
  compress objects. You can use Python's built-in
  [zlib](https://docs.python.org/3/library/zlib.html) library to read these
  compressed files. {{/lang_is_python}}

{{#lang_is_ruby}}

- Keep in mind that Git uses [Zlib](https://en.wikipedia.org/wiki/Zlib) to
  compress objects. You can use Ruby's built-in
  [Zlib](https://ruby-doc.org/stdlib-2.7.0/libdoc/zlib/rdoc/Zlib.html) library
  to read these compressed files. {{/lang_is_ruby}}

{{#lang_is_go}}

- Keep in mind that Git uses [Zlib](https://en.wikipedia.org/wiki/Zlib) to
  compress objects. You can use Go's built-in
  [compress/zlib](https://golang.org/pkg/compress/zlib/) package to read these
  compressed files. {{/lang_is_go}}

{{#lang_is_rust}}

- Keep in mind that Git uses [Zlib](https://en.wikipedia.org/wiki/Zlib) to
  compress objects. You can use the [flate2](https://crates.io/crates/flate2)
  crate to read these compressed files, we've included it in the `Cargo.toml`
  file. {{/lang_is_rust}}

{{^lang_is_python}} {{^lang_is_ruby}} {{^lang_is_go}} {{^lang_is_rust}}

- Keep in mind that Git uses [Zlib](https://en.wikipedia.org/wiki/Zlib) to
  compress objects. Many languages have utils for dealing with zlib data in
  their standard library. If not, you might need to use a third-party library to
  read these compressed files. {{/lang_is_rust}} {{/lang_is_go}}
  {{/lang_is_ruby}} {{/lang_is_python}}
