// RUSTFLAGS='-C target-feature=+bulk-memory' cargo build --target=wasm32-unknown-unknown --release; wasm2wat -f target/wasm32-unknown-unknown/release/testrs.wasm > test.wat
// RUSTFLAGS='-C target-feature=+bulk-memory' cargo build --target=wasm32-unknown-unknown; wasm2wat -f target/wasm32-unknown-unknown/debug/testrs.wasm > test.wat

#[no_mangle]
pub fn xor(left: usize, right: usize) -> usize {
    std::ops::BitXor::bitxor(left,  right)
}

#[no_mangle]
#[inline(never)]
fn set(x: &mut [[u32; 2]; 2]) {
  *x = [[0,1],[2,3]];
}

#[no_mangle]
#[inline(never)]
fn set2(x: &mut [[[u32; 1]; 1]; 1]) {
  *x = [[[0]]];
}

#[no_mangle]
#[inline(never)]
pub fn flip(x: &mut [[u32; 2]; 2]) {
    *x = [
        [x[0][0], x[1][0]],
        [x[0][1], x[1][1]],
    ];
}

#[no_mangle]
#[inline(never)]
pub fn flip2(x: &mut [u32; 3]) {
    *x = [x[2], x[1], x[0]];
}

#[no_mangle]
#[inline(never)]
pub fn flipped(x: [[u32; 2]; 3]) -> [[u32; 2]; 3] {
    return [x[2], x[1], x[0]];
}

#[no_mangle]
#[inline(never)]
pub fn squareNTimes(m: &mut [[i32; 2]; 2], n: u32) {
    let a = m[0][0];
    let b = m[0][1];
    let c = m[1][0];
    let d = m[1][1];
    for _ in 0..n {
        *m = [
            [ a * a + b * c, a * b + b * d ],
            [ c * a + d * c, c * b + d * d ],
        ];
    }
}