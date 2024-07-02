// zig build-lib test.zig -target wasm32-freestanding -mcpu=mvp+bulk_memory -O ReleaseSafe && wasm2wat -f libtest.a.o
// zig build-lib test.zig -target wasm32-freestanding -mcpu=mvp+bulk_memory -O Debug && wasm2wat -f libtest.a.o
// zig build-lib test.zig -target wasm32-freestanding -mcpu=mvp+bulk_memory -O Debug -fno-llvm -fno-lld -fno-libllvm -rdynamic && wasm2wat -f libtest.a

const std = @import("std");

export fn use(p: **void) void {
    p.* = @constCast(@ptrCast(&midpoint));
    p.* = @constCast(@ptrCast(&squareNTimes));
}

pub fn midpoint(a: i32, b: i32) i32 {
    @setRuntimeSafety(false);
    return @divTrunc(a + b, 2);
}

pub fn squareNTimes(m: *[2][2]i32, n: usize) void {
    @setRuntimeSafety(false);
    for (0..n) |_| {
        const squared = .{
            .{
                m[0][0] * m[0][0] + m[0][1] * m[1][0],
                m[0][0] * m[0][1] + m[0][1] * m[1][1],
            },
            .{
                m[1][0] * m[0][0] + m[1][1] * m[1][0],
                m[1][0] * m[0][1] + m[1][1] * m[1][1],
            },
        };
        m.* = squared;
    }
}
