mod hash;
mod load;

pub use hash::validate_sha1;
pub use load::{GitObject, load_object};
