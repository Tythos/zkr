/// src/main.zig
const std = @import("std");

/// defines a useful STDOUT writer that combines the std.io File, buffered
/// writer, and flush operation.
fn STDOUT(comptime str: []const u8, fmt: anytype) !void {
    const stdout = std.io.getStdOut().writer();
    var buffer = std.io.bufferedWriter(stdout);
    try buffer.writer().print(str, fmt);
    try buffer.flush();
}

// fn linspace(start: f64, stop: f64, n: i32) []f64 {}

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
    var celsius: f64 = 0.0;
    var lower: f64 = 0.0;
    var upper: f64 = 300.0;
    var step: f64 = 30.0;

    try STDOUT("{s}\t{s}\n", .{ "F", "C" });
    try STDOUT("{s}\t{s}\n", .{ "===", "===" });
    var fahrs = try arange(upper, lower, -step);
    defer fahrs.deinit();
    for (fahrs.items) |fahr| {
        celsius = (fahr - 32.0) * (5.0 / 9.0);
        try STDOUT("{d}\t{d}\n", .{ fahr, celsius });
    }
}
