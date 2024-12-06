# Custom Pause Menu for RedM

![RedM Logo](https://cdn2.steamgriddb.com/icon/eb06b9db06012a7a4179b8f3cb5384d3/32/256x256.png)

## Overview

This repository contains a custom pause menu for RedM, converted from the original FiveM release by **billzoygkos**. The pause menu offers an enhanced and visually appealing interface for RedM servers.

---

## Original Release

The original FiveM release can be found here: [Pause Menu Release](https://forum.cfx.re/t/release-pause-menu/4919651).

---

## Installation

Follow these simple steps to install the custom pause menu on your RedM server:

1. **Download** the repository files.
2. **Extract** the files using Winzip or Winrar
3. **Open** the folder named, **'Pause-Menu-main'**
4. **Drag and drop** the folder named, **'PauseMenu'** into your server's `resources` directory.
5. Add the following line to your `server.cfg` at the very **TOP** above all other ensures:
   ```plaintext
   ensure PauseMenu
6. Don't forget to change out the, **'yourdiscordlinkhere'** line in the **app.js** to reflect the discord invite link to your discord server for it to work.

## Custom Edits
Open the **index.html** to make any edits to images or to change the look of the Pausemenu.
It's using HTML5, CSS, & javascript.

## Updated Preview
![RedM Logo](https://files.catbox.moe/g5e0w7.png)

## Old Preview
![RedM Logo](https://files.catbox.moe/3anxop.png)
To get it back to looking like this without the discord icon-
Go to the **index.html**
re-add this:
**<button id="discordinv" class="options">DISCORD</button><br/>**
remove this from the bottom of the page: 
   **<button id="discordinv-icon" class="options" style="background: blue; color: white; font-size: 20px;">
                        <i class="fa-brands fa-discord"></i>
                    </button>**
## Credits
Original Author: billzoygkos
Converted for RedM: This repository.
