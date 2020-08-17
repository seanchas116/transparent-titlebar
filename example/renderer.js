const path = require("path");
const Color = require("color");
const { remote } = require("electron");
const transparentTitlebar = remote.require("transparent-titlebar");

const setTitleButton = document.getElementById("setTitle");
const titleInput = document.getElementById("title");
const setRepresentedFilenameButton = document.getElementById(
  "setRepresentedFilename"
);
const colorInput = document.getElementById("color");

let color = [0, 0, 0, 1];

setTitleButton.addEventListener("click", () => {
  const title = titleInput.value;
  if (title) {
    remote.getCurrentWindow().setRepresentedFilename("");
    remote.getCurrentWindow().setTitle(title);
    transparentTitlebar.setTitleColor(
      remote.getCurrentWindow().getNativeWindowHandle(),
      ...color
    );
  }
});

setRepresentedFilenameButton.addEventListener("click", () => {
  remote.getCurrentWindow().setRepresentedFilename(__filename);
  remote.getCurrentWindow().setTitle(path.basename(__filename));
  transparentTitlebar.setTitleColor(
    remote.getCurrentWindow().getNativeWindowHandle(),
    ...color
  );
});

colorInput.addEventListener("change", () => {
  const [r, g, b] = Color(colorInput.value).rgb().array();
  color = [r / 255, g / 255, b / 255, 1];
  transparentTitlebar.setTitleColor(
    remote.getCurrentWindow().getNativeWindowHandle(),
    ...color
  );
});
