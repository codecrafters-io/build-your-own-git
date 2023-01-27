This stage doesn't require any refactoring, we already have the tools we need. The new thing in
this stage is the format of the `commit` object. A good start is to run the `git show` command that
the stage instructions mention. You can do this in the repository that you're building your solutions 
in if you've already made at least one commit. That will give a good starting point to go looking 
for documentation.

The commit object is built as follows

```rust
pub fn commit_tree(hash: String, parent_hash: String, message: String) -> Result<String> {
    let mut content: Vec<u8> = Vec::new();

    content.extend_from_slice(format!("tree {}\n", hash).as_bytes());
    content.extend_from_slice(format!("parent {}\n", parent_hash).as_bytes());

    let now = SystemTime::now().duration_since(UNIX_EPOCH)?.as_secs();
    content.extend_from_slice(
        format!("author Your Name <your_email@example.com> {} +0000\n", now).as_bytes(),
    );

    content.extend_from_slice(format!("\n{}", message).as_bytes());
    if !message.ends_with("\n") {
        content.push(b'\n');
    }

    let hash = store_object(GitObject {
        object_type: "commit".to_string(),
        content,
    })?;

    Ok(hash)
}
```
