const std = @import("std");
const util = @import("./util.zig");

/// copies input to output, replacing each sequence of one or more whitespace
/// characters with a single space
fn consolidateWhitespace(allocator: std.mem.Allocator, input: []const u8) ![]u8 {
    var result: []u8 = undefined;
    var isFirstWhitespace = true;
    for (input) |char| {
        if (char == ' ' or char == '\t' or char == '\n') {
            if (isFirstWhitespace) {
                result = try util.concat(allocator, result, " ");
                isFirstWhitespace = false;
            }
        } else {
            isFirstWhitespace = true;
            const c = try util.c2s(allocator, char);
            defer allocator.free(c);
            result = try util.concat(allocator, result, c);
        }
    }
    return result;
}

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{ .verbose_log = true }){};
    const allocator = gpa.allocator();
    const line: []const u8 = try util.STDIN();
    const consolidated = try consolidateWhitespace(allocator, line);
    try util.STDOUT("{s}\n", .{consolidated});
    defer allocator.free(line);
    defer allocator.free(consolidated);
}
