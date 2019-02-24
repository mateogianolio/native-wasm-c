"use strict";
exports.__esModule = true;
function saxpy(n, alpha, x, incx, y, incy) {
    if (n < 0) {
        return;
    }
    if (alpha === 0) {
        return;
    }
    var i;
    if (incx === 1 && incy === 1) {
        var m = n % 4;
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
    }
    else {
        var ix = 1;
        var iy = 1;
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
exports.saxpy = saxpy;
