defmodule CLI do
  def main(argv) do
    case argv do
      ["init" | _] ->
        :ok = File.mkdir_p(".git")
        :ok = File.mkdir_p(".git/objects")
        :ok = File.mkdir_p(".git/refs")
        :ok = File.write(".git/HEAD", "ref: refs/heads/main\n")
        IO.puts("Initialized git directory")

      [command | _] ->
        IO.puts("Unknown command: #{command}")
        System.halt(1)

      [] ->
        IO.puts("Usage: your_program.sh <command> <args>")
        System.halt(1)
    end
  end
end
