<p align="center">
  <img src="assets/logo.png" alt="Chrome-Vertical-Tab-Sidebar-Toggle Logo" width="200">
</p>

<h1 align="center">Chrome-Vertical-Tab-Sidebar-Toggle</h1>

<p align="center">
  <strong>Schalten Sie Chromes native vertikale Tab-Seitenleiste per Tastenkürzel um.</strong><br>
  macOS (Hammerspoon) und Windows (AutoHotkey) — Tastenkürzel, Triggerung durch den Bildschirmrand, oder beides.
</p>

<p align="center">
  <a href="README.md">English</a> · <a href="README.zh-CN.md">简体中文</a> · <a href="README.zh-TW.md">繁體中文</a> · <a href="README_ja.md">日本語</a> · <a href="README_ko.md">한국어</a> · <a href="README_es.md">Español</a> · <a href="README_pt-BR.md">Português</a> · <a href="README_ru.md">Русский</a> · <a href="README_fr.md">Français</a> · Deutsch
</p>

---

## Funktionsumfang

Chrome hat eine integrierte vertikale Tab-Seitenleiste, aber kein Tastenkürzel zum Umschalten. Dieses Projekt fügt eines hinzu. Es findet Chromes Schaltfläche "Expand Tabs" / "Collapse Tabs" im Accessibility-Baum des Betriebssystems und drückt sie für Sie — mit Hammerspoon unter macOS und mit AutoHotkey unter Windows. Gleicher Ansatz wie [ChromeSidebarToggleRaycast](https://github.com/RotulPlastik/ChromeSidebarToggleRaycast).

## Demo

https://github.com/user-attachments/assets/bcf2a76a-8028-4b63-bc8a-f0b9e1178a25

## Wählen Sie Ihre Plattform

| Plattform | Funktionsweise | Erste Schritte |
|-----------|----------------|----------------|
| **macOS** | Hammerspoon + Accessibility-API. Tastatur, Bildschirmrand oder beides. | [Installation → macOS](#installation) ↓ |
| **Windows** | AutoHotkey v2 + UI Automation. Nur Tastatur (`Ctrl+S`). | [Installation → Windows](#installation) ↓ |

Beide Plattformen sind auf dieser Seite vollständig dokumentiert: siehe die [macOS-Referenz](#macos-reference) und die [Windows-Referenz](#windows-reference) weiter unten.

## Unterstützte Chrome-Gebietsschemas

Das Skript gleicht die Beschriftungen der Seitenleisten-Schaltflächen in Chromes Accessibility-Baum ab. Es funktioniert sofort mit diesen Gebietsschemas:

| Sprache | Gebietsschema | Tabs maximieren | Tabs minimieren |
|---------|---------------|-----------------|-----------------|
| Englisch | `en` | Expand tabs | Collapse tabs |
| Traditionelles Chinesisch | `zh-TW` / `zh-HK` | 展開分頁 | 收合分頁 |
| Vereinfachtes Chinesisch | `zh-CN` | 展开标签页 | 收起标签页 |
| Japanisch | `ja` | タブを開く | タブを閉じる |
| Koreanisch | `ko` | 탭 펼치기 | 탭 접기 |
| Deutsch | `de` | Tabs maximieren | Tabs minimieren |
| Spanisch | `es` | Mostrar pestañas | Ocultar pestañas |
| Französisch | `fr` | Développer les onglets | Réduire les onglets |
| Portugiesisch (Brasilien) | `pt-BR` | Mostrar guias | Ocultar guias |
| Russisch | `ru` | Развернуть вкладки | Свернуть вкладки |

Um eine weitere Sprache hinzuzufügen, suchen Sie die Schaltflächenbeschriftung in Ihrem Chrome-Gebietsschema und fügen Sie sie der Liste `SIDEBAR_LABELS` hinzu — in `init.lua` (macOS) oder `windows/ChromeVTabToggle.ahk` (Windows).

## Vertikale Tab-Seitenleiste in Chrome aktivieren

Die vertikale Tab-Seitenleiste ist standardmäßig deaktiviert. Um sie zu aktivieren:

1. Geben Sie `chrome://flags/#vertical-tabs` in die Adressleiste ein
2. Ändern Sie **Vertical tabs** auf **Enabled**
3. Klicken Sie auf **Relaunch**, um Chrome neu zu starten
4. Klicken Sie nach dem Neustart mit der rechten Maustaste auf einen leeren Bereich der Tableiste, um die Option zu sehen

## Installation

Wählen Sie Ihre Plattform. Beide tun dasselbe; nur das Werkzeug unterscheidet sich.

<details open>
<summary><b>macOS</b> — Hammerspoon (Tastatur / Bildschirmrand / beides)</summary>

**Anforderungen:** macOS 13+, [Hammerspoon](https://www.hammerspoon.org), Chrome mit aktivierter vertikaler Tab-Seitenleiste und die Berechtigung für Bedienungshilfen für Hammerspoon.

1. Installieren Sie Hammerspoon:

   ```bash
   brew install --cask hammerspoon
   ```

2. Wählen Sie eine Version und kopieren Sie sie in die Hammerspoon-Konfiguration:

   **Schema-Version** (drei Modi, Standard):
   ```bash
   cp init.lua ~/.hammerspoon/init.lua
   ```

   **Nur-Tastatur-Version**:
   ```bash
   cp init-keyboard-only.lua ~/.hammerspoon/init.lua
   ```

   Falls bereits eine `~/.hammerspoon/init.lua` existiert, fügen Sie den Inhalt am Ende hinzu.

3. Erteilen Sie die Berechtigung für Bedienungshilfen:
   - Systemeinstellungen → Datenschutz & Sicherheit → Bedienungshilfen
   - Fügen Sie Hammerspoon hinzu und aktivieren Sie es

4. Laden Sie die Hammerspoon-Konfiguration neu (Klicken Sie auf das Menüleisten-Symbol → Konfiguration neu laden)

5. (Optional) Fügen Sie Hammerspoon zu den Anmeldeobjekten hinzu, damit es automatisch startet:
   - Systemeinstellungen → Allgemein → Anmeldeobjekte
   - Fügen Sie Hammerspoon hinzu

Siehe [macOS-Konfiguration](#schemes-macos-initlua) weiter unten für Schemata, Auslöser und das Anpassen des Tastenkürzels.

</details>

<details open>
<summary><b>Windows</b> — AutoHotkey v2 (nur Tastatur, <code>Ctrl+S</code>)</summary>

**Anforderungen:** Windows 10/11, [AutoHotkey **v2**](https://www.autohotkey.com/), [Descoladas `UIA.ahk`](https://github.com/Descolada/UIA-v2) (separat herunterzuladen) und Chrome mit aktivierter vertikaler Tab-Seitenleiste.

1. Installieren Sie **AutoHotkey v2** von <https://www.autohotkey.com/> (nicht v1.1).

2. Laden Sie **`UIA.ahk`** von [Descolada/UIA-v2](https://github.com/Descolada/UIA-v2) (`Lib/UIA.ahk`) herunter und legen Sie es im Ordner `windows/` ab, neben `ChromeVTabToggle.ahk`:

   ```
   windows/
   ├── ChromeVTabToggle.ahk
   └── UIA.ahk          ← dies laden Sie herunter (~400 KB, Drittanbieter, nicht in diesem Repo)
   ```

3. Doppelklicken Sie auf `windows/ChromeVTabToggle.ahk`, um es auszuführen. Eine Benachrichtigung im Infobereich bestätigt den Start.

4. Drücken Sie **`Ctrl+S`**, während Chrome im Fokus ist, um die Seitenleiste umzuschalten. (`Ctrl+S` speichert in jeder anderen App weiterhin wie gewohnt.)

5. (Optional) Automatischer Start bei der Anmeldung: Drücken Sie `Win+R`, geben Sie `shell:startup` ein und legen Sie eine **Verknüpfung** zu `ChromeVTabToggle.ahk` in diesen Ordner.

Für die Anpassung des Tastenkürzels und zur Fehlerbehebung siehe die [detaillierten Windows-Hinweise](windows/README.md).

</details>

---

# macOS reference

Die folgenden Abschnitte gelten für die **macOS-Version (Hammerspoon)**. Die [Windows-Referenz](#windows-reference) folgt weiter unten.

## Schemes (macOS, `init.lua`)

Bearbeiten Sie die Variable `SCHEME` am Anfang von `init.lua`, um einen Modus zu wählen:

| Schema | Wert | Auslöser |
|--------|------|----------|
| Nur Tastatur | `1` | `Cmd+S` schaltet die Seitenleiste um |
| Nur Bildschirmrand | `2` | Maus an den linken Bildschirmrand bewegen zum Erweitern, über 380px hinaus bewegen zum Reduzieren |
| Tastatur + Maus | `3` | Beide Auslöser aktiv (Standard) |

```lua
local SCHEME = 3  -- 1 = Tastatur, 2 = Bildschirmrand, 3 = Beides
```

Wenn Chrome nicht die Vordergrund-App ist, werden alle Auslöser automatisch deaktiviert.

## Auslöser (macOS)

| Auslöser | Aktion | Schema |
|----------|--------|--------|
| `Cmd+S` | Seitenleiste umschalten | 1 & 3 |
| Maus am linken Rand (0-2px) für 0,15 s | Seitenleiste erweitern | 2 & 3 |
| Maus bewegt sich über 380px vom linken Rand | Seitenleiste reduzieren | 2 & 3 |

## Debug (macOS)

| Tastenkürzel | Aktion |
|--------------|--------|
| `Cmd+Alt+D` | Service-Status anzeigen |
| `Cmd+Alt+B` | Alle Chrome-AX-Schaltflächen in die Konsole ausgeben |
| `Cmd+Alt+R` | Alle Services erzwungen neu starten |

## Konfiguration (macOS)

### Schema-Selektor (`init.lua`)

```lua
local SCHEME = 3  -- 1 = Tastatur, 2 = Bildschirmrand, 3 = Beides
```

### Bildschirmrand-Schwellenwerte (`init.lua`, Schemata 2 & 3)

```lua
local EDGE_THRESHOLD    = 2       -- Pixel vom linken Rand zum Auslösen
local EXIT_THRESHOLD    = 380     -- Pixel vom linken Rand zum Reduzieren
local WAIT_TIME         = 0.15    -- Wartezeit in Sekunden vor dem Auslösen (0,15 s)
local MOUSE_POLL_INTERVAL = 0.05  -- Sekunden zwischen Mauspositionsprüfungen
```

### Beide Versionen

```lua
local DEBUG = true  -- Debug-Meldungen in die Konsole ausgeben
```

## Tastenkürzel anpassen (macOS)

Verfügbar in `init.lua` und `init-keyboard-only.lua`. Das Standard-Tastenkürzel ist `Cmd+S`, das Chromes natives Tastenkürzel zum „Seite speichern" überschreibt. Um es zu ändern, bearbeiten Sie die Tastenprüfung in der Funktion `createKeyTap`:

```lua
-- Cmd+S -> toggle sidebar
if flags.cmd and not flags.ctrl and not flags.alt and not flags.shift
    and keyCode == keycodes.map["s"] then
```

### Modifikatortasten

Ändern Sie die `flags.*`-Bedingungen, um Ihre gewünschte Modifikatorkombination festzulegen:

| Modifikator | Flag | Beispiel |
|-------------|------|----------|
| Cmd | `flags.cmd` | `flags.cmd and not flags.ctrl` |
| Ctrl | `flags.ctrl` | `flags.ctrl and not flags.cmd` |
| Alt/Option | `flags.alt` | `flags.alt` |
| Shift | `flags.shift` | `flags.shift` |

Setzen Sie das Flag auf `true`, um es zu erfordern, `not flags.xxx`, um es auszuschließen.

### Tastencode

Ändern Sie `keycodes.map["s"]` in einen beliebigen Tastennamen. Häufige Beispiele:

```lua
keycodes.map["s"]       -- S
keycodes.map["b"]       -- B
keycodes.map["/"]       -- /
keycodes.map["return"]  -- Return/Enter
keycodes.map["space"]   -- Leertaste
keycodes.map["f1"]      -- F1
```

Vollständige Tastennamenliste: Führen Sie `hs.keycodes.map` in der Hammerspoon-Konsole aus.

### Beispiele

**`Ctrl+Shift+B`**:
```lua
if flags.ctrl and not flags.cmd and flags.shift and not flags.alt
    and keyCode == keycodes.map["b"] then
```

**`Cmd+Alt+/`**:
```lua
if flags.cmd and not flags.ctrl and flags.alt and not flags.shift
    and keyCode == keycodes.map["/"] then
```

**`Cmd+Shift+Return`**:
```lua
if flags.cmd and not flags.ctrl and not flags.alt and flags.shift
    and keyCode == keycodes.map["return"] then
```

Nach dem Bearbeiten laden Sie die Hammerspoon-Konfiguration neu, um die Änderungen anzuwenden.

## So funktioniert es (macOS)

1. Ein `eventtap` fängt `Cmd+S` ab, wenn Chrome im Vordergrund ist (Schemata 1 & 3)
2. Ein Mauspositions-Poller (50Hz) erkennt das Schweben am linken Rand und das Verlassen (Schemata 2 & 3)
3. Beide Auslöser rufen die Funktion `toggleSidebar()` auf. Diese Funktion dient dazu:
   - das AX-Wurzelelement von Chrome über `hs.axuielement.applicationElement()` abzurufen
   - in den Fenstern nach einer Schaltfläche mit `AXDescription` zu suchen, die zu "Expand Tabs" oder "Collapse Tabs" passt
   - `performAction("AXPress")` auf der gefundenen Schaltfläche aufzurufen
4. Ein Watchdog erkennt, wenn der Mauspoller abstürzt, und startet ihn automatisch neu (Schemata 2 & 3)
5. Verzögerungszeiten (Grace Periods) verhindern Fehlauslöser beim App-Wechsel

---

# Windows reference


Die folgenden Abschnitte gelten für die **Windows-Version (AutoHotkey)**. Siehe die [Windows-Hinweise](windows/README.md) für den automatischen Start und zur Fehlerbehebung.

## Verwendung (Windows)

| Tastenkürzel | Aktion |
|--------------|--------|
| `Ctrl+S` (in Chrome) | Vertikale Tab-Seitenleiste umschalten |
| `Ctrl+S` (anderswo) | Wird als normales Tastenkürzel zum Speichern durchgereicht |
| `Ctrl+Alt+Q` | Skript beenden |

Das Skript fängt `Ctrl+S` nur ab, wenn das aktive Fenster ein Chromium-Fenster ist (Fensterklasse `Chrome_WidgetWin_1`), sodass das Speichern in jeder anderen App weiterhin funktioniert.

## Tastenkürzel anpassen (Windows)

Der Standard ist `Ctrl+S`. Um eine andere Taste zu verwenden, bearbeiten Sie die Hotkey-Zeile in `windows/ChromeVTabToggle.ahk`:

```autohotkey
$^s:: {        ; ^ = Ctrl, ! = Alt, + = Shift, # = Win
```

Zum Beispiel wäre `Ctrl+Alt+S` gleich `$^!s::`. Wenn Sie von `Ctrl+S` abweichen, können Sie auch den Durchreiche-Zweig `{Blind}^s` entfernen, da es kein natives Tastenkürzel mehr zu erhalten gibt.

## So funktioniert es (Windows)

1. Ein globaler `Ctrl+S`-Hotkey prüft, ob das aktive Fenster ein Chromium-Fenster ist (`WinGetClass = "Chrome_WidgetWin_1"`). Falls nicht, reicht er `Ctrl+S` durch.
2. `UIA.ElementFromHandle()` ruft die UI-Automation-Wurzel für das aktive Fenster ab.
3. `FindSidebarButton()` durchläuft den UIA-Baum und sucht nach einer Schaltfläche, deren Name zu einer Beschriftung in `SIDEBAR_LABELS` passt.
4. `button.Invoke()` schaltet die Seitenleiste um — das UIA-Äquivalent zu `AXPress` unter macOS.

## Dateien

| Datei | Beschreibung |
|-------|--------------|
| `init.lua` | Version mit 3 Schemata (Tastatur / Maus / beides) — macOS |
| `init-keyboard-only.lua` | Nur-Tastatur-Version, keine Mauserkennung — macOS |
| `windows/ChromeVTabToggle.ahk` | Windows-Portierung (AutoHotkey v2, nur Tastatur) |
| `windows/README.md` | Vollständige Windows-Referenz (Anpassung, Fehlerbehebung) |

## Danksagung

- Originalkonzept: [ChromeSidebarToggleRaycast](https://github.com/RotulPlastik/ChromeSidebarToggleRaycast) von RotulPlastik
- Für Hammerspoon adaptiert mit Bildschirmrand-Trigger-Unterstützung

## Lizenz

MIT
