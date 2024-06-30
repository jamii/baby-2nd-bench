const std = @import("std");
var gpa = std.heap.GeneralPurposeAllocator(.{}){};
const allocator = gpa.allocator();

pub fn main() !void {
    const cwd = std.fs.cwd();

    const file = try cwd.openFile("big.zig", .{ .mode = .read_write });
    defer file.close();

    const source = try file.readToEndAllocOptions(allocator, std.math.maxInt(usize), null, 1, 0);
    defer allocator.free(source);

    var count: usize = 0;
    var tokenizer = std.zig.Tokenizer.init(source);
    while (tokenizer.next().tag != .eof) {
        count += 1;
    }

    std.debug.print("{} tokens\n", .{count});
}
