// RUSTFLAGS='-C target-feature=+bulk-memory' cargo build --target=wasm32-unknown-unknown; wasm2wat -f target/wasm32-unknown-unknown/debug/testrs.wasm > test.wat
// RUSTFLAGS='-C target-feature=+bulk-memory' cargo build --target=wasm32-unknown-unknown --release; wasm2wat -f target/wasm32-unknown-unknown/release/testrs.wasm > test.wat
// RUSTFLAGS='-C target-feature=+bulk-memory -C opt-level=1' cargo build --target=wasm32-unknown-unknown --release; wasm2wat -f target/wasm32-unknown-unknown/release/testrs.wasm > test.wat

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