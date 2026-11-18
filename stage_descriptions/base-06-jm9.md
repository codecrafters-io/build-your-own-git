Your tree objects describe directory snapshots. A commit connects a snapshot to
the repository's history. In this stage, you'll implement `commit-tree` to
attach a snapshot to a parent commit and a message.

### Commits

The final object type introduced in this challenge is the
[commit object](https://git-scm.com/book/en/v2/Git-Internals-Git-Objects#_git_commit_objects).
It refers to a tree for the snapshot and to earlier commits for its history. The
author identifies who originally wrote the change, while the committer
identifies who recorded this commit.

A commit object file looks like this (before Zlib compression):

```
commit <size>\0tree <tree_sha>
parent <parent_sha>
author <name> <<email>> <timestamp> <timezone>
committer <name> <<email>> <timestamp> <timezone>

<commit message>
```

- The file starts with `commit <size>\0` (same header pattern as blob and tree
  objects).
- After the header, the content consists of text lines. `<size>` counts these
  content bytes, excluding the header.
- Each line ends with a newline character (`\n`).
- The tree and parent SHAs use their 40-character hexadecimal form. Tree entries
  use raw 20-byte identifiers.
- There's a blank line between the metadata and the commit message.
- The timestamp format is `<seconds_since_epoch> <timezone_offset>`, such as
  `1234567890 +0000`. The timestamp counts seconds since 1 January 1970 UTC. The
  offset uses `+HHMM` or `-HHMM`, with `+0000` meaning UTC.

Here's an example of a commit object:

```
commit 217\0tree 4b825dc642cb6eb9a060e54bf8d69288fbee4904
parent 3b0466d22854e57bf9ad3ccf82008a2d3f199550
author John Doe <john@example.com> 1234567890 +0000
committer John Doe <john@example.com> 1234567890 +0000

Example commit
```

This example has 217 content bytes, including the final newline after the
message. It refers to an empty tree and an example parent commit. Use the tree,
parent, and message supplied to your command. Hash and store the complete object
using the same header, SHA-1, and zlib conventions as earlier stages.

Read more about
[the commit object format](https://stackoverflow.com/questions/22968856/what-is-the-file-format-of-a-git-commit-object-data-structure).

### The `git commit-tree` command

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
c3b8bb102afeca86037d5b5dd89ceeb0090eae9d

# Create the initial commit
$ git commit-tree c3b8bb102afeca86037d5b5dd89ceeb0090eae9d -m "Initial commit"
<initial_commit_sha>

# Write some changes, get another tree SHA
$ echo "hello world 2" > test.txt
$ git add test.txt
$ git write-tree
<new_tree_sha>

# Create a new commit with the new tree SHA and parent
$ git commit-tree <new_tree_sha> -p <initial_commit_sha> -m "Second commit"
<new_commit_sha>
```

The output of `git commit-tree` is the 40-character SHA-1 hash of the commit
object written to `.git/objects`. Replace the angle-bracket placeholders above
with the hashes returned by the preceding commands. Commit hashes also depend on
identity and timestamp fields, so yours can differ for the same tree and
message.

The initial-commit example shows Git's behavior. This stage requires only the
single-parent form below. Creating the commit object does not update a branch
reference.

### Tests

Your program will be invoked like this:

```bash
$ ./your_program.sh commit-tree <tree_sha> -p <commit_sha> -m <message>
```

Create the commit object with the supplied tree, parent, and message, then print
its 40-character SHA-1 hash to stdout. The stored message must end with a
newline.

To keep things simple:

- You'll receive exactly one parent commit.
- You'll receive exactly one line in the message.
- You're free to hardcode any valid name and email for the author/committer
  fields.
- You can use any valid timestamp (e.g., current time or a hardcoded value).

The tester reads the commit object from `.git` and verifies its tree, parent,
and message. You can also inspect the result locally with `git show`.

### Notes

- The author and committer lines are usually the same for simple commits. You
  can hardcode values like `John Doe <john@example.com> 1234567890 +0000`.
