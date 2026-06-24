<p align="center">
  <img src="assets/logo.png" alt="Chrome-Vertical-Tab-Sidebar-Toggle Logo" width="200">
</p>

<h1 align="center">Chrome-Vertical-Tab-Sidebar-Toggle</h1>

<p align="center">
  <strong>用鍵盤快速鍵切換 Chrome 原生的垂直分頁側邊欄。</strong><br>
  macOS（Hammerspoon）與 Windows（AutoHotkey）— 鍵盤快速鍵、滑鼠邊緣觸發，或兩者兼用。
</p>

<p align="center">
  <a href="README.md">English</a> · <a href="README.zh-CN.md">简体中文</a> · 繁體中文 · <a href="README_ja.md">日本語</a> · <a href="README_ko.md">한국어</a> · <a href="README_es.md">Español</a> · <a href="README_pt-BR.md">Português</a> · <a href="README_ru.md">Русский</a> · <a href="README_fr.md">Français</a> · <a href="README_de.md">Deutsch</a>
</p>

---

## 功能介紹

Chrome 有內建的垂直分頁側邊欄，但沒有快速鍵來切換它。這個專案補上了這個功能。它會在作業系統的輔助使用樹中找到 Chrome 的「Expand Tabs」/「Collapse Tabs」按鈕並替你按下它 — 在 macOS 上使用 Hammerspoon，在 Windows 上使用 AutoHotkey。原理與 [ChromeSidebarToggleRaycast](https://github.com/RotulPlastik/ChromeSidebarToggleRaycast) 相同。

## 演示

https://github.com/user-attachments/assets/bcf2a76a-8028-4b63-bc8a-f0b9e1178a25

## 選擇你的平台

| 平台 | 運作方式 | 開始使用 |
|------|----------|----------|
| **macOS** | Hammerspoon + 輔助使用 API。鍵盤、滑鼠邊緣，或兩者兼用。 | [安裝步驟 → macOS](#installation) ↓ |
| **Windows** | AutoHotkey v2 + UI Automation。僅鍵盤（`Ctrl+S`）。 | [安裝步驟 → Windows](#installation) ↓ |

兩個平台都在本頁有完整說明：請參閱下方的 [macOS 參考](#macos-reference) 與 [Windows 參考](#windows-reference)。

## 支援的 Chrome 語言環境

腳本透過比對 Chrome 輔助使用樹中的側邊欄按鈕標籤來運作。開箱即用支援以下語言環境：

| 語言 | 語言環境 | 展開分頁 | 收合分頁 |
|------|----------|---------|---------|
| 英語 | `en` | Expand tabs | Collapse tabs |
| 繁體中文 | `zh-TW` / `zh-HK` | 展開分頁 | 收合分頁 |
| 簡體中文 | `zh-CN` | 展开标签页 | 收起标签页 |
| 日語 | `ja` | タブを開く | タブを閉じる |
| 韓語 | `ko` | 탭 펼치기 | 탭 접기 |
| 德語 | `de` | Tabs maximieren | Tabs minimieren |
| 西班牙語 | `es` | Mostrar pestañas | Ocultar pestañas |
| 法語 | `fr` | Développer les onglets | Réduire les onglets |
| 葡萄牙語（巴西） | `pt-BR` | Mostrar guias | Ocultar guias |
| 俄語 | `ru` | Развернуть вкладки | Свернуть вкладки |

如需新增其他語言，找到你所用 Chrome 語言環境下的按鈕標籤，將它加入 `SIDEBAR_LABELS` 列表中 — 在 `init.lua`（macOS）或 `windows/ChromeVTabToggle.ahk`（Windows）裡。

## 在 Chrome 中開啟垂直分頁側邊欄

垂直分頁側邊欄預設未開啟，需要手動啟用：

1. 在網址列輸入 `chrome://flags/#vertical-tabs`
2. 將 **Vertical tabs** 改為 **Enabled**
3. 點擊 **Relaunch** 重新啟動 Chrome
4. 重新啟動後，右鍵分頁列的空白處即可看到選項

## Installation

選擇你的平台。兩者做的事情相同，只是使用的工具不同。

<details open>
<summary><b>macOS</b> — Hammerspoon（鍵盤 / 滑鼠邊緣 / 兩者兼用）</summary>

**系統要求：** macOS 13+、[Hammerspoon](https://www.hammerspoon.org)、已啟用垂直分頁側邊欄的 Chrome，以及授予 Hammerspoon 的輔助使用權限。

1. 安裝 Hammerspoon：

   ```bash
   brew install --cask hammerspoon
   ```

2. 選擇一個版本，複製到 Hammerspoon 設定目錄：

   **方案版本**（三種模式，預設）：
   ```bash
   cp init.lua ~/.hammerspoon/init.lua
   ```

   **純快速鍵版本**：
   ```bash
   cp init-keyboard-only.lua ~/.hammerspoon/init.lua
   ```

   如果已有 `~/.hammerspoon/init.lua`，請將內容附加到末尾。

3. 授予輔助使用權限：
   - 系統設定 → 隱私權與安全性 → 輔助使用
   - 新增並啟用 Hammerspoon

4. 重新載入 Hammerspoon 設定（點選選單列圖示 → 重新載入設定）

5. （選用）將 Hammerspoon 加入登入項目，開機自動啟動：
   - 系統設定 → 一般 → 登入項目
   - 新增 Hammerspoon

關於方案、觸發方式及自訂快速鍵，請見下方的 [macOS 設定項目](#schemes-macos-initlua)。

</details>

<details open>
<summary><b>Windows</b> — AutoHotkey v2（僅鍵盤，<code>Ctrl+S</code>）</summary>

**系統要求：** Windows 10/11、[AutoHotkey **v2**](https://www.autohotkey.com/)、[Descolada 的 `UIA.ahk`](https://github.com/Descolada/UIA-v2)（需另外下載），以及已啟用垂直分頁側邊欄的 Chrome。

1. 從 <https://www.autohotkey.com/> 安裝 **AutoHotkey v2**（不是 v1.1）。

2. 從 [Descolada/UIA-v2](https://github.com/Descolada/UIA-v2)（`Lib/UIA.ahk`）下載 **`UIA.ahk`**，放到 `windows/` 資料夾中，與 `ChromeVTabToggle.ahk` 並列：

   ```
   windows/
   ├── ChromeVTabToggle.ahk
   └── UIA.ahk          ← 由你下載（約 400 KB，第三方，不在本儲存庫中）
   ```

3. 雙擊 `windows/ChromeVTabToggle.ahk` 來執行它。系統匣會跳出通知確認已啟動。

4. 在 Chrome 取得焦點時按下 **`Ctrl+S`** 即可切換側邊欄。（`Ctrl+S` 在其他所有應用程式中仍照常執行儲存功能。）

5. （選用）開機自動啟動：按下 `Win+R`，輸入 `shell:startup`，將 `ChromeVTabToggle.ahk` 的**捷徑**放入該資料夾。

關於快速鍵自訂與疑難排解，請見 [Windows 詳細說明](windows/README.md)。

</details>

---

# macOS reference

以下章節適用於 **macOS（Hammerspoon）** 版本。[Windows 參考](#windows-reference) 在再下方。

## Schemes (macOS, `init.lua`)

編輯 `init.lua` 頂部的 `SCHEME` 變數來選擇模式：

| 方案 | 值 | 觸發方式 |
|------|-----|----------|
| 純快速鍵 | `1` | `Cmd+S` 切換側邊欄 |
| 純滑鼠邊緣 | `2` | 懸停左邊緣展開，移出超過 380px 收合 |
| 快速鍵 + 滑鼠 | `3` | 兩種觸發同時生效（預設） |

```lua
local SCHEME = 3  -- 1 = Keyboard, 2 = Mouse edge, 3 = Both
```

當 Chrome 不是前景應用程式時，所有觸發自動停用。

## Triggers (macOS)

| 觸發 | 動作 | 方案 |
|------|------|------|
| `Cmd+S` | 切換側邊欄 | 1 和 3 |
| 滑鼠在左邊緣（0-2px）懸停 0.15 秒 | 展開側邊欄 | 2 和 3 |
| 滑鼠移出左邊緣超過 380px | 收合側邊欄 | 2 和 3 |

## Debug (macOS)

| 快速鍵 | 功能 |
|--------|------|
| `Cmd+Alt+D` | 顯示服務狀態 |
| `Cmd+Alt+B` | 將 Chrome AX 樹中所有按鈕輸出到主控台 |
| `Cmd+Alt+R` | 強制重新啟動所有服務 |

## Configuration (macOS)

### Scheme selector (`init.lua`)

```lua
local SCHEME = 3  -- 1 = Keyboard, 2 = Mouse edge, 3 = Both
```

### Mouse edge thresholds (`init.lua`, schemes 2 & 3)

```lua
local EDGE_THRESHOLD    = 2       -- px from left edge to trigger hover
local EXIT_THRESHOLD    = 380     -- px from left edge to trigger collapse
local WAIT_TIME         = 0.15    -- seconds to hover before triggering
local MOUSE_POLL_INTERVAL = 0.05  -- seconds between mouse position checks
```

### Both versions

```lua
local DEBUG = true  -- print debug messages to Console
```

## Customizing the keyboard shortcut (macOS)

`init.lua` 和 `init-keyboard-only.lua` 均支援自訂快速鍵。預設快速鍵為 `Cmd+S`，會覆蓋 Chrome 原生的「儲存網頁」快速鍵。如需修改，編輯 `createKeyTap` 函式內的按鍵判斷：

```lua
-- Cmd+S -> toggle sidebar
if flags.cmd and not flags.ctrl and not flags.alt and not flags.shift
    and keyCode == keycodes.map["s"] then
```

### 修飾鍵

修改 `flags.*` 條件來設定你想要的修飾鍵組合：

| 修飾鍵 | 標誌 | 範例 |
|--------|------|------|
| Cmd | `flags.cmd` | `flags.cmd and not flags.ctrl` |
| Ctrl | `flags.ctrl` | `flags.ctrl and not flags.cmd` |
| Alt/Option | `flags.alt` | `flags.alt` |
| Shift | `flags.shift` | `flags.shift` |

設為 `true` 表示需要該鍵，`not flags.xxx` 表示排除該鍵。

### 按鍵代碼

將 `keycodes.map["s"]` 改為任意按鍵名稱。常用範例：

```lua
keycodes.map["s"]       -- S
keycodes.map["b"]       -- B
keycodes.map["/"]       -- /
keycodes.map["return"]  -- Return/Enter
keycodes.map["space"]   -- Space
keycodes.map["f1"]      -- F1
```

完整按鍵名稱列表：在 Hammerspoon 主控台中執行 `hs.keycodes.map`。

### 範例

**`Ctrl+Shift+B`**：
```lua
if flags.ctrl and not flags.cmd and flags.shift and not flags.alt
    and keyCode == keycodes.map["b"] then
```

**`Cmd+Alt+/`**：
```lua
if flags.cmd and not flags.ctrl and flags.alt and not flags.shift
    and keyCode == keycodes.map["/"] then
```

**`Cmd+Shift+Return`**：
```lua
if flags.cmd and not flags.ctrl and not flags.alt and flags.shift
    and keyCode == keycodes.map["return"] then
```

修改後重新載入 Hammerspoon 設定即可生效。

## How it works (macOS)

1. 當 Chrome 處於前景運作時，`eventtap` 會攔截 `Cmd+S`（方案 1 和 3）
2. 滑鼠位置輪詢器（50Hz）偵測左邊緣懸停和離開（方案 2 和 3）
3. 兩個觸發器都呼叫 `toggleSidebar()`：
   - 透過 `hs.axuielement.applicationElement()` 取得 Chrome 的 `AXUIElement` 根元素
   - 在視窗中搜尋 `AXDescription` 符合「Expand Tabs」或「Collapse Tabs」的按鈕
   - 呼叫 `performAction("AXPress")` 點擊找到的按鈕
4. Watchdog 機制偵測滑鼠輪詢器是否異常並自動重新啟動（方案 2 和 3）
5. 防誤觸緩衝時間防止應用程式切換時的誤觸發

---

# Windows reference


以下章節適用於 **Windows（AutoHotkey）** 版本。關於開機自動啟動與疑難排解，請見 [Windows 說明](windows/README.md)。

## Usage (Windows)

| 快速鍵 | 動作 |
|--------|------|
| `Ctrl+S`（在 Chrome 中） | 切換垂直分頁側邊欄 |
| `Ctrl+S`（在其他地方） | 照常作為一般的儲存快速鍵 |
| `Ctrl+Alt+Q` | 結束腳本 |

腳本只在使用中的視窗為 Chromium 視窗（視窗類別 `Chrome_WidgetWin_1`）時攔截 `Ctrl+S`，因此在其他所有應用程式中儲存功能仍正常運作。

## Customizing the shortcut (Windows)

預設為 `Ctrl+S`。如要使用不同的按鍵，編輯 `windows/ChromeVTabToggle.ahk` 中的熱鍵那一行：

```autohotkey
$^s:: {        ; ^ = Ctrl, ! = Alt, + = Shift, # = Win
```

例如 `Ctrl+Alt+S` 會是 `$^!s::`。如果你改成 `Ctrl+S` 以外的組合，也可以移除 `{Blind}^s` 的傳遞分支，因為已經沒有需要保留的原生快速鍵了。

## How it works (Windows)

1. 全域的 `Ctrl+S` 熱鍵會檢查使用中的視窗是否為 Chromium（`WinGetClass = "Chrome_WidgetWin_1"`）。如果不是，就將 `Ctrl+S` 傳遞出去。
2. `UIA.ElementFromHandle()` 取得使用中視窗的 UI Automation 根元素。
3. `FindSidebarButton()` 遍歷 UIA 樹，尋找名稱符合 `SIDEBAR_LABELS` 中任一標籤的按鈕。
4. `button.Invoke()` 切換側邊欄 — 相當於 macOS 的 `AXPress`。

## 檔案說明

| 檔案 | 說明 |
|------|------|
| `init.lua` | 三方案版本（鍵盤 / 滑鼠 / 兩者兼用）— macOS |
| `init-keyboard-only.lua` | 純快速鍵版本，無滑鼠偵測 — macOS |
| `windows/ChromeVTabToggle.ahk` | Windows 移植版（AutoHotkey v2，僅鍵盤） |
| `windows/README.md` | Windows 完整參考（自訂、疑難排解） |

## 致謝

- 原始方案：[ChromeSidebarToggleRaycast](https://github.com/RotulPlastik/ChromeSidebarToggleRaycast) by RotulPlastik
- 適配 Hammerspoon 並增加滑鼠邊緣觸發支援

## 授權條款

MIT
