#import <Cocoa/Cocoa.h>
#include <napi.h>

static NSTextField *findTextField(NSView *view) {
  for (NSView *subview in view.subviews) {
    if ([subview isKindOfClass:[NSTextField class]]) {
      return (NSTextField *)subview;
    } else {
      NSTextField *result = findTextField(subview);
      if (result) {
        return result;
      }
    }
  }
  return nullptr;
}

// http://stackoverflow.com/a/29336473
static void setTitleColorImpl(NSWindow *window, double r, double g, double b,
                              double a) {
  auto titleField = findTextField([window contentView].superview);
  auto color = [NSColor colorWithSRGBRed:r green:g blue:b alpha:a];
  if (titleField) {
    auto attributedStr = [[NSAttributedString alloc]
        initWithString:titleField.stringValue
            attributes:@{NSForegroundColorAttributeName : color}];
    titleField.attributedStringValue = attributedStr;
  }
}

static NSWindow *windowFromBuffer(const Napi::Buffer<uint8_t> &buffer) {
  auto data = (NSView **)buffer.Data();
  auto view = data[0];
  return view.window;
}

Napi::Value setup(const Napi::CallbackInfo &info) {
  if (info.Length() < 1) {
    Napi::Error::New(info.Env(), "Wrong number of arguments")
        .ThrowAsJavaScriptException();
    return {};
  }

  Napi::Buffer<uint8_t> buffer = info[0].As<Napi::Buffer<uint8_t>>();
  if (buffer.Length() != 8) {
    Napi::Error::New(info.Env(), "Pointer buffer is invalid")
        .ThrowAsJavaScriptException();
    return {};
  }

  auto win = windowFromBuffer(buffer);
  win.titlebarAppearsTransparent = true;
  win.styleMask |= NSWindowStyleMaskFullSizeContentView;

  return {};
}

Napi::Value setTitleColor(const Napi::CallbackInfo &info) {
  if (info.Length() < 5) {
    Napi::Error::New(info.Env(), "Wrong number of arguments")
        .ThrowAsJavaScriptException();
    return {};
  }

  Napi::Buffer<uint8_t> buffer = info[0].As<Napi::Buffer<uint8_t>>();
  if (buffer.Length() != 8) {
    Napi::Error::New(info.Env(), "Pointer buffer is invalid")
        .ThrowAsJavaScriptException();
    return {};
  }
  auto win = windowFromBuffer(buffer);

  if (!info[1].IsNumber() || !info[2].IsNumber() || !info[3].IsNumber() ||
      !info[4].IsNumber()) {
    Napi::Error::New(info.Env(), "Color values must be number")
        .ThrowAsJavaScriptException();
    return {};
  }

  double r = info[1].As<Napi::Number>().DoubleValue();
  double g = info[2].As<Napi::Number>().DoubleValue();
  double b = info[3].As<Napi::Number>().DoubleValue();
  double a = info[4].As<Napi::Number>().DoubleValue();
  setTitleColorImpl(win, r, g, b, a);

  return {};
}
