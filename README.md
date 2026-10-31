# oneclick-ytdlp

Download videos with one click using [yt-dlp](https://github.com/yt-dlp/yt-dlp). A lightweight Chrome extension sends the current tab's URL to a Windows batch script through a custom `ytdlp://` protocol. Once the download finishes, File Explorer opens with the downloaded file selected.

## Features

- Download the video from the current tab with one click.
- Save downloads **in the same folder as `run-ytdlp.bat`**.
- Automatically open File Explorer with the downloaded file selected.
- No local server, PowerShell script, or Native Messaging host required.
- Uses a per-user Windows protocol registration (no administrator privileges normally required).

## Requirements

- Windows
- Google Chrome or another Chromium-based browser that supports unpacked extensions
- [yt-dlp](https://github.com/yt-dlp/yt-dlp) installed and available on your `PATH`
- [FFmpeg](https://ffmpeg.org/download.html) recommended for downloads that need audio/video merging

## Installation

1. Download or clone this repository and keep the three files together:

   ```text
   oneclick-ytdlp/
   ├── manifest.json
   ├── background.js
   └── run-ytdlp.bat
   ```

2. Double-click **`run-ytdlp.bat`** without arguments. This registers the `ytdlp://` protocol for your Windows user account.
3. Open `chrome://extensions` in Chrome.
4. Enable **Developer mode**.
5. Click **Load unpacked** and select the repository folder (the one containing `manifest.json`).
6. Optionally pin the extension to the browser toolbar.

## Usage

1. Open a video page supported by yt-dlp.
2. Click the extension icon.
3. If your browser asks whether to open the external application, allow it.
4. The video downloads to the folder containing **`run-ytdlp.bat`**. When the download completes, File Explorer opens with the file selected.

## How it works

```text
Browser tab
    │  click extension
    ▼
background.js
    │  opens ytdlp://<current-tab-URL>
    ▼
Windows protocol handler
    │  launches run-ytdlp.bat
    ▼
yt-dlp
    │  downloads to the BAT folder
    ▼
File Explorer
       selects the downloaded file
```

The batch script registers the handler under `HKEY_CURRENT_USER\Software\Classes\ytdlp`. Running it without arguments registers the protocol; when Windows invokes it with a URL, it starts yt-dlp and uses its `after_move` hook to open File Explorer.

## Notes

- **Keep the BAT at its registered location.** If you move or rename it, run it again without arguments to update the protocol registration.
- yt-dlp supports many sites, but downloads depend on the website and the video's availability.
- A playlist or page containing multiple videos may open multiple File Explorer windows.
- The `ytdlp://` protocol can be invoked by other applications or websites. Only approve external-app prompts from sources you trust.

## Project files

| File | Purpose |
| --- | --- |
| `manifest.json` | Chrome Manifest V3 extension configuration |
| `background.js` | Sends the current tab's URL to the custom protocol |
| `run-ytdlp.bat` | Registers the Windows protocol and runs yt-dlp |
