/// src/ch1/ex7.zig
const std = @import("std");
const stdbuf = @import("./stdbuf.zig");

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
    try stdbuf.STDOUT("{any}\n", .{arange(0.0, 1.0, 0.2)});
}
