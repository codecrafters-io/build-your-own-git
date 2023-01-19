extern crate core;

use anyhow::{anyhow, Result};
use clap::Parser;
use cli::Cli;
use std::fs;

mod cat_file;
mod cli;
mod hash_object;

// Usage: your_git.sh <command> <arg1> <arg2> ...
fn main() -> Result<()> {
    let git_cli = Cli::parse();
    match git_cli.command {
        cli::SubCommands::Init => {
            fs::create_dir(".git").unwrap();
            fs::create_dir(".git/objects").unwrap();
            fs::create_dir(".git/refs").unwrap();
            fs::write(".git/HEAD", "ref: refs/heads/master\n").unwrap();
            println!("Initialized git directory")
        }
        cli::SubCommands::CatFile {
            pretty_print,
            object,
        } => {
            if !pretty_print {
                return Err(anyhow!("The `-p` flag is required"));
            }

            cat_file::pretty_cat_file(object)?;
        }
        cli::SubCommands::HashObject { write, file } => {
            if !write {
                return Err(anyhow!("The `-w` flag is required"));
            }

            let sha = hash_object::hash_and_write_file(file)?;
            println!("{}", sha);
        }
    }

    Ok(())
}
