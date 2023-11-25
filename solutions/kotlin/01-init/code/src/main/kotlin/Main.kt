import java.io.File

fun main(args: Array<String>) {
   when (args[0]) {
       "init" -> {
           listOf(".git", ".git/objects", ".git/refs").forEach { File(it).mkdir() }
           File(".git/HEAD").writeText("ref: refs/heads/master\n")
           println("Initialized git directory")
       }

       else -> throw IllegalArgumentException("Unknown command: ${args[0]}")
   }
}
