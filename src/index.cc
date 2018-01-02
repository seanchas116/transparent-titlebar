#include <nan.h>

void setTitleBarTransparent(const Nan::FunctionCallbackInfo<v8::Value>& info);
void setTitleColor(const Nan::FunctionCallbackInfo<v8::Value>& info);

static void InitModule(v8::Local<v8::Object> exports) {
  exports->Set(Nan::New("setTitleBarTransparent").ToLocalChecked(),
               Nan::New<v8::FunctionTemplate>(setTitleBarTransparent)->GetFunction());
  exports->Set(Nan::New("setTitleColor").ToLocalChecked(),
               Nan::New<v8::FunctionTemplate>(setTitleColor)->GetFunction());
}

NODE_MODULE(transparent_titlebar, InitModule)
