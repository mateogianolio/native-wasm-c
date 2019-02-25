export function saxpy(n: i32, alpha: f32, x: Float32Array, incx: i32, y: Float32Array, incy: i32): void {
  if (!alpha || n < 0) return;

  let i: i32;

  if (incx === 1 && incy === 1) {
    let m = n % 4;
    if (m) {
      for (i = 0; i < m; i++) {
        unchecked(y[i] = unchecked(y[i]) + alpha * unchecked(x[i]));
      }
    }

    if (n < 4) {
      return;
    }

    for (i = m; i < n; i += 4) {
      y[i + 0] = unchecked(y[i + 0]) + alpha * unchecked(x[i + 0]);
      y[i + 1] = unchecked(y[i + 1]) + alpha * unchecked(x[i + 1]);
      y[i + 2] = unchecked(y[i + 2]) + alpha * unchecked(x[i + 2]);
      y[i + 3] = unchecked(y[i + 3]) + alpha * unchecked(x[i + 3]);
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
      unchecked(y[iy] = unchecked(y[i]) + alpha * unchecked(x[ix]));
      ix += incx;
      iy += incy;
    }
  }
}
