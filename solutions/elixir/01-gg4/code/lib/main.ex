defmodule CLI do
  def main(args) do
    command = List.first(args)
    case command do
      "init" ->
        File.mkdir!(".git")
        File.mkdir!(".git/objects")
        File.mkdir!(".git/refs")
        File.write!(".git/HEAD", "ref: refs/heads/main\n")
        IO.puts("Initialized git directory")

      _ ->
        raise "Unknown command #{command}"
    end
  end
end
