extern crate core;

use anyhow::{anyhow, Result};
use clap::Parser;
use cli::Cli;
use std::fs;

mod cat_file;
mod cli;
mod commit_tree;
mod hash_object;
mod ls_tree;
mod object;
mod write_tree;

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
        cli::SubCommands::CatFile { pretty_print, hash } => {
            if !pretty_print {
                return Err(anyhow!("The `-p` flag is required"));
            }

            cat_file::pretty_cat_file(hash)?;
        }
        cli::SubCommands::HashObject { write, file } => {
            if !write {
                return Err(anyhow!("The `-w` flag is required"));
            }

            let hash = hash_object::hash_and_write_file(file)?;
            println!("{}", hash);
        }
        cli::SubCommands::LsTree { name_only, hash } => {
            if !name_only {
                return Err(anyhow!("The `--name-only` flag is required"));
            }

            ls_tree::ls_tree(hash)?;
        }
        cli::SubCommands::WriteTree => {
            let hash = write_tree::write_tree(".")?;
            println!("{}", hash);
        }
        cli::SubCommands::CommitTree {
            hash,
            parent_hash,
            message,
        } => {
            let hash = commit_tree::commit_tree(hash, parent_hash, message)?;
            println!("{}", hash);
        }
    }

    Ok(())
}
