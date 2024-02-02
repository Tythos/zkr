/// src/ch1/ex14.zig
const std = @import("std");
const util = @import("./util.zig");

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();
    const line: []const u8 = try util.STDIN(allocator);
    defer allocator.free(line);

    // break each word across a line by replacing whitespace with newlines
    var counts: std.AutoArrayHashMap(u8, u32) = try util.getCharCounts(line, allocator);

    // print report to STDOUT
    for (counts.keys()) |k| {
        if (counts.get(k)) |v| {
            try util.STDOUT("'{c}': ", .{k});
            for (0..v) |_| {
                try util.STDOUT("#", .{});
            }
            try util.STDOUT("\n", .{});
        }
    }
}
