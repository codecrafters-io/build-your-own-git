use clap::{Parser, Subcommand};

#[derive(Parser)]
pub struct Cli {
    #[command(subcommand)]
    pub command: SubCommands,
}

#[derive(Subcommand)]
pub enum SubCommands {
    /// Initialise a new repository
    Init,

    /// Provide content or type and size information for repository objects
    CatFile {
        /// Pretty print the object
        #[arg(short)]
        pretty_print: bool,

        /// The object to cat
        hash: String,
    },
}
