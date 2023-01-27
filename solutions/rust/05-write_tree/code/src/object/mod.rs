mod hash;
mod load;
mod store;

pub use hash::validate_sha1;
pub use load::load_object;
pub use store::store_object;

pub struct GitObject {
    pub object_type: String,
    pub content: Vec<u8>,
}
