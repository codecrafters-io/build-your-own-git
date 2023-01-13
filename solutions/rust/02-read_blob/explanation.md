Understanding how Git creates [blobs](https://git-scm.com/book/en/v2/Git-Internals-Git-Objects) is the key to this stage.

Our input is the 40 character hex representation of the sha-1 hash of the file we need to load. The first two
characters are a directory and the remaining 38 are the file name. So the file path we need is obtained using

```rust
let sub_directory: String = object.chars().take(2).collect();
let file_name: String = object.chars().skip(2).collect();
let path = Path::new(".git").join("objects").join(sub_directory).join(file_name);
```

We can then load the file and decompress it

```rust
let file = BufReader::new(File::open(path)?);
let decoder = ZlibDecoder::new(file);
```

The remaining work is done by the `print_file` function. It uses a `BufReader` so that it can read the header sections of the file
and examine them to learn the expected content of the remainder.

The header has the format `<type> <content-length><zero-byte>` and the content immediately follows.
