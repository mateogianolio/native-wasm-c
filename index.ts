import { readFileSync } from 'fs';
import { Vector } from 'vectorious';
import { Suite } from 'benchmark';
import { saxpy } from './src/saxpy';


const c = require('./build/Release/addon');
const loader = require('assemblyscript/lib/loader');

const wasm = loader.instantiateBuffer(readFileSync('./wasm/saxpy.wasm'));
const wasm_optimized = loader.instantiateBuffer(readFileSync('./wasm/saxpy_optimized.wasm'));

const vx = Vector.random(512, -1, 1, Float32Array);
const vy = Vector.random(512, -1, 1, Float32Array);

const x = Vector.random(512, -1, 1, Float32Array).data as Float32Array;
const y = Vector.random(512, -1, 1, Float32Array).data as Float32Array;

const px1 = wasm.newArray(x);
const px2 = wasm_optimized.newArray(x);
const py1 = wasm.newArray(y);
const py2 = wasm_optimized.newArray(y);

new Suite()
  .add('ts', () => {
    saxpy(512, 1, x, 1, y, 1);
  })
  .add('wasm', () => {
    wasm.saxpy(512, 1, px1, 1, py1, 1);
  })
  .add('wasm optimized', () => {
    wasm_optimized.saxpy(512, 1, px2, 1, py2, 1);
  })
  .add('c', () => {
    c.saxpy(512, 1, x, 1, y, 1);
  })
  .add('vectorious', () => {
    vx.add(vy);
  })
  .on('cycle', (event: { target: any }) => console.log(event.target.toString()))
  .on('complete', () => {
    wasm.freeArray(px1);
    wasm_optimized.freeArray(px2);
    wasm.freeArray(py1);
    wasm_optimized.freeArray(py2);
  })
  .run();
