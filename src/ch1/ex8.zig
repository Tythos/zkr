/// src/ch1/ex8.zig
const std = @import("std");
const stdbuf = @import("./stdbuf.zig");

/// counts blanks, tabs, and newlines from STDIN inpu
fn getNumBtn(text: []const u8) u32 {
    var count: u32 = 0;
    for (text) |char| {
        if (char == ' ' or char == '\t' or char == '\n') {
            count += 1;
        }
    }
    return count;
}

pub fn main() !void {
    const line: []const u8 = try stdbuf.STDIN();
    try stdbuf.STDOUT("There were {} blanks, tabs, and/or newlines\n", .{getNumBtn(line)});
}
