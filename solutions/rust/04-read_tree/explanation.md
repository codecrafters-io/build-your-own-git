Reading a tree is similar to reading a blob. So before we get into
this stage we will extract a `load_object` function. It will return

```rust
pub struct GitObject {
    pub object_type: String,
    pub content: Vec<u8>,
}
```

Where the object type will be `"tree"` or `"blob"` and the content depends
on the object type.

The function is in `object::load` and is very similar to what `cat_file` used to do. Both
`cat_file` and the code for this stage will use it.

Now onto the implementation of `ls-tree`. Because we now have the `content` loaded in
`GitObject` we need a way to get back to a `BufReader` so we can parse the content. We will
do this using a `Cursor`.

```rust
let mut reader = BufReader::new(Cursor::new(content));
```

Now we can go ahead and parse the tree, printing file names as we go

```rust
fn print_names(content: Vec<u8>) -> Result<()> {
    let content_len = content.len();
    let mut reader = BufReader::new(Cursor::new(content));
    while reader.stream_position()? < content_len as u64 {
        let mut buffer = Vec::new();
        reader.read_until(' ' as u8, &mut buffer)?;
        buffer.pop();

        buffer.clear();
        reader.read_until(0, &mut buffer)?;
        buffer.pop();

        let file_name = String::from_utf8(buffer)?;

        // Size of the sha1 hash
        reader.seek_relative(20)?;

        println!("{}", file_name);
    }

    Ok(())
}
```

Where each line contains `100644<space>file_name.txt<null_byte><20_byte_sha1>`.

This is similar to how the `type<space><content_length><null_byte>...` format is read at the top level.
The new piece here is the `seek_relative` function which skips ahead in the read buffer, ignoring the hash of
the current file in the tree.
