You can now read and write Git objects locally. In this final stage, implement
`clone` to fetch a public GitHub repository's objects and restore its files in a
new directory.

### Objects over the network

Git's Smart HTTP protocol lets a client discover references and request the
objects they identify. A reference associates a name such as a branch with a
commit hash. The commit identifies the tree needed to reconstruct that
snapshot's files.

The transfer introduces two representations:

- Protocol messages use _pkt-line_ framing. Each packet starts with four
  hexadecimal characters giving its total byte length, including that prefix.
  `0000` is a special flush marker. These boundaries are separate from HTTP's
  own message boundaries.
- Objects arrive in a _packfile_, which holds many objects together. Pack
  entries have their own headers and compressed data. Some entries are deltas,
  instructions for reconstructing an object from another object. The pack format
  differs from the loose-object files you have written so far.

Cloning must leave both the repository objects and the checked-out files
available. A directory containing only `.git` has no working files yet. A copy
of the files alone has no commit history to inspect.

### Protocol references

This capstone leaves the protocol implementation to you. Use these references
for reference discovery, object transfer, pack headers, and delta encodings:

- [This forum post](https://forum.codecrafters.io/t/step-for-git-clone-implementing-the-git-protocol/4407)
  has some suggestions on how to incrementally implement this.
- You'll need to use Git's
  [Smart HTTP transfer protocol](https://www.git-scm.com/docs/http-protocol) for
  this.
- To know more about the protocol format, we recommend reading:
  - [gitprotocol-pack](https://git-scm.com/docs/gitprotocol-pack)
  - [gitformat-pack](https://git-scm.com/docs/gitformat-pack)
  - [Unpacking Git packfiles](https://codewords.recurse.com/issues/three/unpacking-git-packfiles)
  - [Sneaky git number encoding](https://medium.com/@concertdaw/sneaky-git-number-encoding-ddcc5db5329f)

### Tests

The tester will run your program like this:

```bash
$ /path/to/your_program.sh clone https://github.com/blah/blah <some_dir>
```

Your program must create `<some_dir>`, clone the given repository into it, and
exit successfully. The URL and directory are inputs, rather than fixed example
values.

To verify your changes, the tester will:

- Check the contents of a random file
- Read commit object attributes from the `.git` directory

### Notes

- This stage covers fetching a public repository over HTTP. Authentication,
  pushing changes, and a complete implementation of every Git transport are
  outside the task.

{{#lang_is_rust}}

- You can use the [reqwest](https://crates.io/crates/reqwest) crate to make HTTP
  requests. It's included in `Cargo.toml`. {{/lang_is_rust}}
