export function saxpy(n: i32, alpha: f32, x: Float32Array, incx: i32, y: Float32Array, incy: i32): void {
  if (n < 0) {
    return;
  }

  if (alpha === 0) {
    return;
  }

  let i: i32;

  if (incx === 1 && incy === 1) {
    let m = n % 4;
    if (m !== 0) {
      for (i = 0; i < m; i++) {
        y[i] = y[i] + alpha * x[i];
      }
    }

    if (n < 4) {
      return;
    }

    for (i = m; i < n; i += 4) {
      y[i] += alpha * x[i];
      y[i + 1] += alpha * x[i + 1];
      y[i + 2] += alpha * x[i + 2];
      y[i + 3] += alpha * x[i + 3];
    }
  } else {
    let ix = 1;
    let iy = 1;

    if (incx < 0) {
      ix = (-n) * incx;
    }

    if (incy < 0) {
      iy = (-n) * incy;
    }

    for (i = 0; i < n; i++) {
      y[iy] = y[i] + alpha * x[ix];
      ix = ix + incx;
      iy = iy + incy;
    }
  }
}
