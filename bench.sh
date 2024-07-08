#!/usr/bin/env bash

set -eu

echo "x86_64"
hyperfine 'zig build-exe -fstrip -target x86_64-linux tokenize-main.zig -OReleaseSafe'
hyperfine './tokenize-main'
hyperfine 'zig build-exe -fstrip -target x86_64-linux tokenize-main.zig -ODebug'
hyperfine './tokenize-main'
hyperfine 'zig build-exe -fstrip -target x86_64-linux tokenize-main.zig -ODebug -fno-llvm -fno-lld -fno-libllvm'
hyperfine './tokenize-main'

echo "x86"
hyperfine 'zig build-exe -fstrip -target x86-linux tokenize-main.zig -OReleaseSafe'
hyperfine './tokenize-main'
hyperfine 'zig build-exe -fstrip -target x86-linux tokenize-main.zig -ODebug'
hyperfine './tokenize-main'
hyperfine 'zig build-exe -fstrip -target x86-linux tokenize-main.zig -ODebug -fno-llvm -fno-lld -fno-libllvm'
hyperfine './tokenize-main'

echo "wasi + wasmtime"
hyperfine 'zig build-exe -fstrip tokenize-main.zig -target wasm32-wasi -mcpu=mvp+bulk_memory -OReleaseSafe'
hyperfine 'wasmtime compile tokenize-main.wasm'
hyperfine 'wasmtime run --allow-precompiled --dir ./ ./tokenize-main.cwasm'
hyperfine 'zig build-exe -fstrip tokenize-main.zig -target wasm32-wasi -mcpu=mvp+bulk_memory -ODebug'
hyperfine 'wasmtime compile tokenize-main.wasm'
hyperfine 'wasmtime run --allow-precompiled --dir ./ ./tokenize-main.cwasm'
hyperfine 'zig build-exe -fstrip tokenize-main.zig -target wasm32-wasi -mcpu=mvp+bulk_memory -ODebug -fno-llvm -fno-lld -fno-libllvm'
hyperfine 'wasmtime compile tokenize-main.wasm'
hyperfine 'wasmtime run --allow-precompiled --dir ./ ./tokenize-main.cwasm'
hyperfine 'zig build-exe -fstrip tokenize-main.zig -target wasm32-wasi -mcpu=mvp -ODebug -fno-llvm -fno-lld -fno-libllvm'
hyperfine 'wasmtime compile tokenize-main.wasm'
hyperfine 'wasmtime run --allow-precompiled --dir ./ ./tokenize-main.cwasm'

echo "wasm + deno"
hyperfine 'zig build-exe -fstrip tokenize.zig -target wasm32-freestanding -mcpu=mvp+bulk_memory -rdynamic -OReleaseSafe'
hyperfine 'deno run --allow-read tokenize.js'
hyperfine 'zig build-exe -fstrip tokenize.zig -target wasm32-freestanding -mcpu=mvp+bulk_memory -rdynamic -ODebug'
hyperfine 'deno run --allow-read tokenize.js'
hyperfine 'zig build-exe -fstrip tokenize.zig -target wasm32-freestanding -mcpu=mvp+bulk_memory -rdynamic -ODebug -fno-llvm -fno-lld -fno-libllvm'
hyperfine 'deno run --allow-read tokenize.js'