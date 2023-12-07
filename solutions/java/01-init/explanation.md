The entry point for your Git implementation is in `src/main/java/Main.java`.

Study and uncomment the relevant code: 

```java
// Uncomment this block to pass the first stage

final String command = args[0];

switch (command) {
  case "init" -> {
    final File root = new File(".git");
    new File(root, "objects").mkdirs();
    new File(root, "refs").mkdirs();
    final File head = new File(root, "HEAD");

    try {
      head.createNewFile();
      Files.write(head.toPath(), "ref: refs/heads/master\n".getBytes());
      System.out.println("Initialized git directory");
    } catch (IOException e) {
      throw new RuntimeException(e);
    }
  }
  default -> System.out.println("Unknown command: " + command);
}
```

Push your changes to pass the first stage:

```
git add .
git commit -m "pass 1st stage" # any msg
git push origin master
```
