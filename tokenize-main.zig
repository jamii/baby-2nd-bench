const std = @import("std");
const allocator = std.heap.page_allocator;

pub fn main() !void {
    const cwd = std.fs.cwd();

    const file = try cwd.openFile("big.zig", .{ .mode = .read_write });
    defer file.close();

    const len_expected = @as(usize, @intCast((try file.stat()).size));
    const source = allocator.allocSentinel(u8, len_expected, 0) catch unreachable;
    defer allocator.free(source);

    const len_actual = try file.readAll(source);
    std.debug.assert(len_actual == len_expected);

    var count: usize = 0;
    var tokenizer = std.zig.Tokenizer.init(source);
    while (tokenizer.next().tag != .eof) {
        count += 1;
    }

    std.debug.print("{} tokens\n", .{count});
}
