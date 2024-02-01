/// src/ch1/ex11.zig
const std = @import("std");
const util = @import("./util.zig");

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();
    const line: []const u8 = try util.STDIN(allocator);
    defer allocator.free(line);

    // count lines, words, and characters in the input line
    const nLines = util.getNumLines(line);
    const nWords = util.getNumWords(line);
    const nChars = util.getNumChars(line);
    try util.STDOUT("There are {} lines, {} words, and {} characters\n", .{ nLines, nWords, nChars });
}
