const std = @import("std");
const util = @import("./util.zig");

pub fn main() !void {
    var max: usize = 0;
    var line: []const u8 = undefined;
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();

    //
    max = 0;
    line = try util.STDIN(allocator, false);
    while (line.len > 0) {
        if (line.len > 80) {
            try util.STDOUT("{s}\n", .{line});
        }
        line = try util.STDIN(allocator, false);
    }
}
