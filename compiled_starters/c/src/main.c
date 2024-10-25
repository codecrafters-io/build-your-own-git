#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/stat.h>
#include <errno.h>

int main(int argc, char *argv[]) {
    // Disable output buffering
    setbuf(stdout, NULL);
    setbuf(stderr, NULL);

    if (argc < 2) {
        fprintf(stderr, "Usage: ./your_program.sh <command> [<args>]\n");
        return 1;
    }
    
    const char *command = argv[1];
    
    if (strcmp(command, "init") == 0) {
        // You can use print statements as follows for debugging, they'll be visible when running tests.
        fprintf(stderr, "Logs from your program will appear here!\n");

        // Uncomment this block to pass the first stage
        // 
        // if (mkdir(".git", 0755) == -1 || 
        //     mkdir(".git/objects", 0755) == -1 || 
        //     mkdir(".git/refs", 0755) == -1) {
        //     fprintf(stderr, "Failed to create directories: %s\n", strerror(errno));
        //     return 1;
        // }
        // 
        // FILE *headFile = fopen(".git/HEAD", "w");
        // if (headFile == NULL) {
        //     fprintf(stderr, "Failed to create .git/HEAD file: %s\n", strerror(errno));
        //     return 1;
        // }
        // fprintf(headFile, "ref: refs/heads/main\n");
        // fclose(headFile);
        // 
        // printf("Initialized git directory\n");
    } else {
        fprintf(stderr, "Unknown command %s\n", command);
        return 1;
    }
    
    return 0;
}
