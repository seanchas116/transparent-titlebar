#include <napi.h>

Napi::Value setup(const Napi::CallbackInfo& info);
Napi::Value setTitleColor(const Napi::CallbackInfo& info);

Napi::Object Init(Napi::Env env, Napi::Object exports) {
  exports.Set(Napi::String::New(env, "setup"), Napi::Function::New(env, setup));
  exports.Set(Napi::String::New(env, "setTitleColor"), Napi::Function::New(env, setTitleColor));
  return exports;
}

NODE_API_MODULE(transparent_titlebar, Init)
