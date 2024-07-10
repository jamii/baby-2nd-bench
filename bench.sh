#!/usr/bin/env bash

set -eu

echo "x86_64"
hyperfine --warmup 1 'zig build-exe -target x86_64-linux tokenize-main.zig -OReleaseSafe'
hyperfine --warmup 1 './tokenize-main'
hyperfine --warmup 1 'zig build-exe -target x86_64-linux tokenize-main.zig -ODebug'
hyperfine --warmup 1 './tokenize-main'
hyperfine --warmup 1 'zig build-exe -target x86_64-linux tokenize-main.zig -ODebug -fno-llvm -fno-lld -fno-libllvm'
hyperfine --warmup 1 './tokenize-main'

echo "x86"
hyperfine --warmup 1 'zig build-exe -target x86-linux tokenize-main.zig -OReleaseSafe'
hyperfine --warmup 1 './tokenize-main'
hyperfine --warmup 1 'zig build-exe -target x86-linux tokenize-main.zig -ODebug'
hyperfine --warmup 1 './tokenize-main'
hyperfine --warmup 1 'zig build-exe -target x86-linux tokenize-main.zig -ODebug -fno-llvm -fno-lld -fno-libllvm'
hyperfine --warmup 1 './tokenize-main'

echo "wasi + wasmtime"
hyperfine --warmup 1 'zig build-exe tokenize-main.zig -target wasm32-wasi -mcpu=mvp+bulk_memory -OReleaseSafe'
hyperfine --warmup 1 'wasmtime compile tokenize-main.wasm'
hyperfine --warmup 1 'wasmtime run --allow-precompiled --dir ./ ./tokenize-main.cwasm'
hyperfine --warmup 1 'zig build-exe tokenize-main.zig -target wasm32-wasi -mcpu=mvp+bulk_memory -ODebug'
hyperfine --warmup 1 'wasmtime compile tokenize-main.wasm'
hyperfine --warmup 1 'wasmtime run --allow-precompiled --dir ./ ./tokenize-main.cwasm'
hyperfine --warmup 1 'zig build-exe tokenize-main.zig -target wasm32-wasi -mcpu=mvp+bulk_memory -ODebug -fno-llvm -fno-lld -fno-libllvm'
hyperfine --warmup 1 'wasmtime compile tokenize-main.wasm'
hyperfine --warmup 1 'wasmtime run --allow-precompiled --dir ./ ./tokenize-main.cwasm'
hyperfine --warmup 1 'zig build-exe tokenize-main.zig -target wasm32-wasi -mcpu=mvp -ODebug -fno-llvm -fno-lld -fno-libllvm'
hyperfine --warmup 1 'wasmtime compile tokenize-main.wasm'
hyperfine --warmup 1 'wasmtime run --allow-precompiled --dir ./ ./tokenize-main.cwasm'

echo "wasm + deno"
hyperfine --warmup 1 'zig build-exe tokenize.zig -target wasm32-freestanding -mcpu=mvp+bulk_memory -rdynamic -OReleaseSafe'
hyperfine --warmup 1 'deno run --allow-read tokenize.js'
hyperfine --warmup 1 'zig build-exe tokenize.zig -target wasm32-freestanding -mcpu=mvp+bulk_memory -rdynamic -ODebug'
hyperfine --warmup 1 'deno run --allow-read tokenize.js'
hyperfine --warmup 1 'zig build-exe tokenize.zig -target wasm32-freestanding -mcpu=mvp+bulk_memory -rdynamic -ODebug -fno-llvm -fno-lld -fno-libllvm'
hyperfine --warmup 1 'deno run --allow-read tokenize.js'