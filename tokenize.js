const wasmCode = Deno.readFileSync(Deno.args[0] ?? "tokenize.wasm");
const wasmModule = new WebAssembly.Module(wasmCode);

let memory = undefined;

let instance;
try {
  instance = new WebAssembly.Instance(wasmModule, {
    env: {},
  });
} catch (error) {
  console.error(error);
}

try {
  const source = Deno.readFileSync("big.zig");
  const ptr = instance.exports.alloc(source.length);
  const bytes = new Uint8Array(instance.exports.memory.buffer);
  const count = instance.exports.tokenize(ptr, source.length);
  instance.exports.free(ptr, source.length);
  console.log(count, "tokens");
} catch (error) {
  console.error(error);
}
