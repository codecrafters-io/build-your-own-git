defmodule CLI do
  def main(argv) do
    # You can use print statements as follows for debugging, they'll be visible when running tests.
    IO.puts("Logs from your program will appear here!")

    # Uncomment this block to pass the first stage
    #
    # case argv do
    #   ["init" | _] ->
    #     :ok = File.mkdir(".git")
    #     :ok = File.mkdir(".git/objects")
    #     :ok = File.mkdir(".git/refs")
    #     :ok = File.write(".git/HEAD", "ref: refs/heads/main\n")
    #     IO.puts("Initialized git directory")
    #
    #   [command | _] ->
    #     IO.puts("Unknown command: #{command}")
    #     System.halt(1)
    #
    #   [] ->
    #     IO.puts("Usage: your_program.sh <command> <args>")
    #     System.halt(1)
    # end
  end
end
