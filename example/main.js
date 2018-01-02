const {app, BrowserWindow, ipcMain} = require('electron');
const transparentTitlebar = require('../')

let win;

function createWindow() {
  win = new BrowserWindow({width: 800, height: 600});

  win.loadURL(`file://${__dirname}/index.html`);
  win.webContents.openDevTools();
  win.on('closed', () => {
    win = null;
  });
  transparentTitlebar.setup(win.getNativeWindowHandle())
}

app.on('ready', createWindow);

app.on('window-all-closed', () => {
  app.quit();
});
