#include <iostream>
#include <filesystem>
#include <fstream>
#include <string>

int main(int argc, char *argv[])
{
    // Flush after every std::cout / std::cerr
    std::cout << std::unitbuf;
    std::cerr << std::unitbuf;

    // You can use print statements as follows for debugging, they'll be visible when running tests.
    std::cerr << "Logs from your program will appear here!\n";

    // Uncomment this block to pass the first stage
    //
    // if (argc < 2) {
    //     std::cerr << "No command provided.\n";
    //     return EXIT_FAILURE;
    // }
    //
    // std::string command = argv[1];
    //
    // if (command == "init") {
    //     try {
    //         std::filesystem::create_directory(".git");
    //         std::filesystem::create_directory(".git/objects");
    //         std::filesystem::create_directory(".git/refs");
    //
    //         std::ofstream headFile(".git/HEAD");
    //         if (headFile.is_open()) {
    //             headFile << "ref: refs/heads/main\n";
    //             headFile.close();
    //         } else {
    //             std::cerr << "Failed to create .git/HEAD file.\n";
    //             return EXIT_FAILURE;
    //         }
    //
    //         std::cout << "Initialized git directory\n";
    //     } catch (const std::filesystem::filesystem_error& e) {
    //         std::cerr << e.what() << '\n';
    //         return EXIT_FAILURE;
    //     }
    // } else {
    //     std::cerr << "Unknown command " << command << '\n';
    //     return EXIT_FAILURE;
    // }
    //
    // return EXIT_SUCCESS;
}
