In this stage, you'll implement cloning a public repository from GitHub.

This is the last stage of the challenge, and probably the hardest across all of CodeCrafters!

We might split this into an extension with multiple stages in the future, but for now it's just one big stage.

We don't have detailed instructions for this stage, so you're all on your own here. A few pointers to get you started:

- [This forum post](https://forum.codecrafters.io/t/step-for-git-clone-implementing-the-git-protocol/4407) has some
  suggestions on how to incrementally implement this.
- You'll need to use Git's [Smart HTTP transfer protocol](https://www.git-scm.com/docs/http-protocol) for this.
- To know more about the protocol format, we recommend reading:
  - [gitprotocol-pack](https://git-scm.com/docs/gitprotocol-pack)
  - [gitformat-pack](https://git-scm.com/docs/gitformat-pack)
  - [Unpacking Git packfiles](https://codewords.recurse.com/issues/three/unpacking-git-packfiles)
  - [Sneaky git number encoding](https://medium.com/@concertdaw/sneaky-git-number-encoding-ddcc5db5329f)

{{#lang_is_rust}}
You can use the [reqwest](https://crates.io/crates/reqwest) crate to make
HTTP requests, we've included it in the `Cargo.toml` file.
{{/lang_is_rust}}

### Tests

The tester will run your program like this:

```bash
$ /path/to/your_program.sh clone https://github.com/blah/blah <some_dir>
```

Your program must create `<some_dir>` and clone the given repository into it.

To verify your changes, the tester will:

- Check the contents of a random file
- Read commit object attributes from the `.git` directory