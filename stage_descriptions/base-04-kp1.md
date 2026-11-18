Blobs store file contents. Tree objects associate those contents with filenames
and directory structure. In this stage, implement `ls-tree --name-only` to list
the entries in one tree.

### Tree objects

<details>
  <summary>Click to expand/collapse</summary>

In this stage, we'll deal with our next Git object type:
[trees](https://git-scm.com/book/en/v2/Git-Internals-Git-Objects#_tree_objects).

Trees are used to store directory structures.

A tree object contains a sequence of entries. Each entry includes:

- A SHA-1 hash that points to a blob or tree object
  - If the entry is a file, this points to a blob object
  - If the entry is a directory, this points to a tree object
- The name of the file/directory
- The mode of the file/directory
  - This is a simplified version of the permissions you'd see in a Unix file
    system.
  - For files, the valid values are:
    - `100644` (regular file)
    - `100755` (executable file)
    - `120000` (symbolic link)
  - For directories, the value is `40000`
  - There are other values for submodules, but we won't be dealing with those in
    this challenge.

For example, if you had a directory structure like this:

```
your_repo/
  - file1
  - dir1/
    - file_in_dir_1
    - file_in_dir_2
  - dir2/
    - file_in_dir_3
```

A readable summary of the entries looks like this. The binary storage format is
described below.

```
40000 dir1 <tree_sha_1>
40000 dir2 <tree_sha_2>
100644 file1 <blob_sha_1>
```

- Line 1 (`40000 dir1 <tree_sha_1>`) indicates that `dir1` is a directory with
  the SHA hash `<tree_sha_1>`
- Line 2 (`40000 dir2 <tree_sha_2>`) indicates that `dir2` is a directory with
  the SHA hash `<tree_sha_2>`
- Line 3 (`100644 file1 <blob_sha_1>`) indicates that `file1` is a regular file
  with the SHA hash `<blob_sha_1>`

`dir1` and `dir2` would be tree objects themselves, and their entries would
contain the files/directories inside them.

</details>

### The `ls-tree` command

<details>
  <summary>Click to expand/collapse</summary>

The `git ls-tree` command is used to inspect a tree object.

For a directory structure like this:

```
your_repo/
  - file1
  - dir1/
    - file_in_dir_1
    - file_in_dir_2
  - dir2/
    - file_in_dir_3
```

The output of `git ls-tree` would look like this:

```bash
$ git ls-tree <tree_sha>
040000 tree <tree_sha_1>	dir1
040000 tree <tree_sha_2>	dir2
100644 blob <blob_sha_1>	file1
```

The output follows the order stored in the tree. Git compares names byte by
byte, treating a directory name as if it ended in `/`. For these names, that
gives the alphabetical order shown above.

In this stage you'll implement the `git ls-tree` command with the `--name-only`
flag. Here's how the output looks with the `--name-only` flag:

```bash
$ git ls-tree --name-only <tree_sha>
dir1
dir2
file1
```

Implementing the full `ls-tree` display is an optional exercise in interpreting
modes and object types. Only `--name-only` is required here.

</details>

### Tree object storage

<details>
  <summary>Click to expand/collapse</summary>

Just like blobs, tree objects are stored in the `.git/objects` directory. If the
hash of a tree object is `e88f7a929cd70b0274c4ea33b209c97fa845fdbc`, the path to
the object would be `.git/objects/e8/8f7a929cd70b0274c4ea33b209c97fa845fdbc`.

The format of a tree object file looks like this (after Zlib decompression):

```
tree <size>\0
<mode> <name>\0<20_byte_sha>
<mode> <name>\0<20_byte_sha>
```

The line breaks above separate fields for illustration. There are no newline
separators between the header and entries, or between entries. `\0` represents a
single null byte.

- The file starts with `tree <size>\0`. As with blobs, `<size>` is the byte
  length of the content after this header, written in decimal.
- After the header, there are multiple entries. Each entry is of the form
  `<mode> <name>\0<sha>`.
  - `<mode>` is the mode of the file/directory (check the previous section for
    valid values)
  - `<name>` is the name of the file/directory
  - `\0` is a null byte
  - `<20_byte_sha>` is the raw 20-byte identifier of the blob or tree. Its usual
    hexadecimal display takes 40 characters. A raw identifier can contain any
    byte value, including null or newline.

You can read more about the internal format of a tree object
[here](https://stackoverflow.com/questions/14790681/what-is-the-internal-format-of-a-git-tree-object).

</details>

### Tests

The tester will use your program to initialize a new repository:

```bash
$ mkdir test_dir && cd test_dir
$ /path/to/your_program.sh init
```

It'll then write a tree object to the `.git/objects` directory.

It'll then run your program like this:

```bash
$ /path/to/your_program.sh ls-tree --name-only <tree_sha>
```

Print each immediate entry's name to stdout in tree order, with a newline after
each name. Do not list the contents of subdirectories. The tester compares this
output with the stored tree and expects a successful exit.

For a directory structure like this:

```
your_repo/
  - file1
  - dir1/
    - file_in_dir_1
    - file_in_dir_2
  - dir2/
    - file_in_dir_3
```

The output expected is:

```
dir1
dir2
file1
```

### Notes

- A directory's entry points to another tree object. Reading that subtree is
  unnecessary for `ls-tree --name-only` without a recursive option.
- Keep the 20-byte identifier length distinct from the null-terminated name when
  interpreting an entry.
