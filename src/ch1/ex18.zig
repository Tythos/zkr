const std = @import("std");
const util = @import("./util.zig");

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();

    //
    const line: []const u8 = "    \n this is a test \r\n     ";
    const trimmed: []const u8 = try util.trim(allocator, line);
    try util.STDOUT("\n'{s}'\n", .{trimmed});
}
