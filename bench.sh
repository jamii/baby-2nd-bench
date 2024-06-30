#!/usr/bin/env bash

set -ex

echo "native"
command time -f'%e' zig build-exe tokenize-main.zig -OReleaseSafe
command time -f'%e' ./tokenize-main
command time -f'%e' zig build-exe tokenize-main.zig -ODebug
command time -f'%e' ./tokenize-main
command time -f'%e' zig build-exe tokenize-main.zig -ODebug -fno-llvm -fno-lld -fno-libllvm
command time -f'%e' ./tokenize-main

echo "wasi + wasmtime"
command time -f'%e' zig build-exe tokenize-main.zig -target wasm32-wasi -mcpu=mvp+bulk_memory -OReleaseSafe
command time -f'%e' wasmtime compile tokenize-main.wasm
command time -f'%e' wasmtime run --allow-precompiled --dir ./ ./tokenize-main.cwasm
command time -f'%e' zig build-exe tokenize-main.zig -target wasm32-wasi -mcpu=mvp+bulk_memory -ODebug
command time -f'%e' wasmtime compile tokenize-main.wasm
command time -f'%e' wasmtime run --allow-precompiled --dir ./ ./tokenize-main.cwasm
command time -f'%e' zig build-exe tokenize-main.zig -target wasm32-wasi -mcpu=mvp+bulk_memory -ODebug -fno-llvm -fno-lld -fno-libllvm
command time -f'%e' wasmtime compile tokenize-main.wasm
command time -f'%e' wasmtime run --allow-precompiled --dir ./ ./tokenize-main.cwasm

echo "wasm + deno"
command time -f'%e' zig build-exe tokenize.zig -target wasm32-freestanding -mcpu=mvp+bulk_memory -rdynamic -OReleaseSafe
command time -f'%e' deno run --allow-read tokenize.js
command time -f'%e' zig build-exe tokenize.zig -target wasm32-freestanding -mcpu=mvp+bulk_memory -rdynamic -ODebug
command time -f'%e' deno run --allow-read tokenize.js
command time -f'%e' zig build-exe tokenize.zig -target wasm32-freestanding -mcpu=mvp+bulk_memory -rdynamic -ODebug -fno-llvm -fno-lld -fno-libllvm
command time -f'%e' deno run --allow-read tokenize.js