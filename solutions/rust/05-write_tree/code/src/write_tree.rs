use crate::hash_object::hash_and_write_file;
use crate::object::{store_object, GitObject};
use anyhow::Result;
use std::fs::{read_dir, DirEntry};
use std::os::unix::ffi::OsStrExt;
use std::path::Path;

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
