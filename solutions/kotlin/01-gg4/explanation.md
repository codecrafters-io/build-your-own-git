The entry point for your Git implementation is in `src/main/kotlin/Main.kt`.

Study and uncomment the relevant code: 

```kotlin
// Uncomment this block to pass the first stage

val gitDir = File(".git")
gitDir.mkdir()
File(gitDir, "objects").mkdir()
File(gitDir, "refs").mkdir()
File(gitDir, "HEAD").writeText("ref: refs/heads/master\n")

println("Initialized git directory")
```

Push your changes to pass the first stage:

```
git add .
git commit -m "pass 1st stage" # any msg
git push origin master
```
