use anyhow::{anyhow, Result};

pub fn validate_sha1<T: AsRef<[u8]>>(hash: T) -> Result<()> {
    match hex::decode(hash) {
        Ok(_) => Ok(()),
        Err(e) => Err(anyhow!("Invalid sha1 - {}", e)),
    }
}
