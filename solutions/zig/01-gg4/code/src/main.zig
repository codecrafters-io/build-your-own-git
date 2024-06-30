const std = @import("std");
const stdout = std.io.getStdOut().writer();

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    const args = try std.process.argsAlloc(allocator);
    defer std.process.argsFree(allocator, args);

    if (args.len < 2) {
        try std.io.getStdErr().writer().print("Usage: {s} <command>\n", .{args[0]});
        return;
    }

    const command: []const u8 = args[1];

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
        _ = try stdout.print("Initialized git directory\n", .{});
    }
}
