<p align="center">
  <img src="assets/logo.png" alt="Chrome-Vertical-Tab-Sidebar-Toggle Logo" width="200">
</p>

<h1 align="center">Chrome-Vertical-Tab-Sidebar-Toggle</h1>

<p align="center">
  <strong>用键盘快捷键切换 Chrome 原生的垂直标签页侧边栏。</strong><br>
  macOS（Hammerspoon）和 Windows（AutoHotkey）—— 键盘快捷键、鼠标边缘触发，或两者兼用。
</p>

<p align="center">
  <a href="README.md">English</a> · <a href="README.zh-TW.md">繁體中文</a> · <a href="README_ja.md">日本語</a> · <a href="README_ko.md">한국어</a> · <a href="README_es.md">Español</a> · <a href="README_pt-BR.md">Português</a> · <a href="README_ru.md">Русский</a> · <a href="README_fr.md">Français</a> · <a href="README_de.md">Deutsch</a>
</p>

---

## 功能介绍

Chrome 有内置的垂直标签页侧边栏，但没有快捷键来切换它。这个项目就补上了这个快捷键。它会在操作系统的辅助功能树中找到 Chrome 的“展开标签页”/“收起标签页”按钮，并替你按下它 —— 在 macOS 上使用 Hammerspoon，在 Windows 上使用 AutoHotkey。思路与 [ChromeSidebarToggleRaycast](https://github.com/RotulPlastik/ChromeSidebarToggleRaycast) 相同。

## 演示

https://github.com/user-attachments/assets/bcf2a76a-8028-4b63-bc8a-f0b9e1178a25

## 选择你的平台

| 平台 | 工作方式 | 开始使用 |
|----------|--------------|-------------|
| **macOS** | Hammerspoon + 辅助功能 API。键盘、鼠标边缘，或两者兼有。 | [安装 → macOS](#installation) ↓ |
| **Windows** | AutoHotkey v2 + UI Automation。仅键盘（`Ctrl+S`）。 | [安装 → Windows](#installation) ↓ |

两个平台都在本页面有完整文档：参见下方的 [macOS 参考](#macos-reference) 和 [Windows 参考](#windows-reference)。

## 支持的 Chrome 语言环境

脚本通过匹配 Chrome 辅助功能树中的侧边栏按钮标签来工作。开箱即用支持以下语言环境：

| 语言 | 语言环境 | 展开标签页 | 收起标签页 |
|----------|--------|-------------|---------------|
| 英语 | `en` | Expand tabs | Collapse tabs |
| 繁体中文 | `zh-TW` / `zh-HK` | 展開分頁 | 收合分頁 |
| 简体中文 | `zh-CN` | 展开标签页 | 收起标签页 |
| 日语 | `ja` | タブを開く | タブを閉じる |
| 韩语 | `ko` | 탭 펼치기 | 탭 접기 |
| 德语 | `de` | Tabs maximieren | Tabs minimieren |
| 西班牙语 | `es` | Mostrar pestañas | Ocultar pestañas |
| 法语 | `fr` | Développer les onglets | Réduire les onglets |
| 葡萄牙语（巴西） | `pt-BR` | Mostrar guias | Ocultar guias |
| 俄语 | `ru` | Развернуть вкладки | Свернуть вкладки |

如需添加其他语言，找到你所用 Chrome 语言环境下的按钮标签，将它追加到 `SIDEBAR_LABELS` 列表中 —— 在 `init.lua`（macOS）或 `windows/ChromeVTabToggle.ahk`（Windows）中。

## 在 Chrome 中开启垂直标签页侧边栏

垂直标签页侧边栏默认未开启，需要手动启用：

1. 在地址栏输入 `chrome://flags/#vertical-tabs`
2. 将 **Vertical tabs** 改为 **Enabled**
3. 点击 **Relaunch** 重启浏览器
4. 重启后，右键标签栏中的空白处即可看到选项

## 安装步骤

选择你的平台。两者功能相同，只是使用的工具不同。

<details open>
<summary><b>macOS</b> —— Hammerspoon（键盘 / 鼠标边缘 / 两者兼有）</summary>

**系统要求：** macOS 13+、[Hammerspoon](https://www.hammerspoon.org)、已启用垂直标签页侧边栏的 Chrome，以及为 Hammerspoon 授予的辅助功能权限。

1. 安装 Hammerspoon：

   ```bash
   brew install --cask hammerspoon
   ```

2. 选择一个版本，复制到 Hammerspoon 配置目录：

   **方案版本**（三种模式，默认）：
   ```bash
   cp init.lua ~/.hammerspoon/init.lua
   ```

   **纯快捷键版本**：
   ```bash
   cp init-keyboard-only.lua ~/.hammerspoon/init.lua
   ```

   如果已有 `~/.hammerspoon/init.lua`，请将内容追加到末尾。

3. 授予辅助功能权限：
   - 系统设置 → 隐私与安全性 → 辅助功能
   - 添加并启用 Hammerspoon

4. 重载 Hammerspoon 配置（点击菜单栏图标 → 重载配置）

5. （可选）将 Hammerspoon 添加到登录项，开机自动启动：
   - 系统设置 → 通用 → 登录项
   - 添加 Hammerspoon

关于方案、触发方式和自定义快捷键，参见下方的 [macOS 配置项](#schemes-macos-initlua)。

</details>

<details open>
<summary><b>Windows</b> —— AutoHotkey v2（仅键盘，<code>Ctrl+S</code>）</summary>

**系统要求：** Windows 10/11、[AutoHotkey **v2**](https://www.autohotkey.com/)、[Descolada 的 `UIA.ahk`](https://github.com/Descolada/UIA-v2)（需单独下载），以及已启用垂直标签页侧边栏的 Chrome。

1. 从 <https://www.autohotkey.com/> 安装 **AutoHotkey v2**（不是 v1.1）。

2. 从 [Descolada/UIA-v2](https://github.com/Descolada/UIA-v2) 下载 **`UIA.ahk`**（`Lib/UIA.ahk`），将它放到 `windows/` 文件夹中，与 `ChromeVTabToggle.ahk` 并列：

   ```
   windows/
   ├── ChromeVTabToggle.ahk
   └── UIA.ahk          ← 由你下载（约 400 KB，第三方文件，不包含在本仓库中）
   ```

3. 双击 `windows/ChromeVTabToggle.ahk` 运行它。托盘通知会确认它已启动。

4. 在 Chrome 处于焦点时按 **`Ctrl+S`** 切换侧边栏。（在其他所有应用中，`Ctrl+S` 仍照常执行保存。）

5. （可选）开机自启动：按 `Win+R`，输入 `shell:startup`，将一个指向 `ChromeVTabToggle.ahk` 的**快捷方式**放入该文件夹。

关于自定义快捷键和故障排查，参见 [Windows 详细说明](windows/README.md)。

</details>

---

# macOS reference

以下各节适用于 **macOS（Hammerspoon）** 版本。[Windows 参考](#windows-reference)在更下方。

## Schemes (macOS, `init.lua`)

编辑 `init.lua` 顶部的 `SCHEME` 变量来选择模式：

| 方案 | 值 | 触发方式 |
|--------|-------|----------|
| 纯快捷键 | `1` | `Cmd+S` 切换侧边栏 |
| 纯鼠标边缘 | `2` | 悬停左边缘展开，移出超过 380px 收起 |
| 快捷键 + 鼠标 | `3` | 两种触发同时生效（默认） |

```lua
local SCHEME = 3  -- 1 = Keyboard, 2 = Mouse edge, 3 = Both
```

当 Chrome 不是前台应用时，所有触发自动禁用。

## Triggers (macOS)

| 触发 | 动作 | 方案 |
|---------|--------|--------|
| `Cmd+S` | 切换侧边栏 | 1 和 3 |
| 鼠标在左边缘（0-2px）悬停 0.15 秒 | 展开侧边栏 | 2 和 3 |
| 鼠标移出左边缘超过 380px | 收起侧边栏 | 2 和 3 |

## Debug (macOS)

| 快捷键 | 功能 |
|----------|--------|
| `Cmd+Alt+D` | 显示服务状态 |
| `Cmd+Alt+B` | 将 Chrome AX 树中所有按钮输出到控制台 |
| `Cmd+Alt+R` | 强制重启所有服务 |

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

`init.lua` 和 `init-keyboard-only.lua` 均支持自定义快捷键。默认快捷键为 `Cmd+S`，会覆盖 Chrome 原生的“保存网页”快捷键。如需修改，编辑 `createKeyTap` 函数内的按键判断：

```lua
-- Cmd+S -> toggle sidebar
if flags.cmd and not flags.ctrl and not flags.alt and not flags.shift
    and keyCode == keycodes.map["s"] then
```

### Modifier keys

修改 `flags.*` 条件来设置你想要的修饰键组合：

| 修饰键 | 标志 | 示例 |
|----------|------|---------|
| Cmd | `flags.cmd` | `flags.cmd and not flags.ctrl` |
| Ctrl | `flags.ctrl` | `flags.ctrl and not flags.cmd` |
| Alt/Option | `flags.alt` | `flags.alt` |
| Shift | `flags.shift` | `flags.shift` |

设为 `true` 表示需要该键，`not flags.xxx` 表示排除该键。

### Key code

将 `keycodes.map["s"]` 改为任意按键名称。常用示例：

```lua
keycodes.map["s"]       -- S
keycodes.map["b"]       -- B
keycodes.map["/"]       -- /
keycodes.map["return"]  -- Return/Enter
keycodes.map["space"]   -- Space
keycodes.map["f1"]      -- F1
```

完整按键名称列表：在 Hammerspoon 控制台中运行 `hs.keycodes.map`。

### Examples

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

修改后重载 Hammerspoon 配置即可生效。

## How it works (macOS)

1. 当 Chrome 处于前台时，`eventtap` 会拦截 `Cmd+S`（方案 1 和 3）
2. 鼠标位置轮询器（50Hz）检测左边缘悬停和离开（方案 2 和 3）
3. 两个触发器都调用 `toggleSidebar()`：
   - 通过 `hs.axuielement.applicationElement()` 获取 Chrome 的 `AXUIElement` 根元素
   - 在窗口中搜索 `AXDescription` 匹配 "Expand Tabs" 或 "Collapse Tabs" 的按钮
   - 调用 `performAction("AXPress")` 点击找到的按钮
4. Watchdog 机制检测鼠标轮询器是否异常并自动重启（方案 2 和 3）
5. 防误触缓冲时间防止应用切换时的误触发

---

# Windows reference


以下各节适用于 **Windows（AutoHotkey）** 版本。关于开机自启动和故障排查，参见 [Windows 说明](windows/README.md)。

## Usage (Windows)

| 快捷键 | 动作 |
|----------|--------|
| `Ctrl+S`（在 Chrome 中） | 切换垂直标签页侧边栏 |
| `Ctrl+S`（在其他位置） | 作为普通的保存快捷键透传 |
| `Ctrl+Alt+Q` | 退出脚本 |

仅当活动窗口是 Chromium 窗口（窗口类 `Chrome_WidgetWin_1`）时，脚本才拦截 `Ctrl+S`，因此在其他所有应用中保存功能照常可用。

## Customizing the shortcut (Windows)

默认快捷键是 `Ctrl+S`。如需使用其他按键，编辑 `windows/ChromeVTabToggle.ahk` 中的热键行：

```autohotkey
$^s:: {        ; ^ = Ctrl, ! = Alt, + = Shift, # = Win
```

例如，`Ctrl+Alt+S` 应写为 `$^!s::`。如果你改成了 `Ctrl+S` 以外的快捷键，由于不再需要保留原生快捷键，也可以删除 `{Blind}^s` 的透传分支。

## How it works (Windows)

1. 全局 `Ctrl+S` 热键会检查活动窗口是否为 Chromium（`WinGetClass = "Chrome_WidgetWin_1"`）。如果不是，就将 `Ctrl+S` 透传出去。
2. `UIA.ElementFromHandle()` 获取活动窗口的 UI Automation 根元素。
3. `FindSidebarButton()` 遍历 UIA 树，查找名称匹配 `SIDEBAR_LABELS` 中任意标签的按钮。
4. `button.Invoke()` 切换侧边栏 —— 相当于 macOS 的 `AXPress`。

## 文件说明

| 文件 | 说明 |
|------|------|
| `init.lua` | 三方案版本（快捷键 / 鼠标 / 两者兼有）—— macOS |
| `init-keyboard-only.lua` | 纯快捷键版本，无鼠标检测 —— macOS |
| `windows/ChromeVTabToggle.ahk` | Windows 移植版（AutoHotkey v2，仅键盘） |
| `windows/README.md` | Windows 完整参考（自定义、故障排查） |

## 致谢

- 原始方案：[ChromeSidebarToggleRaycast](https://github.com/RotulPlastik/ChromeSidebarToggleRaycast) by RotulPlastik
- 适配 Hammerspoon 并增加鼠标边缘触发

## 许可证

MIT
