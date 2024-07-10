// RUSTFLAGS='-C target-feature=+bulk-memory -C overflow-checks=off' cargo build --target=wasm32-unknown-unknown --release; wasm2wat -f target/wasm32-unknown-unknown/release/testrs.wasm > test.wat
// RUSTFLAGS='-C target-feature=+bulk-memory -C overflow-checks=off -C opt-level=0 -C debuginfo=0' cargo build --target=wasm32-unknown-unknown; wasm2wat -f target/wasm32-unknown-unknown/release/testrs.wasm > test.wat
// RUSTFLAGS='-C target-feature=+bulk-memory -C overflow-checks=off' cargo build --target=wasm32-unknown-unknown; wasm2wat -f target/wasm32-unknown-unknown/debug/testrs.wasm > test.wat


pub fn add(a: i32, b: i32) -> i32 {
    a + b
}


pub fn set(p: &mut [i32;1], c: i32) {
    p[0] = c;
}

pub fn xor_with(p: &mut [i32;1], c: i32) {
    p[0] = std::ops::BitXor::bitxor(p[0],c);
}


pub fn set_b(p: &mut [[[i32;1];1];1], c: i32) {
    *p = [[[c]]];
}


pub fn init_a(c: i32) -> [[[i32;1];1];1] {
    [[[c]]]
}

pub fn init_b(c: i32) -> [[[i32;1];1];1] {
    let tmp = [[[c]]];
    tmp
}

#[no_mangle]
#[inline(never)]
pub fn flipped(m: [[i32; 2]; 2]) -> [[i32; 2]; 2] {
   [[m[0][0], m[1][0]], [m[0][1], m[1][0]]]
}

pub fn square_n_times(m: &mut [[i32; 2]; 2], n: u32) {
    for _ in 0..n {
        *m = [
            [
                m[0][0] * m[0][0] + m[0][1] * m[1][0],
                m[0][0] * m[0][1] + m[0][1] * m[1][1],
            ],
            [
                m[1][0] * m[0][0] + m[1][1] * m[1][0],
                m[1][0] * m[0][1] + m[1][1] * m[1][1],
            ],
        ];
    }
}
