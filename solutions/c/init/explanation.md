The entry point for your Docker implementation is in `app/main.c`.

Study and uncomment the relevant code: 

```c
// Uncomment this block to pass the first stage

char *command = argv[3];
int child_pid = fork();
if (child_pid == -1) {
    printf("Error forking!");
    return 1;
}

if (child_pid == 0) {
	   // Replace current program with calling program
    execv(command, &argv[3]);
} else {
	   // We're in parent
	   wait(NULL);
	   printf("Child terminated");
}
```

Push your changes to pass the first stage:

```
git add .
git commit -m "pass 1st stage" # any msg
git push origin master
```
