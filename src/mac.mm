#include <nan.h>
#import <Cocoa/Cocoa.h>

static NSTextField *findTextField(NSView *view) {
  for (NSView *subview in view.subviews) {
    if ([subview isKindOfClass:[NSTextField class]]) {
      return (NSTextField *)subview;
    } else {
      NSTextField* result = findTextField(subview);
      if (result) {
        return result;
      }
    }
  }
  return nullptr;
}

// http://stackoverflow.com/a/29336473
static void setTitleColorImpl(NSWindow *window, double r, double g, double b, double a) {
  auto titleField = findTextField([window contentView].superview);
  auto color = [NSColor colorWithSRGBRed:r green:g blue:b alpha:a];
  if (titleField) {
    auto attributedStr = [[NSAttributedString alloc] initWithString:titleField.stringValue attributes:@{
      NSForegroundColorAttributeName: color
    }];
    titleField.attributedStringValue = attributedStr;
  }
}

static NSWindow *windowFromBuffer(const v8::Local<v8::Value>& buffer) {
  auto data = (NSView **)node::Buffer::Data(buffer);
  auto view = data[0];
  return view.window;
}

void setTitleBarTransparent(const Nan::FunctionCallbackInfo<v8::Value>& info) {
  if (info.Length() < 1) {
    Nan::ThrowTypeError("Wrong number of arguments");
    return;
  }
  if (!node::Buffer::HasInstance(info[0]) || node::Buffer::Length(info[0]) < 4) {
    Nan::ThrowTypeError("Pointer buffer is invalid");
    return;
  }
  auto win = windowFromBuffer(info[0]);
  win.titlebarAppearsTransparent = true;
  win.styleMask |= NSFullSizeContentViewWindowMask;
}

void setTitleColor(const Nan::FunctionCallbackInfo<v8::Value>& info) {
  if (info.Length() < 5) {
    Nan::ThrowTypeError("Wrong number of arguments");
    return;
  }
  if (!node::Buffer::HasInstance(info[0]) || node::Buffer::Length(info[0]) < 4) {
    Nan::ThrowTypeError("Pointer buffer is invalid");
    return;
  }
  if (!info[1]->IsNumber() || !info[2]->IsNumber() || !info[3]->IsNumber() || !info[4]->IsNumber()) {
    Nan::ThrowTypeError("Color values must be number");
  }
  auto win = windowFromBuffer(info[0]);
  double r = info[1]->NumberValue();
  double g = info[2]->NumberValue();
  double b = info[3]->NumberValue();
  double a = info[4]->NumberValue();
  setTitleColorImpl(win, r, g, b, a);
}
