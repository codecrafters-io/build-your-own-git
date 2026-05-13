import argv
import gleam/io
import gleam/list
import simplifile

pub fn main() -> Nil {
  let args = argv.load().arguments
  case list.first(args) {
    Ok("init") -> {
      let assert Ok(_) = simplifile.create_directory_all(".git/objects")
      let assert Ok(_) = simplifile.create_directory_all(".git/refs")
      let assert Ok(_) =
        simplifile.write(to: ".git/HEAD", contents: "ref: refs/heads/main\n")
      io.println("Initialized git directory")
    }
    Ok(command) -> io.println("Unknown command: " <> command)
    Error(_) -> Nil
  }
}
