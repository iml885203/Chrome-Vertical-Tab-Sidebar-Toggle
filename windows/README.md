# Windows (AutoHotkey v2)

> **Quick install is in the [main README → Installation → Windows](../README.md#installation).**
> This page is the full reference: shortcut customization, auto-start, locales, and troubleshooting.

A Windows port of Chrome-Vertical-Tab-Sidebar-Toggle. The macOS version uses
Hammerspoon + the Accessibility API; this version uses **AutoHotkey v2 + the
Windows UI Automation (UIA) API** to do the exact same thing: find Chrome's
**Collapse tabs / Expand tabs** button in the accessibility tree and trigger it
with `Invoke()` (the UIA equivalent of macOS `AXPress`).

This is a keyboard-only port — press **`Ctrl+S`** in Chrome to toggle the
sidebar (mirrors `init-keyboard-only.lua` on macOS).

## Requirements

- Windows 10/11
- [AutoHotkey **v2**](https://www.autohotkey.com/) (not v1.1)
- [Descolada's UIA-v2 library](https://github.com/Descolada/UIA-v2) — `UIA.ahk`
  (not bundled here, download separately, see below)
- Google Chrome with the vertical tab sidebar enabled

## Enable the vertical tab sidebar in Chrome

Same as the macOS version:

1. Type `chrome://flags/#vertical-tabs` in the address bar
2. Set **Vertical tabs** to **Enabled**
3. Click **Relaunch**
4. Right-click an empty area in the tab bar → show tabs vertically

## Installation

1. Install **AutoHotkey v2** from https://www.autohotkey.com/

2. Download **`UIA.ahk`** from
   [Descolada/UIA-v2](https://github.com/Descolada/UIA-v2) (file is in `Lib/UIA.ahk`)
   and place it in this `windows/` folder, next to `ChromeVTabToggle.ahk`:

   ```
   windows/
   ├── ChromeVTabToggle.ahk
   └── UIA.ahk          ← you download this
   ```

   > `UIA.ahk` is a third-party library (~400 KB) and is intentionally **not**
   > committed to this repo. The script `#include`s it, so it must sit in the
   > same folder.

3. Double-click `ChromeVTabToggle.ahk` to run it. A tray notification confirms
   it started. (You'll see the AutoHotkey "H" icon in the system tray.)

4. (Optional) Make it start automatically on login — see
   [Auto-start on login](#auto-start-on-login) below.

## Auto-start on login

By default the script only runs while you have it open. To have it launch every
time you sign in to Windows, put a **shortcut** to it in your Startup folder.

The Startup folder is per-user and lives at:

```
C:\Users\<your-username>\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup
```

You don't need to type that path — there's a shortcut to it. Step by step:

1. **Open the Startup folder.** Press `Win+R`, type `shell:startup`, press Enter.
   File Explorer opens that exact folder.

2. **Create a shortcut to the script.** In a *second* Explorer window, go to
   where `ChromeVTabToggle.ahk` lives. Then either:
   - **Right-drag** `ChromeVTabToggle.ahk` into the Startup folder and release →
     choose **"Create shortcuts here"**, or
   - **Right-click** `ChromeVTabToggle.ahk` → **Show more options** →
     **Send to** → **Desktop (create shortcut)**, then move that shortcut from
     your Desktop into the Startup folder.

   > Use a **shortcut**, not the file itself, so the script can stay in your
   > repo/project folder and still launch from Startup.

3. **Test it.** Double-click the shortcut once to confirm it runs (tray
   notification appears). Then sign out and back in (or restart) — the script
   should start on its own.

### Remove auto-start

Open the Startup folder again (`Win+R` → `shell:startup`) and delete the
`ChromeVTabToggle` shortcut. Deleting the shortcut does **not** delete the
script itself.

### Notes

- This only affects **your** user account. To start it for all users, use
  `shell:common startup` instead (requires admin rights).
- You can also manage it later via **Task Manager → Startup apps**, where the
  entry will appear and can be disabled without deleting the shortcut.

## Usage

| Shortcut | Action |
|----------|--------|
| `Ctrl+S` (in Chrome) | Toggle the vertical tab sidebar |
| `Ctrl+S` (elsewhere) | Passes through as the normal Save shortcut |
| `Ctrl+Alt+Q` | Quit the script |

The script only intercepts `Ctrl+S` when the active window is a Chromium window
(window class `Chrome_WidgetWin_1`), so saving still works in every other app.

## Supported Chrome locales

The button matcher uses the same multi-locale label list as the macOS version
(English, Traditional/Simplified Chinese, Japanese, Korean, German, Spanish,
French, Portuguese-BR, Russian). To add another locale, append the button name
to the `SIDEBAR_LABELS` array near the top of `ChromeVTabToggle.ahk`.

## Customizing the shortcut

The default is `Ctrl+S`. To use a different key, edit the hotkey line in
`ChromeVTabToggle.ahk`:

```autohotkey
$^s:: {        ; ^ = Ctrl, ! = Alt, + = Shift, # = Win
```

For example `Ctrl+Alt+S` would be `$^!s::`. If you change away from `Ctrl+S`,
you can also drop the `{Blind}^s` pass-through branch since there's no longer a
native shortcut to preserve.

## How it works

1. A global `Ctrl+S` hotkey checks whether the active window is Chromium
   (`WinGetClass = "Chrome_WidgetWin_1"`). If not, it passes `Ctrl+S` through.
2. `UIA.ElementFromHandle()` gets the UIA root for the active window.
3. `FindSidebarButton()` walks the UIA tree (depth-limited) looking for a button
   whose name matches any label in `SIDEBAR_LABELS`.
4. `button.Invoke()` toggles the sidebar.

## Troubleshooting

- **`#Include file "UIA.ahk" cannot be opened`** — you haven't placed `UIA.ahk`
  in this folder yet (installation step 2).
- **`Ctrl+S` does nothing and no Save dialog appears** — the hotkey is being
  intercepted but the button wasn't found/triggered. Make sure the vertical tab
  sidebar is actually enabled and visible. Check that your Chrome locale's
  button name is in `SIDEBAR_LABELS`.
- **`Ctrl+S` opens the Save dialog instead** — the hotkey isn't registering;
  confirm AutoHotkey **v2** (not v1) is running and the script is active in the
  tray. Another app/extension (e.g. a password manager) may also be grabbing
  `Ctrl+S` first — try a different shortcut.

## Notes / differences from the macOS version

- Keyboard-only; no mouse-edge trigger (kept deliberately simple).
- Relies on UIA `Invoke()`; behavior may vary slightly across Chrome versions.
- The vertical tabs flag is experimental in Chrome and can't be toggled by the
  script (same limitation as the macOS version).
