In this stage we need to reverse the steps from the previous stage.

We start by finding the size of the input file

```rust
let source_file = File::open(path)?;
let size = source_file.metadata()?.len();
let mut reader = BufReader::new(source_file);
```

Then we can build a buffer and put the header and content into it

```rust
let mut buffer = Vec::new();

// Write the header
buffer.extend("blob ".as_bytes());
buffer.extend(size.to_string().as_bytes());
buffer.push(0);

// Write the content
reader.read_to_end(&mut buffer)?;
```

Using the buffer we can compute the sha1 hash of the whole object

```rust
let mut hasher = Sha1::new();
hasher.update(&buffer);
hex::encode(hasher.finalize())
```

The hex representation of the hash can be used to construct the path of the output file and the buffer
is then written to that file.
