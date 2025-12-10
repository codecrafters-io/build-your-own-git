In this stage, you'll implement the `git commit-tree` command, which creates a commit object.

### Commits

Let's move on to the last git object we'll be dealing with in this challenge: [the commit](https://git-scm.com/book/en/v2/Git-Internals-Git-Objects#_git_commit_objects).

A commit object contains information like:
- Tree SHA (points to the working directory state)
- Parent commit SHA(s), if any
- Author name + email + timestamp
- Committer name + email + timestamp
- Commit message

### The `git commit-tree` Command

The `git commit-tree` command creates a commit object. Example usage:

```bash
$ mkdir test_dir && cd test_dir
$ git init
Initialized empty Git repository in /path/to/test_dir/.git/

# Create a tree, get its SHA
$ echo "hello world" > test.txt
$ git add test.txt
$ git write-tree
4b825dc642cb6eb9a060e54bf8d69288fbee4904

# Create the initial commit
$ git commit-tree 4b825dc642cb6eb9a060e54bf8d69288fbee4904 -m "Initial commit"
3b18e512dba79e4c8300dd08aeb37f8e728b8dad

# Write some changes, get another tree SHA
$ echo "hello world 2" > test.txt
$ git add test.txt
$ git write-tree
5b825dc642cb6eb9a060e54bf8d69288fbee4904

# Create a new commit with the new tree SHA and parent
$ git commit-tree 5b825dc642cb6eb9a060e54bf8d69288fbee4904 -p 3b18e512dba79e4c8300dd08aeb37f8e728b8dad -m "Second commit"
6c18e512dba79e4c8300dd08aeb37f8e728b8dad
```

The output of `git commit-tree` is the 40-character SHA-1 hash of the commit object that was written to `.git/objects`.

### Commit File Storage

Like blob and tree objects, commit objects follow the same storage format. A commit object file looks like this (before Zlib compression):

```
commit <size>\0tree <tree_sha>
parent <parent_sha>
author <name> <email> <timestamp> <timezone>
committer <name> <email> <timestamp> <timezone>

<commit message>
```

Key points about the format:
- The file starts with `commit <size>\0` (same header pattern as blob and tree objects)
- After the header, the content is plain text (not binary)
- Each line ends with a newline character (`\n`)
- Tree and parent SHAs are in **hexadecimal format** (40 characters), unlike tree objects, where they're 20 bytes
- There's a blank line between the metadata and the commit message
- Timestamp format: `<seconds_since_epoch> <timezone_offset>` (e.g., `1234567890 +0000`)

Example commit object content:
```
commit 177\0tree 4b825dc642cb6eb9a060e54bf8d69288fbee4904
parent 3b18e512dba79e4c8300dd08aeb37f8e728b8dad
author John Doe <john@example.com> 1234567890 +0000
committer John Doe <john@example.com> 1234567890 +0000

Initial commit
```

You can read more about the commit object format [here](https://stackoverflow.com/questions/22968856/what-is-the-file-format-of-a-git-commit-object-data-structure).

### Tests

Your program will be invoked like this:

```bash
$ ./your_program.sh commit-tree <tree_sha> -p <commit_sha> -m <message>
```

Your program must create a commit object and print its 40-character SHA-1 hash to stdout.

To keep things simple:
- You'll receive exactly one parent commit
- You'll receive exactly one line in the message
- You're free to hardcode any valid name/email for the author/committer fields
- You can use any valid timestamp (e.g., current time or a hardcoded value)

The tester will verify your changes by reading the commit object from the `.git` directory using the `git show` command.
