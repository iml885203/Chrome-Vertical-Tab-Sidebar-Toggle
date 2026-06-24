#Requires AutoHotkey v2.0
#SingleInstance Force
#include UIA.ahk            ; Descolada 的 UIAutomation for AHK v2 函式庫,放在同目錄
; ============================================================================
;  Chrome Vertical Tab Sidebar Toggle  (Windows / AutoHotkey v2)
;  Windows port of the macOS Hammerspoon project (keyboard-only, Ctrl+S).
;
;  精簡版:只用 Ctrl+S 切換 Chrome 垂直分頁側邊欄。
;  原理:透過 UI Automation 找到「收合分頁 / 展開分頁」按鈕,以 Invoke() 觸發。
; ============================================================================

; 對應原專案的多語系按鈕名稱(小寫,子字串比對)。Chrome 會在地化這顆按鈕。
global SIDEBAR_LABELS := [
    "expand tabs", "collapse tabs",                     ; English
    "展開分頁", "收合分頁",                              ; 正體中文
    "展开标签页", "收起标签页",                          ; 簡體中文
    "タブを開く", "タブを閉じる",                        ; 日文
    "탭 펼치기", "탭 접기",                              ; 韓文
    "tabs maximieren", "tabs minimieren",               ; 德文
    "mostrar pestañas", "ocultar pestañas",             ; 西班牙文
    "développer les onglets", "réduire les onglets",    ; 法文
    "mostrar guias", "ocultar guias",                   ; 葡萄牙文(巴西)
    "развернуть вкладки", "свернуть вкладки",            ; 俄文
]

TrayTip("Chrome VTab Toggle", "已啟動:在 Chrome 按 Ctrl+S 切換側邊欄", 1)

; ----------------------------- Ctrl+S 熱鍵 --------------------------------
; 全域註冊:在 Chromium 視窗時切換側邊欄;否則放行原本的 Ctrl+S(儲存)。
$^s:: {
    isChromium := false
    try isChromium := (WinGetClass("A") = "Chrome_WidgetWin_1")
    if !isChromium {
        Send("{Blind}^s")                  ; 不在 Chrome → 正常儲存
        return
    }
    if !ToggleSidebar()
        TrayTip("Chrome VTab Toggle", "找不到分頁側邊欄按鈕(確認已開啟垂直分頁)", 2)
}

; 結束腳本
^!q::ExitApp

; ----------------------------- 核心:切換按鈕 ------------------------------
ToggleSidebar() {
    hwnd := WinExist("A")
    if !hwnd
        return false
    try {
        root := UIA.ElementFromHandle(hwnd)
        btn := FindSidebarButton(root)
        if btn {
            btn.Invoke()                   ; ← 等同 macOS 的 AXPress
            return true
        }
    } catch as e {
        TrayTip("Chrome VTab Toggle", "切換失敗: " e.Message, 2)
    }
    return false
}

; 遞迴搜尋整棵 UIA tree 找側邊欄按鈕(對應原專案 findSidebarButton)。
FindSidebarButton(el, depth := 0) {
    global SIDEBAR_LABELS
    if (!el || depth > 30)
        return ""
    try {
        t := ""
        try t := el.Type
        if (t = 50000 || t = "Button") {   ; UIA_ButtonControlTypeId
            name := ""
            try name := StrLower(el.Name)
            for label in SIDEBAR_LABELS {
                if (name != "" && InStr(name, StrLower(label)))
                    return el
            }
        }
    }
    try {
        for child in el.GetChildren() {
            found := FindSidebarButton(child, depth + 1)
            if found
                return found
        }
    }
    return ""
}
