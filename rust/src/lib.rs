// RUSTFLAGS='-C target-feature=+bulk-memory -C overflow-checks=off' cargo build --target=wasm32-unknown-unknown --release; wasm2wat -f target/wasm32-unknown-unknown/release/testrs.wasm > test.wat
// RUSTFLAGS='-C target-feature=+bulk-memory -C overflow-checks=off' cargo build --target=wasm32-unknown-unknown; wasm2wat -f target/wasm32-unknown-unknown/debug/testrs.wasm > test.wat

#[no_mangle]
#[inline(never)]
pub fn square_n_times(m: &mut [[i32; 2]; 2], n: u32) {
    for _ in 0..n {
        let squared = [
            [
                m[0][0] * m[0][0] + m[0][1] * m[1][0],
                m[0][0] * m[0][1] + m[0][1] * m[1][1],
            ],
            [
                m[1][0] * m[0][0] + m[1][1] * m[1][0],
                m[1][0] * m[0][1] + m[1][1] * m[1][1],
            ],
        ];
        *m = squared;
    }
}
