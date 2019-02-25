# native-wasm-c

Compares performance of the single precision BLAS saxpy routine between WebAssembly (using [AssemblyScript](https://github.com/AssemblyScript/assemblyscript)), TypeScript, C (Node.js addon) and [nblas](https://github.com/mateogianolio/nblas).
[Here](https://github.com/Reference-LAPACK/lapack/blob/master/BLAS/SRC/saxpy.f) is the reference implementation for the saxpy routine.

Files:

* `src/saxpy.ts` – TypeScript implementation
* `c/saxpy.cc` – C implementation
* `assembly/saxpy.ts` – AssemblyScript implementation
* `assembly/index.ts` – Entry point for AssemblyScript compilation

```bash
npm install
npm run build
npm test
```

Test output:

```
ts:empty x 862,129,693 ops/sec ±0.68% (91 runs sampled)
ts x 36.17 ops/sec ±3.34% (48 runs sampled)
wasm:empty x 53,163,899 ops/sec ±0.83% (93 runs sampled)
wasm x 12.46 ops/sec ±2.25% (35 runs sampled)
wasm optimized:empty x 52,309,689 ops/sec ±1.73% (88 runs sampled)
wasm optimized x 13.48 ops/sec ±0.31% (37 runs sampled)
c:empty x 77,943,541 ops/sec ±0.52% (93 runs sampled)
c x 81.39 ops/sec ±0.40% (69 runs sampled)
blas x 92.60 ops/sec ±0.45% (78 runs sampled)
```
