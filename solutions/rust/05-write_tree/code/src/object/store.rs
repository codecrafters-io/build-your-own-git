use crate::object::GitObject;
use anyhow::Result;
use flate2::bufread::ZlibEncoder;
use flate2::Compression;
use sha1::{Digest, Sha1};
use std::fs::{create_dir, File};
use std::io::{BufReader, BufWriter};
use std::path::Path;

pub fn store_object(mut object: GitObject) -> Result<String> {
    let mut buffer = Vec::new();

    // Write the header
    buffer.extend(object.object_type.as_bytes());
    buffer.extend(" ".as_bytes());
    buffer.extend(object.content.len().to_string().as_bytes());
    buffer.push(0);

    // Write the content
    buffer.append(&mut object.content);

    let hash = calculate_sha1(&mut buffer);

    let output_file = create_output_file(&hash)?;

    let mut zlib_reader = ZlibEncoder::new(BufReader::new(&buffer[..]), Compression::fast());

    std::io::copy(&mut zlib_reader, &mut BufWriter::new(output_file))?;

    Ok(hash)
}

fn calculate_sha1(buffer: &Vec<u8>) -> String {
    let mut hasher = Sha1::new();
    hasher.update(&buffer);
    hex::encode(hasher.finalize())
}

fn create_output_file(object_id: &String) -> Result<File> {
    let sub_directory: String = object_id.chars().take(2).collect();
    let file_name: String = object_id.chars().skip(2).collect();
    let mut output_path = Path::new(".git").join("objects").join(sub_directory);
    if !output_path.exists() {
        create_dir(output_path.clone())?;
    }

    output_path = output_path.join(file_name);
    let file = File::create(output_path)?;
    Ok(file)
}
