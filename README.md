# transparent-titlebar

Transparent title bar with native title label in Electron for Mac

![Example](images/example.gif)

|Using transparent-titlebar|titleBarStyle: hidden in Electron|Normal|
|-|-|-|
| ![Using transparent-titlebar](images/transparent.png) | ![titleBarStyle: hidden](images/titlebarstyle-hidden.png) | ![Normal](images/normal.png) |

## Install

```
npm install transparent-titlebar
```

TypeScript definitions are included.

## Use

```js
let win: BrowserWindow
const transparentTitlebar = require('transparent-titlebar')

// Setup window to use transparent titlebar
transparentTitlebar.setup(win.getNativeWindowHandle())

// Set title color (must be called on page load and whenever the title has changed)
transparentTitlebar.setColor(win.getNativeWindowHandle(), 1, 0, 0, 1)
```

## Run Example

```
cd examples
npm install
npm start
```