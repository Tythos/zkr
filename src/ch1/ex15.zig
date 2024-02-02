/// src/ch1/ex15.zig
const std = @import("std");
const util = @import("./util.zig");

pub fn main() !void {
    var c: f32 = 0.0;
    const lower: f32 = 0.0;
    const upper: f32 = 100.0;
    const step: f32 = 10.0;

    try util.STDOUT("{s}\t{s}\n", .{ "C", "F" });
    try util.STDOUT("{s}\t{s}\n", .{ "===", "===" });
    c = lower;
    while (c <= upper) {
        try util.STDOUT("{d}\t{d}\n", .{ c, util.c2f(c) });
        c += step;
    }
}
