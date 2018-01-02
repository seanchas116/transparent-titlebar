const {app, BrowserWindow, ipcMain} = require('electron');
const transparentTitlebar = require('transparent-titlebar')

let win;

function createWindow() {
  win = new BrowserWindow({width: 400, height: 400});

  win.loadURL(`file://${__dirname}/index.html`);
  // win.webContents.openDevTools();
  win.on('closed', () => {
    win = null;
  });
  transparentTitlebar.setup(win.getNativeWindowHandle())
}

app.on('ready', createWindow);

app.on('window-all-closed', () => {
  app.quit();
});
