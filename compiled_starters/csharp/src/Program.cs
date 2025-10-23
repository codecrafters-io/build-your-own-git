using System;
using System.IO;

if (args.Length < 1)
{
    Console.WriteLine("Please provide a command.");
    return;
}

// You can use print statements as follows for debugging, they'll be visible when running tests.
Console.Error.WriteLine("Logs from your program will appear here!");

string command = args[0];

if (command == "init")
{
    // Uncomment this block to pass the first stage
    //
    // Directory.CreateDirectory(".git");
    // Directory.CreateDirectory(".git/objects");
    // Directory.CreateDirectory(".git/refs");
    // File.WriteAllText(".git/HEAD", "ref: refs/heads/main\n");
    // Console.WriteLine("Initialized git directory");
}
else
{
    throw new ArgumentException($"Unknown command {command}");
}