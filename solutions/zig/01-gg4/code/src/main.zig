const std = @import("std");

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    const args = try std.process.argsAlloc(allocator);
    defer std.process.argsFree(allocator, args);

    var stdout_buffer: [1024]u8 = undefined;
    var stdout_writer = std.fs.File.stdout().writer(&stdout_buffer);
    const stdout = &stdout_writer.interface;

    if (args.len < 2) {
        try stdout.print("Usage: {s} <command>\n", .{args[0]});
        return;
    }

    const command: []const u8 = args[1];

    try stdout.flush();

    if (std.mem.eql(u8, command, "init")) {
        const cwd = std.fs.cwd();
        _ = try cwd.makeDir("./.git");
        _ = try cwd.makeDir("./.git/objects");
        _ = try cwd.makeDir("./.git/refs");
        {
            const head = try cwd.createFile("./.git/HEAD", .{});
            defer head.close();
            _ = try head.write("ref: refs/heads/main\n");
        }
        try stdout.print("Initialized git directory\n", .{});
        try stdout.flush();
    }
}
