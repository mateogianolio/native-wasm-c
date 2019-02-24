# native-wasm-c

Compares performance of the single precision BLAS saxpy routine between WebAssembly, TypeScript, C (Node.js addon) and Vectorious (linked with system BLAS).

Files:

* `assembly/saxpy.ts` – TypeScript implementation
* `c/saxpy.cc` – C implementation
* `wasm/saxpy.wasm` – WASM
* `wasm/saxpy_optimized.wasm` – Optimized WASM

```bash
npm install
npm run build
npm test
```

Test output:

```
ts x 1,644,903 ops/sec ±1.66% (91 runs sampled)
wasm x 186,889 ops/sec ±0.88% (94 runs sampled)
wasm optimized x 188,939 ops/sec ±0.54% (95 runs sampled)
c x 2,962,364 ops/sec ±0.23% (95 runs sampled)
vectorious x 8,411,726 ops/sec ±0.56% (95 runs sampled)
```
