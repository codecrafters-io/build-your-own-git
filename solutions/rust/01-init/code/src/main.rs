use std::fs;
use cli::Cli;
use clap::Parser;

mod cli;

// Usage: your_git.sh <command> <arg1> <arg2> ...
fn main() {
    let git_cli = Cli::parse();
    match git_cli.command {
        cli::SubCommands::Init => {
            fs::create_dir(".git").unwrap();
            fs::create_dir(".git/objects").unwrap();
            fs::create_dir(".git/refs").unwrap();
            fs::write(".git/HEAD", "ref: refs/heads/master\n").unwrap();
            println!("Initialized git directory")
        }
    }
}
