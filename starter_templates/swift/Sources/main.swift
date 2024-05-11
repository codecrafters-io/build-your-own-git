// The Swift Programming Language
// https://docs.swift.org/swift-book
import Foundation

// You can use print statements as follows for debugging, they'll be visible when running tests.
print("Logs from your program will appear here!")

// Uncomment this block to pass the first stage
//
//
//guard CommandLine.arguments.count > 1 else {
//    throw ArgumentError.missingCommand
//}
//
//switch CommandLine.arguments[1] {
//case "init":
//    try createGitDirectory()
//default:
//    throw ArgumentError.unknownCommand
//}
//
//enum ArgumentError: Error {
//    case missingCommand
//    case unknownCommand
//}
//
//func createGitDirectory() throws {
//    let currentPath = FileManager.default.currentDirectoryPath
//    let gitFolder = currentPath + "/.git"
//    try FileManager.default.createDirectory(atPath: gitFolder, withIntermediateDirectories: true)
//    let objectFolder = gitFolder + "/objects"
//    try FileManager.default.createDirectory(atPath: objectFolder, withIntermediateDirectories: true)
//    let refsFolder = gitFolder + "/refs"
//    try FileManager.default.createDirectory(atPath: refsFolder, withIntermediateDirectories: true)
//
//    let head = "ref: refs/heads/master\n"
//    let headPath = gitFolder + "/HEAD"
//    try head.write(toFile: headPath, atomically: true, encoding: .utf8)
//}
