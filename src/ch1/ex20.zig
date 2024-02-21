const std = @import("std");
const util = @import("./util.zig");

const TAB_WIDTH_CHARS: u8 = 4;

fn printTabMarks() !void {
    const nTabs = @divTrunc(80, TAB_WIDTH_CHARS);
    const tab: []const u8 = " " ** (TAB_WIDTH_CHARS - 1) ++ "^";
    for (0..nTabs) |_| {
        try util.STDOUT("{s}", .{tab});
    }
    try util.STDOUT("\n", .{});
}

pub fn main() !void {
    //var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    //const allocator = gpa.allocator();

    //
    const from: []const u8 = "this\tis\ta\ttabbed\tsentance";
    var runningTotal: usize = 0;
    for (from) |char| {
        if (char == '\t') {
            const spacesUntilTab = TAB_WIDTH_CHARS - @rem(runningTotal, TAB_WIDTH_CHARS);
            for (0..spacesUntilTab) |_| {
                try util.STDOUT(" ", .{});
            }
            runningTotal += spacesUntilTab;
        } else {
            try util.STDOUT("{c}", .{char});
            runningTotal += 1;
        }
    }
    try util.STDOUT("\n", .{});
    try printTabMarks();
    try util.STDOUT("{s}\n", .{from});
    try printTabMarks();
}
