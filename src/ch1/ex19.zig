const std = @import("std");
const util = @import("./util.zig");

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();

    //
    var line = try util.STDIN(allocator, false);
    while (line.len > 0) {
        const reversed: []const u8 = try util.reverse(allocator, line);
        try util.STDOUT("'{s}' => '{s}'\n", .{ line, reversed });
        line = try util.STDIN(allocator, false);
    }
}
