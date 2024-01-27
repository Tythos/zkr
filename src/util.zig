/// std/stdbuf.zig
const std = @import("std");

/// Defines a useful STDOUT writer that combines the std.io File, buffered
/// writer, and flush operation.
pub fn STDOUT(comptime str: []const u8, fmt: anytype) !void {
    const stdout = std.io.getStdOut().writer();
    var buffer = std.io.bufferedWriter(stdout);
    try buffer.writer().print(str, fmt);
    try buffer.flush();
}

/// Defines a useful STIN reader that combines the std.io File, buffered
/// reader, and a blank-string fallback. The string is allocated on up to 1024
/// bytes of the stack. Reading may fail.
pub fn STDIN() ![]u8 {
    const stdin = std.io.getStdIn().reader();
    var buffer = std.io.bufferedReader(stdin);
    std.debug.print("> ", .{});
    var msg_buf: [1024]u8 = undefined;
    const result = try buffer.reader().readUntilDelimiterOrEof(&msg_buf, '\n');
    if (result) |line| {
        return line;
    } else {
        return "";
    }
}

/// Uses the debug warner to write a message to STDERR
pub fn STDERR(str: []const u8) void {
    std.debug.warn(str);
}

/// Concatenates two strings to allocate and return the result
pub fn concat(allocator: std.mem.Allocator, lhs: []const u8, rhs: []const u8) ![]u8 {
    const n = lhs.len + rhs.len;
    var result = try allocator.alloc(u8, n);
    @memcpy(result[0..lhs.len], lhs);
    @memcpy(result[lhs.len..n], rhs);
    return result;
}

/// Allocates and returns a single-character string
pub fn c2s(allocator: std.mem.Allocator, char: u8) ![]u8 {
    const result = try allocator.alloc(u8, 1);
    result[0] = char;
    return result;
}
