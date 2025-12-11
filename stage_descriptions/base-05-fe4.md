In this stage, you’ll implement writing a tree to the `.git/objects` directory.

### Tree Object Storage (recap)

As a recap, tree objects store directory structures and are saved in the `.git/objects` directory.

For example, if a tree object has the hash `e88f7a929cd70b0274c4ea33b209c97fa845fdbc`, its path will be `.git/objects/e8/8f7a929cd70b0274c4ea33b209c97fa845fdbc`.

Here’s what a tree object file looks like (before Zlib compression):

```bash
tree <size>\0
<mode> <name>\0<20_byte_sha>
<mode> <name>\0<20_byte_sha>
```

*(The code block above uses newlines for readability, but the actual file does not contain newlines.)*

* The file begins with `tree <size>\0`. This is called the object header, and it works like the header in blob objects.
* After the header, the file contains several entries. Each entry follows the format `<mode> <name>\0<sha>`:
  * `<mode>` shows the type and permissions of the file or directory.
  * `<name>` is the name of the file or directory.
  * `\0` represents a null byte.
  * `<20_byte_sha>` is the 20-byte SHA-1 hash of the file or directory.

### The `<mode>` Field

The `<mode>` field shows the type and permissions for each entry. Some valid values include:

* `100644` - Regular file
* `100755` - Executable file
* `40000` - Directory (Tree object)

Note that directory mode is `40000`, not `040000`. Although Git commands like `git ls-tree` show directory modes as `040000` for readability, the actual mode stored in the tree object is `40000`.

You can read more about the internal format of a tree object [here](https://stackoverflow.com/questions/14790681/what-is-the-internal-format-of-a-git-tree-object).

### The `git write-tree` Command

The `git write-tree` command creates a tree object from the current state of the "staging area". The staging area is a place where changes go when you run `git add`.

For this challenge, you will not implement a staging area. Instead, assume that all files in the working directory are already staged.

Here's an example of using `git write-tree`:

```bash
# Create a file with some content
$ echo "hello world" > test.txt

# Add the file to the staging area (we won't implement a staging area in this challenge)
$ git add test.txt

# Write the tree to .git/objects
$ git write-tree
4b825dc642cb6eb9a060e54bf8d69288fbee4904
```

The output of `git write-tree` is the 40-character SHA-1 hash of the tree object that was written to `.git/objects`.

To implement the `git write-tree` command, you'll need to:

1. Iterate over the files or directories in the working directory.
2. If the entry is a file, create a blob object and record its SHA-1 hash.
3. If the entry is a directory, recursively create a tree object and record its SHA-1 hash.
4. Sort all entries **alphabetically by name**.
5. Once you have all the entries and their SHA-1 hashes, write the tree object to the `.git/objects` directory.

If you're testing this against `git` locally, make sure to run `git add .` before `git write-tree`, so that all files in the working directory are staged.

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
4b825dc642cb6eb9a060e54bf8d69288fbee4904
```

You're expected to write the entire working directory as a tree object and print the 40-character SHA-1 hash to stdout.

The tester will verify that the output of your program matches the SHA-1 hash of the tree object that the official `git` implementation would write.

### Notes

* Remember to ignore the `.git` directory when creating entries in the tree object and sort all entries alphabetically by name.
* Your implementation of `git write-tree` will need to handle nested directories. A recursive implementation will help here, since you’ll need to create tree objects for each subdirectory to be able to create the parent directory’s tree object.
* The `git write-tree` implementation here differs slightly from the official one. The official `git` implementation uses the staging area to determine what to write to the tree object. We’ll just assume that all files in the working directory are staged.
