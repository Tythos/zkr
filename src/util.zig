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
pub fn STDIN(allocator: std.mem.Allocator) ![]const u8 {
    const stdin = std.io.getStdIn().reader();
    var buffer = std.io.bufferedReader(stdin);
    std.debug.print("> ", .{});
    var msg_buf: [1024]u8 = undefined;
    const result = try buffer.reader().readUntilDelimiterOrEof(&msg_buf, '\n');
    if (result) |line| {
        // copy into allocated memory (persist unless error)
        const strbuf = try allocator.alloc(u8, line.len);
        errdefer allocator.free(strbuf);
        @memcpy(strbuf, line);
        return strbuf;
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

/// Returns the length of a string if consecutive whitespaces are consolidated
/// into a single space.
fn getConsolidatedLength(input: []const u8) u32 {
    var result: u32 = 0;
    var isFirstWhitespace = true;
    for (input) |char| {
        if (char == ' ' or char == '\t' or char == '\n') {
            if (isFirstWhitespace) {
                result += 1;
                isFirstWhitespace = false;
            }
        } else {
            isFirstWhitespace = true;
            result += 1;
        }
    }
    return result;
}

/// Returns a new string defined by the given string with any whitespace
/// sequences replaced by a single space.
pub fn consolidateString(allocator: std.mem.Allocator, line: []const u8) ![]const u8 {
    // allocate line read from STDIN, compute lengths
    const after = getConsolidatedLength(line);
    //const before = line.len;
    //try STDOUT("consolidated from {} to {} characters (reduction of {})\n", .{ before, after, before - after });

    // allocate "shorter" string from length
    var shorter = try allocator.alloc(u8, after);
    errdefer allocator.free(shorter);
    var i: u32 = 0;
    var isFirstWhitespace = true;

    // iterate over characters in original string and copy
    for (line) |char| {
        if (char == ' ' or char == '\t' or char == '\n') {
            // if it's whitespace, we only add and increment if it's the first one in a row
            if (isFirstWhitespace) {
                shorter[i] = ' ';
                isFirstWhitespace = false;
                i += 1;
            }
        } else {
            // if it's not whitespace, we reset the "first" flag, add, and increment
            isFirstWhitespace = true;
            shorter[i] = char;
            i += 1;
        }
    }
    return shorter;
}

/// Returns the length of a hypothetical string in which special characters are
/// replaced with their "escaped" character string equivalents.
pub fn getDisambiguatedLength(input: []const u8) u32 {
    var result: u32 = 0;
    for (input) |char| {
        if (char == '\t') {
            // will be replaced by litteral "\t"
            result += 2;
            // } else if (char == '\b') {
            // will be replaced by litteral "\b"
            // result += 2;
        } else if (char == '\\') {
            // will be replaced by litteral "\\"
            result += 2;
        } else {
            result += 1;
        }
    }
    return result;
}

/// Returns a new string defined by the given string with any special
/// characters replaced with their "escaped" character string equivalent.
pub fn disambiguateString(allocator: std.mem.Allocator, line: []const u8) ![]const u8 {
    const after = getDisambiguatedLength(line);
    var longer = try allocator.alloc(u8, after);
    errdefer allocator.free(longer);
    var i: u32 = 0;

    // iterate over characters in original string and copy
    for (line) |char| {
        if (char == '\t') {
            longer[i] = '\\';
            longer[i + 1] = 't';
            i += 2;
            // } else if (char == '\b') {
            //     longer[i] = '\\';
            //     longer[i + 1] = 'b';
            //     i += 2;
        } else if (char == '\\') {
            longer[i] = '\\';
            longer[i + 1] = '\\';
            i += 2;
        } else {
            longer[i] = char;
            i += 1;
        }
    }
    return longer;
}
