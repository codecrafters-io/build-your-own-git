In this stage, you'll implement `init` to create the `.git` directory. This
gives your Git implementation a place to store repository objects and references
separately from the files you edit.

### The `git init` command

<details>
  <summary>Click to expand/collapse</summary>

`git init` initializes a Git repository by creating a `.git` directory with some
files and directories inside it.

You can learn more about what's inside the `.git` folder
[here](https://blog.meain.io/2023/what-is-in-dot-git/). We've included the files
and directories required for this stage below.

</details>

### The `.git` directory

<details>
  <summary>Click to expand/collapse</summary>

Create this layout in the current working directory:

```
- .git/
  - objects/
  - refs/
  - HEAD (should contain "ref: refs/heads/main\n" for a new repository)
```

- `objects/`
  - This directory will hold
    [Git objects](https://git-scm.com/book/en/v2/Git-Internals-Git-Objects), the
    stored contents and history of the repository. It starts empty.
- `refs/`
  - [Git references](https://git-scm.com/book/en/v2/Git-Internals-Git-References)
    give names, such as branch names, to commits. This directory also starts
    empty.
- `HEAD`
  - This file contains a reference to the currently checked out branch.
  - Use the contents `ref: refs/heads/main\n`. Here `\n` means one newline byte
    at the end. The branch does not point to a commit yet, so you don't need to
    create a branch file.

You can learn more about these in detail
[here](https://blog.meain.io/2023/what-is-in-dot-git/).

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
- The `.git/HEAD` file can contain either `ref: refs/heads/main\n` or
  `ref: refs/heads/master\n`, the tester will work with either of these.
