/// src/ch1/ex4.zig
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
    var upper: f32 = 100.0;
    var step: f32 = 10.0;

    try STDOUT("{s}\t{s}\n", .{ "C", "F" });
    try STDOUT("{s}\t{s}\n", .{ "===", "===" });
    celsius = lower;
    while (celsius <= upper) {
        fahr = celsius * (9.0 / 5.0) + 32.0;
        try STDOUT("{d}\t{d}\n", .{ celsius, fahr });
        celsius += step;
    }
}
