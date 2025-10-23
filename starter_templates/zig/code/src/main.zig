const std = @import("std");
const stdout = std.fs.File.stdout();

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    const args = try std.process.argsAlloc(allocator);
    defer std.process.argsFree(allocator, args);

    if (args.len < 2) {
        std.debug.print("Usage: {s} <command>\n", .{args[0]});
        return;
    }

    const command: []const u8 = args[1];

    // You can use print statements as follows for debugging, they'll be visible when running tests.
    std.debug.print("Logs from your program will appear here!\n", .{});

    if (std.mem.eql(u8, command, "init")) {
        // TODO: Uncomment the code below to pass the first stage
        // const cwd = std.fs.cwd();
        // _ = try cwd.makeDir("./.git");
        // _ = try cwd.makeDir("./.git/objects");
        // _ = try cwd.makeDir("./.git/refs");
        // {
        //     const head = try cwd.createFile("./.git/HEAD", .{});
        //     defer head.close();
        //     _ = try head.write("ref: refs/heads/main\n");
        // }
        // try stdout.writeAll("Initialized git directory\n");
    }
}
