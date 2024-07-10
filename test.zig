// zig build-lib test.zig -target wasm32-freestanding -mcpu=mvp+bulk_memory -O ReleaseSafe && wasm2wat -f libtest.a.o
// zig build-lib test.zig -target wasm32-freestanding -mcpu=mvp+bulk_memory -O Debug && wasm2wat -f libtest.a.o
// zig build-lib test.zig -target wasm32-freestanding -mcpu=mvp+bulk_memory -O Debug -fno-llvm -fno-lld -fno-libllvm -rdynamic && wasm2wat -f libtest.a

const std = @import("std");

export fn use(p: **void) void {
    p.* = @constCast(@ptrCast(&set));
    //p.* = @constCast(@ptrCast(&initA));
    //p.* = @constCast(@ptrCast(&initB));
    //p.* = @constCast(@ptrCast(&initC));
    //p.* = @constCast(@ptrCast(&pass));
}

pub fn add(a: i32, b: i32) i32 {
    @setRuntimeSafety(false);
    return a + b;
}

pub fn midpoint(a: i32, b: i32) i32 {
    @setRuntimeSafety(false);
    return @divTrunc(a + b, 2);
}

pub fn power(a: i32, b: i32) i32 {
    @setRuntimeSafety(false);
    var total: i32 = 1;
    for (0..@intCast(b)) |_| {
        total *= a;
    }
    return total;
}

const Pair = struct {
    a: i32,
    b: i32,
};

pub fn flipped(p: Pair) Pair {
    return .{ .a = p.b, .b = p.a };
}

pub fn flip(p: *Pair) void {
    p.* = .{ .a = p.b, .b = p.a };
}

const n = 2;
pub fn pass(p: [n]i32) [n]i32 {
    return p;
}

pub fn initA(c: i32) [1]i32 {
    return .{c};
}

pub fn initB(c: i32) [1]i32 {
    const tmp: [1]i32 = .{c};
    return tmp;
}

pub fn initC(c: i32) [1]i32 {
    const tmp = [1]i32{c};
    return tmp;
}

pub fn set(p: *[1]i32, c: [1]i32) void {
    p.* = c;
}

//pub fn main() void {
//    var p = Pair{ .a = 1, .b = 2 };
//    flip(&p);
//    std.debug.print("{any}\n", .{p});
//}

//pub fn squareMatrixRepeatedly(m: *[2][2]i32, n: usize) void {
//    @setRuntimeSafety(false);
//    for (0..n) |_| {
//        const squared = .{
//            .{
//                m[0][0] * m[0][0] + m[0][1] * m[1][0],
//                m[0][0] * m[0][1] + m[0][1] * m[1][1],
//            },
//            .{
//                m[1][0] * m[0][0] + m[1][1] * m[1][0],
//                m[1][0] * m[0][1] + m[1][1] * m[1][1],
//            },
//        };
//        m.* = squared;
//    }
//}
