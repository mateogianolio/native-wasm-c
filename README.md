# native-wasm-c

Compares performance of the single precision BLAS saxpy routine between WebAssembly (using [AssemblyScript](https://github.com/AssemblyScript/assemblyscript)), TypeScript, C (Node.js addon) and [nblas](https://github.com/mateogianolio/nblas).
[Here](https://github.com/Reference-LAPACK/lapack/blob/master/BLAS/SRC/saxpy.f) is the reference implementation for the saxpy routine.

Files:

* `src/saxpy.ts` – TypeScript implementation
* `c/saxpy.cc` – C implementation
* `wasm/saxpy.wasm` – WASM
* `wasm/saxpy_optimized.wasm` – Optimized WASM
* `assembly/index.ts` – Entry point for AssemblyScript compilation

```bash
npm install
npm run build
npm test
```

Test output:

```
ts x 1,603,140 ops/sec ±1.00% (89 runs sampled)
wasm x 178,353 ops/sec ±1.66% (92 runs sampled)
wasm optimized x 175,419 ops/sec ±1.31% (88 runs sampled)
c x 2,896,236 ops/sec ±0.58% (91 runs sampled)
blas x 9,255,467 ops/sec ±0.72% (91 runs sampled)
```
