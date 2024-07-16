import java.io.File
import kotlin.system.exitProcess

fun main(args: Array<String>) {
    if (args.isEmpty()) {
        println("Usage: your_program.sh <command> [<args>]")
        exitProcess(1)
    }

    if (args[0] == "init") {
        val gitDir = File(".git")
        gitDir.mkdir()
        File(gitDir, "objects").mkdir()
        File(gitDir, "refs").mkdir()
        File(gitDir, "HEAD").writeText("ref: refs/heads/master\n")

        println("Initialized git directory")
    } else {
        println("Unknown command: ${args[0]}")
        exitProcess(1)
    }
}
