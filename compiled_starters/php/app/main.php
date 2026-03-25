<?php
error_reporting(E_ALL);

if (count($argv) < 2) {
    throw new RuntimeException("No command provided");
}

// You can use print statements as follows for debugging, they'll be visible when running tests.
fwrite(STDERR, "Logs from your program will appear here!\n");

// TODO: Uncomment the code below to pass the first stage
// 
// $command = $argv[1];
// if ($command === "init") {
//     mkdir(".git");
//     mkdir(".git/objects");
//     mkdir(".git/refs");
//     file_put_contents(".git/HEAD", "ref: refs/heads/main\n");
//     fwrite(STDOUT, "Initialized git directory\n");
//     return;
// }

throw new RuntimeException("Unknown command #{$command}");