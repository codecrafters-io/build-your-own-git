All the data for a Git repository — from its commit history to its configuration — lives inside a hidden folder called `.git`. It’s created when you initialize a new repository with `git init`. In this stage, you’ll implement that command yourself.

<!--

### The `git init` command

<details>
  <summary>Click to expand/collapse</summary>

  `git init` initializes a Git repository by creating a `.git` directory with some files
  & directories inside it.

  You can learn more about what's inside the `.git` folder [here](https://blog.meain.io/2023/what-is-in-dot-git/). We've
  included a description of the files & directores we'll be dealing with in this stage below.

</details>

### The `.git` directory

<details>
  <summary>Click to expand/collapse</summary>

  At a bare minimum, a `.git` directory should contain the following files & directories:

  ```
  - .git/
    - objects/
    - refs/
    - HEAD (should contain "ref: refs/heads/main\n" for a new repository)
  ```

  - `objects/`
    - This directory contains [Git objects](https://git-scm.com/book/en/v2/Git-Internals-Git-Objects).
    - We'll learn more about what Git objects are in later stages.
  - `refs/`
    - This directory contains [Git references](https://git-scm.com/book/en/v2/Git-Internals-Git-References).
    - We'll deal with this in later stages too.
  - `HEAD`
    - This file contains a reference to the currently checked out branch.
    - For a new repository, it's contents will be `ref: refs/heads/main\n`.

  You can learn more about these in detail [here](https://blog.meain.io/2023/what-is-in-dot-git/).
</details>

### Tests

The tester will run your program in a new empty directory like this:

```bash
# Create a new directory and cd into it
$ mkdir test_dir && cd test_dir

# Run your program
$ /path/to/your_program.sh init
```

It'll then check if the `.git` directory and its contents are created correctly.

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

- Git actually creates more files & directories than the ones mentioned above when you run `git init`. We've only included the ones
  that are absolutely necessary for Git to function properly.
- The `.git/HEAD` file has a newline at the end.
- The `.git/HEAD` file can contain either `ref: refs/heads/main\n` or `ref: refs/heads/master\n`, the tester will
  work with either of these.

-->
