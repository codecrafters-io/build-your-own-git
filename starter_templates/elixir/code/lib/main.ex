defmodule CLI do
  def main(args) do
    # You can use print statements as follows for debugging, they'll be visible when running tests.
    IO.puts(:stderr, "Logs from your program will appear here!")

    # TODO: Uncomment the code below to pass the first stage
    #
    # command = List.first(args)
    # case command do
    #   "init" ->
    #     File.mkdir!(".git")
    #     File.mkdir!(".git/objects")
    #     File.mkdir!(".git/refs")
    #     File.write!(".git/HEAD", "ref: refs/heads/main\n")
    #     IO.puts("Initialized git directory")
    #
    #   _ ->
    #     raise "Unknown command #{command}"
    # end
  end
end
