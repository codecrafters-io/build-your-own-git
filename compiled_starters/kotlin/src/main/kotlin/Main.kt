import java.io.File
import kotlin.system.exitProcess

fun main(args: Array<String>) {
    // You can use print statements as follows for debugging, they'll be visible when running tests.
    System.err.println("Logs from your program will appear here!")

    if (args.isEmpty()) {
        println("Usage: your_program.sh <command> [<args>]")
        exitProcess(1)
    }

    if (args[0] == "init") {
        // Uncomment this block to pass the first stage
        //
        // val gitDir = File(".git")
        // gitDir.mkdir()
        // File(gitDir, "objects").mkdir()
        // File(gitDir, "refs").mkdir()
        // File(gitDir, "HEAD").writeText("ref: refs/heads/master\n")
        //
        // println("Initialized git directory")
    } else {
        println("Unknown command: ${args[0]}")
        exitProcess(1)
    }
}
