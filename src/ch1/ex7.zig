/// src/ch1/ex7.zig
const std = @import("std");

/// defines a useful STDOUT writer that combines the std.io File, buffered
/// writer, and flush operation.
fn STDOUT(comptime str: []const u8, fmt: anytype) !void {
    const stdout = std.io.getStdOut().writer();
    var buffer = std.io.bufferedWriter(stdout);
    try buffer.writer().print(str, fmt);
    try buffer.flush();
}

/// defines a useful STIN reader that combines the std.io File, buffered
/// reader, and a blank-string fallback.
fn STDIN() ![]u8 {
    const stdin = std.io.getStdIn().reader();
    var buffer = std.io.bufferedReader(stdin);
    std.debug.print("> ", .{});
    var msg_buf: [4096]u8 = undefined;
    var msg = try buffer.reader().readUntilDelimiterOrEof(&msg_buf, '\n');
    if (msg) |m| {
        return m;
    } else {
        return "";
    }
}

/// defines a numpy.arange analog for generating (allocating) a list of
/// floating point values between start and end with the given step size
fn arange(start: f64, end: f64, step: f64) !std.ArrayList(f64) {
    const allocator = std.heap.page_allocator;
    var result = std.ArrayList(f64).init(allocator);
    var currentValue: f64 = start;
    if (0 < step) {
        while (currentValue <= end) : (currentValue += step) {
            try result.append(currentValue);
        }
    } else {
        while (end <= currentValue) : (currentValue += step) {
            try result.append(currentValue);
        }
    }
    return result;
}

pub fn main() !void {
    try STDOUT("{}\n", .{null});
}
