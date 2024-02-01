/// src/ch1/ex12.zig
const std = @import("std");
const util = @import("./util.zig");

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();
    const line: []const u8 = try util.STDIN(allocator);
    defer allocator.free(line);

    // break each word across a line by replacing whitespace with newlines
    const lines = try util.replaceWhitespaceWithNewline(allocator, line);
    defer allocator.free(lines);

    // print report to STDOUT
    try util.STDOUT("{s}\n", .{lines});
}
