import { readFileSync } from 'fs';
import { Vector } from 'vectorious';
import { Suite } from 'benchmark';
import { saxpy } from './assembly/saxpy';

const suite = new Suite();

const loader = require('assemblyscript/lib/loader');
const wasm = loader.instantiateBuffer(readFileSync('./index.wasm'));

const c = require('./build/Release/addon');

const size = 512 * 4;

const vx = Vector.random(size, -1, 1, Float32Array);
const vy = Vector.random(size, -1, 1, Float32Array);

const x = Vector.random(size, -1, 1, Float32Array).data as Float32Array;
const y = Vector.random(size, -1, 1, Float32Array).data as Float32Array;

const px = wasm.newArray(x);
const py = wasm.newArray(y);

suite.add('ts', () => {
  saxpy(size, 1, x, 1, y, 1);
});

suite.add('wasm', () => {
  wasm.saxpy(size, 1, px, 1, py, 1);
});

suite.add('c', () => {
  c.saxpy(size, 1, x, 1, y, 1);
});

suite.add('vectorious', () => {
  vx.add(vy);
})

suite.on('cycle', (event: { target: any }) => console.log(event.target.toString()));

suite.run();

suite.on('complete', () => {
  wasm.freeArray(px);
  wasm.freeArray(py);
});
