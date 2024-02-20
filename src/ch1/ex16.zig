const std = @import("std");
const util = @import("./util.zig");

pub fn main() !void {
    var max: usize = 0;
    var line: []const u8 = undefined;
    var longest: []const u8 = undefined;
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();

    //
    max = 0;
    line = try util.STDIN(allocator, false);
    while (line.len > 0) {
        if (line.len > max) {
            max = line.len;
            longest = try allocator.dupe(u8, line);
        }
        line = try util.STDIN(allocator, false);
    }
    if (max > 0) {
        try util.STDOUT("len('{s}') = {}\n", .{ longest, max });
    }
}
