
export function empty(n: i32, alpha: f32, x: Float32Array, incx: i32, y: Float32Array, incy: i32): void {
}

export function saxpy(n: i32, alpha: f32, x: Float32Array, incx: i32, y: Float32Array, incy: i32): void {
  if (!alpha || n < 0) return;

  let i: i32;

  if (incx === 1 && incy === 1) {
    let m = n % 4;
    if (m) {
      for (i = 0; i < m; i++) {
        y.__unchecked_set(i, y.__unchecked_get(i) + alpha * x.__unchecked_get(i));
      }
    }

    if (n < 4) {
      return;
    }

    for (i = m; i < n; i += 4) {
      y.__unchecked_set(i + 0, y.__unchecked_get(i + 0) + alpha * x.__unchecked_get(i + 0));
      y.__unchecked_set(i + 1, y.__unchecked_get(i + 1) + alpha * x.__unchecked_get(i + 1));
      y.__unchecked_set(i + 2, y.__unchecked_get(i + 2) + alpha * x.__unchecked_get(i + 2));
      y.__unchecked_set(i + 3, y.__unchecked_get(i + 3) + alpha * x.__unchecked_get(i + 3));
    }
  } else {
    let ix = 1;
    let iy = 1;

    if (incx < 0) {
      ix = (1 - n) * incx;
    }

    if (incy < 0) {
      iy = (1 - n) * incy;
    }

    for (i = 0; i < n; i++) {
      y.__unchecked_set(iy, y.__unchecked_get(i) + alpha * x.__unchecked_get(ix));
      ix += incx;
      iy += incy;
    }
  }
}
