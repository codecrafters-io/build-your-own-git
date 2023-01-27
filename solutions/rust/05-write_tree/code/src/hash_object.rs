use crate::object::{store_object, GitObject};
use anyhow::Result;
use std::fs::File;
use std::io::{BufReader, Read};
use std::path::Path;

pub fn hash_and_write_file<P: AsRef<Path>>(path: P) -> Result<String> {
    let source_file = File::open(path)?;
    let mut reader = BufReader::new(source_file);

    let mut buffer = Vec::new();
    reader.read_to_end(&mut buffer)?;

    store_object(GitObject {
        object_type: "blob".to_string(),
        content: buffer,
    })
}
