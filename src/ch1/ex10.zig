/// src/ch1/ex10.zig
const std = @import("std");
const util = @import("./util.zig");

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();
    const line: []const u8 = try util.STDIN(allocator);
    defer allocator.free(line);
    const shorter: []const u8 = try util.disambiguateString(allocator, line);
    try util.STDOUT("{s}\n", .{shorter});
}
