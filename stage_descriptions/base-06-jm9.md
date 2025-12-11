In this stage, you'll implement the `git commit-tree` command, which creates a commit object.

### Commits

The last git object we'll be dealing with in this challenge is the [commit object](https://git-scm.com/book/en/v2/Git-Internals-Git-Objects#_git_commit_objects).

A commit object file looks like this (before Zlib compression):

```
commit <size>\0tree <tree_sha>
parent <parent_sha>
author <name> <<email>> <timestamp> <timezone>
committer <name> <<email>> <timestamp> <timezone>

<commit message>
```

- The file starts with `commit <size>\0` (same header pattern as blob and tree objects).
- After the header, the content is plain text (not binary).
- Each line ends with a newline character (`\n`).
- The tree and parent SHAs are in hexadecimal format (40 characters), unlike with tree objects, where they're `20` bytes.
- There's a blank line between the metadata and the commit message.
- The timestamp format is: `<seconds_since_epoch> <timezone_offset>` (e.g., `1234567890 +0000`).

Here's an example of a commit object:
```
commit 177\0tree 4b825dc642cb6eb9a060e54bf8d69288fbee4904
parent 3b18e512dba79e4c8300dd08aeb37f8e728b8dad
author John Doe <john@example.com> 1234567890 +0000
committer John Doe <john@example.com> 1234567890 +0000

Initial commit
```

You can read more about the commit object format [here](https://stackoverflow.com/questions/22968856/what-is-the-file-format-of-a-git-commit-object-data-structure).

### The `git commit-tree` Command

The `git commit-tree` command creates a commit object.

For example:

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

### Tests

Your program will be invoked like this:

```bash
$ ./your_program.sh commit-tree <tree_sha> -p <commit_sha> -m <message>
```

Your program must create a commit object and print its 40-character SHA-1 hash to stdout.

To keep things simple:
- You'll receive exactly one parent commit.
- You'll receive exactly one line in the message.
- You're free to hardcode any valid name and email for the author/committer fields.
- You can use any valid timestamp (e.g., current time or a hardcoded value).

The tester will verify your changes by reading the commit object from the `.git` directory using the `git show` command.

### Notes

- The author and committer lines are usually the same for simple commits. You can hardcode values like `John Doe <john@example.com> 1234567890 +0000`.
