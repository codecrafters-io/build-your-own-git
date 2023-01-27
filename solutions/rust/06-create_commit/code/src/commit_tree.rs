use crate::object::{store_object, GitObject};
use anyhow::Result;
use std::time::{SystemTime, UNIX_EPOCH};

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
