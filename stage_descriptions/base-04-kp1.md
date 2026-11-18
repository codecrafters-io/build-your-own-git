Blobs store file contents. Tree objects associate those contents with filenames
and directory structure. In this stage, you'll implement `ls-tree --name-only`
to list the entries in one tree.

### Tree objects

<details>
  <summary>Click to expand/collapse</summary>

A
[tree object](https://git-scm.com/book/en/v2/Git-Internals-Git-Objects#_tree_objects)
represents one directory. Each entry contains a name, a mode, and a SHA-1
identifier. File entries point to blobs, and directory entries point to other
trees.

The mode records the entry's type and simplified Unix permissions:

- `100644`: regular file.
- `100755`: executable file.
- `120000`: symbolic link.
- `40000`: directory.

Submodule modes are outside this challenge.

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

`<tree_sha_1>` and `<tree_sha_2>` identify the subtrees containing the nested
files. `<blob_sha_1>` identifies `file1`'s contents.

</details>

### The `ls-tree` command

<details>
  <summary>Click to expand/collapse</summary>

The `git ls-tree` command displays the entries above like this:

```bash
$ git ls-tree <tree_sha>
040000 tree <tree_sha_1>	dir1
040000 tree <tree_sha_2>	dir2
100644 blob <blob_sha_1>	file1
```

The output follows the order stored in the tree. Git compares names byte by
byte, treating a directory name as if it ended in `/`. For these names, that
gives the alphabetical order shown above.

The required `--name-only` flag selects just the names:

```bash
$ git ls-tree --name-only <tree_sha>
dir1
dir2
file1
```

The full display is optional. It gives you another way to inspect modes and
object types.

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
- Each entry has the form `<mode> <name>\0<sha>`, using the mode and name
  described above.
- `<20_byte_sha>` is the raw 20-byte identifier of the blob or tree. Its
  hexadecimal display takes 40 characters. A raw identifier can contain any byte
  value, including null or newline.

Read more about
[the internal format of a tree object](https://stackoverflow.com/questions/14790681/what-is-the-internal-format-of-a-git-tree-object).

</details>

### Tests

The tester will use your program to initialize a new repository:

```bash
$ mkdir test_dir && cd test_dir
$ /path/to/your_program.sh init
```

It writes a tree object to `.git/objects`, then runs:

```bash
$ /path/to/your_program.sh ls-tree --name-only <tree_sha>
```

Print each immediate entry's name to stdout in tree order, with a newline after
each name. Do not list the contents of subdirectories. The tester compares this
output with the stored tree and expects a successful exit.

For the directory structure above, the expected output is:

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
