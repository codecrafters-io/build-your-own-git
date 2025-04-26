defmodule CLI do
  def main(argv) do
    case argv do
      ["init" | _] ->
        :ok = File.mkdir(".git")
        :ok = File.mkdir(".git/objects")
        :ok = File.mkdir(".git/refs")
        :ok = File.write(".git/HEAD", "ref: refs/heads/main\n")
        IO.puts("Initialized git directory")

      [command | _] ->
        IO.puts("Unknown command: #{command}")
        System.halt(1)

      [] ->
        IO.puts("Usage: your_script.sh <command> <args>")
        System.halt(1)
    end
  end
end
