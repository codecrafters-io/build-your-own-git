Similarly to the previous stage, we need to make some code we've already written re-usable.

The code from stage 3, for `hash-object` has been extracted to `object::store`.

For this stage, we need to reverse the steps from the previous stage to build tree objects.
There are a few pieces involved that we can tackle piece by piece.

The first piece is the file mode. These are largely internal to Git an not thoroughly [documented](https://git-scm.com/book/en/v2/Git-Internals-Git-Objects). 
They are a 16-bit number, with the high 4 bits specifying Git's type of the file and the low 9 bits
map to Unix file permissions (e.g. `755`) with 3 bits given to each digit. A file is identified to Git by the bit pattern
`1000` and a directory is `0100`. These can be described in Rust as constants

```rust
const DIRECTORY_FLAG: u16 = 1 << 14;
const FILE_FLAG: u16 = 1 << 15;
```

You don't need to produce valid modes to pass this stage and this solution hard-codes a file permission of `777`.

The next piece of the solution is working out what files to include in the tree object, and in what order. We can get a 
list of files and directories in the current directory using `read_dir`. The ordering of the output isn't guaranteed so we 
need to sort it

```rust
let mut files: Vec<DirEntry> = read_dir(path)?.map(|f| f.unwrap()).collect();
files.sort_by_key(|f| f.file_name());
```

Then we also need to make sure that we don't try to read the `.git` directory. This is being done by filtering out any 
file or directory names starting with '.'

```rust
if file.file_name().to_str().unwrap().starts_with('.') {
    continue;
}
```

This would be a problem if Git did it this simply because many tools, including Git itself, rely on files starting with `.` 
for configuration data. It is good enough for our purposes though and avoids problems with traversing unwanted directories.

The final two pieces are to 
1. call ourselves recursively on directories to build a full tree and 
2. assemble the output content for each tree object, following the same format as we did in the previous stage

Putting everything together we get

```rust
const DIRECTORY_FLAG: u16 = 1 << 14;
const FILE_FLAG: u16 = 1 << 15;

pub fn write_tree<P: AsRef<Path>>(path: P) -> Result<String> {
    let mut files: Vec<DirEntry> = read_dir(path)?.map(|f| f.unwrap()).collect();
    files.sort_by_key(|f| f.file_name());

    let mut content: Vec<u8> = Vec::new();

    for file in files {
        if file.file_name().to_str().unwrap().starts_with('.') {
            continue;
        }

        let file_type = file.file_type()?;

        let (hash, mode) = if file_type.is_dir() {
            let hash = write_tree(file.path())?;

            (hash, DIRECTORY_FLAG)
        } else if file_type.is_file() {
            let hash = hash_and_write_file(file.path())?;

            (hash, FILE_FLAG | 0o777)
        } else {
            // Symlinks not supported
            continue;
        };

        content.extend_from_slice(format!("{:06o} ", mode).as_bytes());
        content.extend_from_slice(file.file_name().as_bytes());
        content.push(0);
        content.append(&mut hex::decode(hash)?);
    }

    let hash = store_object(GitObject {
        object_type: "tree".to_string(),
        content,
    })?;

    Ok(hash)
}
```
