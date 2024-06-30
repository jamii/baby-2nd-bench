const std = @import("std");
const allocator = std.heap.wasm_allocator;

export fn alloc(len: usize) [*c]u8 {
    return allocator.allocSentinel(u8, len, 0) catch std.debug.panic("oom", .{});
}

export fn free(ptr: [*c]u8, len: usize) void {
    allocator.free(@as([:0]u8, @ptrCast(ptr[0..len])));
}

pub export fn tokenize(source: [*c]u8, len: usize) usize {
    var count: usize = 0;
    var tokenizer = std.zig.Tokenizer.init(@ptrCast(source[0..len]));
    while (tokenizer.next().tag != .eof) {
        count += 1;
    }
    return count;
}

pub fn main() void {}
