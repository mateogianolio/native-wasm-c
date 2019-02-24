#include <node.h>

#define GET_CONTENTS(view) (static_cast<unsigned char*>(view->Buffer()->GetContents().Data()) + view->ByteOffset())

void saxpy(const v8::FunctionCallbackInfo<v8::Value>& info) {
  const int n = info[0]->Uint32Value();
  const int alpha = info[1]->NumberValue();
  float *x = reinterpret_cast<float*>(GET_CONTENTS(info[2].As<v8::Float32Array>()));
  const int incx = info[3]->Uint32Value();
  float *y = reinterpret_cast<float*>(GET_CONTENTS(info[4].As<v8::Float32Array>()));
  const int incy = info[5]->Uint32Value();

  int i;

  if (n < 0) {
    return;
  }

  if (alpha == 0) {
    return;
  }

  if (incx == 1 && incy == 1) {
    int m = n % 4;
    if (m != 0) {
      for (i = 0; i < m; i++) {
        y[i] = y[i] + alpha * x[i];
      }
    }

    if (n < 4) {
      return;
    }

    for (i = 0; i < n; i += 4) {
      y[i] = y[i] + alpha * x[i];
      y[i + 1] = y[i + 1] + alpha * x[i + 1];
      y[i + 2] = y[i + 2] + alpha * x[i + 2];
      y[i + 3] = y[i + 3] + alpha * x[i + 3];
    }
  } else {
    int ix = 1;
    int iy = 1;

    if (incx < 0) {
      ix = (1 - n) * incx;
    }

    if (incy < 0) {
      iy = (1 - n) * incy;
    }

    for (i = 0; i < n; i++) {
      y[iy] = y[i] + alpha * x[ix];
      ix = ix + incx;
      iy = iy + incy;
    }
  }
}

void Init(v8::Local<v8::Object> exports) {
  NODE_SET_METHOD(exports, "saxpy", saxpy);
}

NODE_MODULE(addon, Init)
