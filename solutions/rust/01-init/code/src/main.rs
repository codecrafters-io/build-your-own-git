#[allow(unused_imports)]
use std::fs;
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
}


// Usage: your_git.sh <command> <arg1> <arg2> ...
fn main() {
    let git_cli = Cli::parse();
    match git_cli.command {
        SubCommands::Init => {
            fs::create_dir(".git").unwrap();
            fs::create_dir(".git/objects").unwrap();
            fs::create_dir(".git/refs").unwrap();
            fs::write(".git/HEAD", "ref: refs/heads/master\n").unwrap();
            println!("Initialized git directory")
        }
    }
}
