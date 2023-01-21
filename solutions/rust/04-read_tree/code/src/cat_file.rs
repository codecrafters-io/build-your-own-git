use anyhow::{anyhow, Result};
use std::io::{stdout, Read, Cursor};
use crate::object::{GitObject, load_object, validate_sha1};

pub fn pretty_cat_file(hash: String) -> Result<()> {
    validate_sha1(hash.as_str())?;

    let GitObject{ object_type, content } = load_object(hash)?;

    if object_type.as_str() != "blob" {
        return Err(anyhow!("Unsupported object type: {}", object_type));
    }

    print_blob(Cursor::new(content))
}

fn print_blob<R>(mut reader: R) -> Result<()>
where
    R: Read,
{
    std::io::copy(&mut reader, &mut stdout())?;
    Ok(())
}
