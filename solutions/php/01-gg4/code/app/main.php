<?php
error_reporting(E_ALL);

if (count($argv) < 2) {
    throw new RuntimeException("No command provided");
}

$command = $argv[1];
if ($command === "init") {
    mkdir(".git");
    mkdir(".git/objects");
    mkdir(".git/refs");
    file_put_contents(".git/HEAD", "ref: refs/heads/main\n");
    fwrite(STDOUT, "Initialized git directory\n");
    return;
}

throw new RuntimeException("Unknown command #{$command}");