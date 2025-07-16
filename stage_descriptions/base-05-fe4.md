In this stage, you'll implement writing a tree to the `.git/objects` directory.

### The `git write-tree` command

<details>
  <summary>Click to expand/collapse</summary>

  The `git write-tree` command creates a tree object from the current state of the "staging area". The
  staging area is a place where changes go when you run `git add`.

  In this challenge we won't implement a staging area, we'll just assume that all files in the working directory are staged.

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

  The output of `git write-tree` is the 40-char SHA-1 hash of the tree object that was written to `.git/objects`.

  To implement this, you'll need to:

  - Iterate over the files/directories in the working directory
  - If the entry is a file, create a blob object and record its SHA-1 hash
  - If the entry is a directory, recursively create a tree object and record its SHA-1 hash
  - Once you have all the entries and their SHA-1 hashes, write the tree object to the `.git/objects` directory

  If you're testing this against `git` locally, make sure to run `git add .` before `git write-tree`, so that
  all files in the working directory are staged.

</details>

### Tree File Storage (recap)

<details>
  <summary>Click to expand/collapse</summary>

  We covered the format of a tree object file in the previous stage. Here's a quick recap of what
  a tree object file looks like (before Zlib compression):

  ```
  tree <size>\0
  <mode> <name>\0<20_byte_sha>
  <mode> <name>\0<20_byte_sha>
  ```

  (The above code block is formatted with newlines for readability, but the actual file doesn't contain newlines)

  - The file starts with `tree <size>\0`. This is the "object header", similar to what we saw with blob objects.
  - After the header, there are multiple entries. Each entry is of the form `<mode> <name>\0<sha>`.
    - `<mode>` is the mode of the file/directory
    - `<name>` is the name of the file/directory
    - `\0` is a null byte
    - `<20_byte_sha>` is the 20-byte SHA-1 hash of the blob/tree (this is **not** in hexadecimal format)

  You can read more about the internal format of a tree object [here](https://stackoverflow.com/questions/14790681/what-is-the-internal-format-of-a-git-tree-object).

</details>

### Tests

The tester will initialize a new Git repository using your program:

```bash
$ mkdir test_dir && cd test_dir
$ /path/to/your_program.sh init
```

It'll create some random files and directories:

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

You're expected to write the entire working directory as a tree object
and print the 40-char SHA-1 hash to stdout.

The tester will verify that the output of your program matches the SHA-1 hash
of the tree object that the official `git` implementation would write.

### Notes

- Remember to ignore the `.git` directory when creating entries in the tree object.
- Your implementation of `git write-tree` will need to handle nested directories. A recursive implementation
  will help here, since you'll need to create tree objects for each subdirectory to be able to create the
  parent directory's tree object.
- The implementation of `git write-tree` here differs slightly from the official `git` implementation. The
  official `git` implementation uses the staging area to determine what to write to the tree object. We'll
  just assume that all files in the working directory are staged.