# native-wasm-c

Compares performance of the single precision BLAS saxpy routine between WebAssembly, TypeScript, C (Node.js addon) and Vectorious (linked with system BLAS).

```bash
npm install
npm run build
npm test
```

Test output:

```
npx: installed 8 in 1.33s
ts x 1,623,240 ops/sec ±1.93% (89 runs sampled)
wasm x 175,992 ops/sec ±1.90% (91 runs sampled)
c x 2,885,002 ops/sec ±0.87% (94 runs sampled)
vectorious x 8,327,668 ops/sec ±0.80% (95 runs sampled)
```
