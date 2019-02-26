import { readFileSync } from 'fs';
import { deepEqual } from 'assert';
import { Suite } from 'benchmark';
import { saxpy, empty } from './src/saxpy';
import * as nblas from 'nblas';

// random Float32Array of size n with values in [-1, 1)
const random = (n: number) => new Float32Array(n)
  .fill(-1)
  .map(value => value + Math.random() * 2);

const c = require('./build/Release/addon');
const loader = require('assemblyscript/lib/loader');

const wasm = loader.instantiateBuffer(readFileSync('./wasm/saxpy.wasm'));
const wasm_optimized = loader.instantiateBuffer(readFileSync('./wasm/saxpy_optimized.wasm'));

const n = 512 * 1024 * 30;
const x = random(n);
const y = random(n);
const px1 = wasm.newArray(x);
const px2 = wasm_optimized.newArray(x);
const py1 = wasm.newArray(y);
const py2 = wasm_optimized.newArray(y);

// assure all methods give equivalent result with same input
(function test() {
  const results = [];
  let result = y.slice();
  nblas.axpy(x, result, 1);
  results.push(result);

  result = y.slice();
  const presult = wasm.newArray(result);
  wasm.saxpy(n, 1, px1, 1, presult, 1);
  results.push(wasm.getArray(Float32Array, presult));
  wasm.freeArray(presult);

  result = y.slice();
  c.saxpy(n, 1, x, 1, result, 1);
  results.push(result);

  result = y.slice();
  saxpy(n, 1, x, 1, result, 1);
  results.push(result);

  results.reduce((current, next) => {
    deepEqual(current, next);
    return next;
  });
})();

new Suite()
  .add('ts:empty', () => {
    empty(n, 1, x, 1, y, 1);
  })
  .add('ts', () => {
    saxpy(n, 1, x, 1, y, 1);
  })
  .add('wasm:empty', () => {
    wasm.empty(n, 1, px1, 1, py1, 1);
  })
  .add('wasm', () => {
    wasm.saxpy(n, 1, px1, 1, py1, 1);
  })
  .add('wasm optimized:empty', () => {
    wasm_optimized.empty(n, 1, px2, 1, py2, 1);
  })
  .add('wasm optimized', () => {
    wasm_optimized.saxpy(n, 1, px2, 1, py2, 1);
  })
  .add('c:empty', () => {
    c.empty(n, 1, x, 1, y, 1);
  })
  .add('c', () => {
    c.saxpy(n, 1, x, 1, y, 1);
  })
  .add('blas', () => {
    nblas.axpy(x, y, 1);
  })
  .on('cycle', (event: { target: any }) => console.log(event.target.toString()))
  .on('complete', () => {
    wasm.freeArray(px1);
    wasm_optimized.freeArray(px2);
    wasm.freeArray(py1);
    wasm_optimized.freeArray(py2);
  })
  .run();
