The entry point for your Git implementation is in `app/main.c`.

Study and uncomment the relevant code: 

```c
// Uncomment this block to pass the first stage

if (mkdir(".git", 0755) == -1 ||
    mkdir(".git/objects", 0755) == -1 ||
    mkdir(".git/refs", 0755) == -1) {
    fprintf(stderr, "Failed to create directories: %s\n", strerror(errno));
    return 1;
}

FILE *headFile = fopen(".git/HEAD", "w");
if (headFile == NULL) {
    fprintf(stderr, "Failed to create .git/HEAD file: %s\n", strerror(errno));
    return 1;
}
fprintf(headFile, "ref: refs/heads/main\n");
fclose(headFile);

printf("Initialized git directory\n");
```

Push your changes to pass the first stage:

```
git add .
git commit -m "pass 1st stage" # any msg
git push origin master
```
