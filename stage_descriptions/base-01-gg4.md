Git keeps repository objects and references separately from the files you edit.
In this stage, you'll implement `init` to create the `.git` directory that holds
them.

### The `git init` command

<details>
  <summary>Click to expand/collapse</summary>

`git init` initializes a Git repository by creating a `.git` directory with some
files and directories inside it.

You can read about
[what's inside `.git`](https://blog.meain.io/2023/what-is-in-dot-git/). We've
included the files and directories required for this stage below.

</details>

### The `.git` directory

<details>
  <summary>Click to expand/collapse</summary>

Create this layout in the current working directory:

```
- .git/
  - objects/
  - refs/
  - HEAD
```

- `objects/` will hold
  [Git objects](https://git-scm.com/book/en/v2/Git-Internals-Git-Objects), the
  stored contents and history of the repository. It starts empty.
- `refs/` will hold
  [Git references](https://git-scm.com/book/en/v2/Git-Internals-Git-References),
  which give names, such as branch names, to commits. It also starts empty.
- `HEAD` identifies the currently checked out branch. Use either
  `ref: refs/heads/main\n` or `ref: refs/heads/master\n`. Here `\n` means one
  newline byte at the end. The branch does not point to a commit yet, so you
  don't need to create a branch file.

</details>

### Tests

The tester will run your program in a new empty directory like this:

```bash
# Create a new directory and cd into it
$ mkdir test_dir && cd test_dir

# Run your program
$ /path/to/your_program.sh init
```

The command must exit successfully and create the directories and `HEAD` file
shown above. The tester checks the filesystem, so printing a success message
alone is insufficient.

```bash
# Check if .git directory exists
$ test -d .git

# Check if .git/objects directory exists
$ test -d .git/objects

# Check if .git/refs directory exists
$ test -d .git/refs

# Check if .git/HEAD file exists
$ test -f .git/HEAD

# Check if .git/HEAD contains either "ref: refs/heads/main\n" or "ref: refs/heads/master\n"
$ cat .git/HEAD
```

### Notes

- Git creates additional files and directories during a normal `git init`. This
  stage requires only the small layout above.
- The `.git/HEAD` file has a newline at the end.
