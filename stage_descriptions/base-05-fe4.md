You can read directory entries from a tree. In this stage, implement
`write-tree` to store the current directory as a tree and print its hash.
Together with its referenced blobs and subtrees, this object represents a
directory snapshot.

### Tree object storage (recap)

As a recap, tree objects store directory structures and are saved in the
`.git/objects` directory.

For example, if a tree object has the hash
`e88f7a929cd70b0274c4ea33b209c97fa845fdbc`, its path will be
`.git/objects/e8/8f7a929cd70b0274c4ea33b209c97fa845fdbc`.

Here's what a tree object file looks like before zlib compression:

```bash
tree <size>\0
<mode> <name>\0<20_byte_sha>
<mode> <name>\0<20_byte_sha>
```

The code block separates entries with newlines for readability. The stored
format has no such separators. A raw hash may itself contain a newline byte.

- The file begins with `tree <size>\0`. The decimal size counts the entry bytes
  after the null byte, excluding the header.
- After the header, the file contains several entries. Each entry follows the
  format `<mode> <name>\0<sha>`:
  - `<mode>` shows the type and permissions of the file or directory.
  - `<name>` is the name of the file or directory.
  - `\0` represents a null byte.
  - `<20_byte_sha>` is the raw 20-byte SHA-1 identifier of the referenced blob
    or tree object.

As with blobs, the object's hash covers the header and uncompressed content. The
file under `.git/objects` contains that same sequence compressed with zlib.

### The `<mode>` field

The `<mode>` field shows the type and permissions for each entry. Some valid
values include:

- `100644` - Regular file
- `100755` - Executable file
- `40000` - Directory (Tree object)

Store directory mode as `40000`. Git commands such as `git ls-tree` display it
as `040000`. Modes are written as ASCII octal digits in the object.

You can read more about the internal format of a tree object
[here](https://stackoverflow.com/questions/14790681/what-is-the-internal-format-of-a-git-tree-object).

### The `git write-tree` command

The `git write-tree` command creates a tree object from the current state of the
"staging area". The staging area is a place where changes go when you run
`git add`.

For this challenge, you will not implement a staging area. Instead, assume that
all files in the working directory are already staged.

Here's an example of using `git write-tree`:

```bash
# Create a file with some content
$ echo "hello world" > test.txt

# Add the file to the staging area (we won't implement a staging area in this challenge)
$ git add test.txt

# Write the tree to .git/objects
$ git write-tree
c3b8bb102afeca86037d5b5dd89ceeb0090eae9d
```

The output of `git write-tree` is the 40-character SHA-1 hash of the tree object
that was written to `.git/objects`.

That example assumes `test.txt` is the only staged file and has mode `100644`. A
tree's hash depends on every entry's mode, name, and object identifier, so
changing any of them changes the hash.

Your snapshot must include the blobs and trees referenced by the root tree. Each
subdirectory has its own tree, and each parent entry contains that subtree's
hash. Exclude `.git` itself. Entries use Git's byte-by-byte name order, treating
directory names as if they ended in `/` for comparison.

If you're testing this against `git` locally, make sure to run `git add .`
before `git write-tree`, so that all files in the working directory are staged.

### Tests

The tester will initialize a new Git repository using your program:

```bash
$ mkdir test_dir && cd test_dir
$ /path/to/your_program.sh init
```

It will then create some random files and directories:

```bash
$ echo "hello world" > test_file_1.txt
$ mkdir test_dir_1
$ echo "hello world" > test_dir_1/test_file_2.txt
$ mkdir test_dir_2
$ echo "hello world" > test_dir_2/test_file_3.txt
```

And then run your program like this:

```bash
$ /path/to/your_program.sh write-tree
<tree_sha>
```

Write the working directory's snapshot and print the root tree's 40-character
SHA-1 hash to stdout. `<tree_sha>` above is a placeholder for that result. File
contents and names vary between tests.

The tester will verify that the output of your program matches the SHA-1 hash of
the tree object that the official `git` implementation would write.

### Notes

- A directory named `foo` compares as `foo/`, so a file named `foo.bar` sorts
  before it. This distinction matters when matching Git's tree hashes.
