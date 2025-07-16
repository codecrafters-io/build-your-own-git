In this stage, you'll implement the `git commit-tree` command, which is used to create a commit object.

### Commits

Let's move on to the last git object we'll be dealing with in this
challenge: [the commit](https://git-scm.com/book/en/v2/Git-Internals-Git-Objects#_git_commit_objects).

A commit object contains information like:

- Committer/Author name + email
- Timestamp
- Tree SHA
- Parent commit SHA(s), if any

We don't have a detailed description of the commit object format here, but you can read more about it
[here](https://stackoverflow.com/questions/22968856/what-is-the-file-format-of-a-git-commit-object-data-structure).

### The `git commit-tree` command

The `git commit-tree` command creates a commit object. Example usage:

```bash
# Create a new directory and cd into it
$ mkdir test_dir && cd test_dir

# Initialize a new git repository
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

# Create a new commit with the new tree SHA
$ git commit-tree 5b825dc642cb6eb9a060e54bf8d69288fbee4904 -p 3b18e512dba79e4c8300dd08aeb37f8e728b8dad -m "Second commit"
```

The output of `git commit-tree` is the 40-char SHA-1 hash of the commit object that was written to `.git/objects`.

### Tests

Your program will be invoked like this:

```
$ ./your_program.sh commit-tree <tree_sha> -p <commit_sha> -m <message>
```

Your program must create a commit object and print its 40-char SHA-1 hash to
stdout.

To keep things simple:

- You'll receive exactly one parent commit
- You'll receive exactly one line in the message
- You're free to hardcode any valid name/email for the author/committer fields


To verify your changes, the tester will read the commit object from the
`.git` directory. It'll use the `git show` command to do this.