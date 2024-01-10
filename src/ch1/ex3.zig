/// src/ch1/ex3.zig
const std = @import("std");

/// defines a useful STDOUT writer that combines the std.io File, buffered
/// writer, and flush operation.
fn STDOUT(comptime str: []const u8, fmt: anytype) !void {
    const stdout = std.io.getStdOut().writer();
    var buffer = std.io.bufferedWriter(stdout);
    try buffer.writer().print(str, fmt);
    try buffer.flush();
}

pub fn main() !void {
    var fahr: f32 = 0.0;
    var celsius: f32 = 0.0;
    var lower: f32 = 0.0;
    var upper: f32 = 300.0;
    var step: f32 = 20.0;

    try STDOUT("{s}\t{s}\n", .{ "F", "C" });
    try STDOUT("{s}\t{s}\n", .{ "===", "===" });
    fahr = lower;
    while (fahr <= upper) {
        celsius = (5.0 / 9.0) * (fahr - 32.0);
        try STDOUT("{d}\t{d}\n", .{ fahr, celsius });
        fahr += step;
    }
}
