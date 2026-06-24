<p align="center">
  <img src="assets/logo.png" alt="Chrome-Vertical-Tab-Sidebar-Toggle Logo" width="200">
</p>

<h1 align="center">Chrome-Vertical-Tab-Sidebar-Toggle</h1>

<p align="center">
  <strong>Переключайте встроенную боковую панель вертикальных вкладок Chrome горячей клавишей.</strong><br>
  macOS (Hammerspoon) и Windows (AutoHotkey) — горячая клавиша, активация при наведении на край экрана, или оба варианта.
</p>

<p align="center">
  <a href="README.md">English</a> · <a href="README.zh-CN.md">简体中文</a> · <a href="README.zh-TW.md">繁體中文</a> · <a href="README_ja.md">日本語</a> · <a href="README_ko.md">한국어</a> · <a href="README_es.md">Español</a> · <a href="README_pt-BR.md">Português</a> · Русский · <a href="README_fr.md">Français</a> · <a href="README_de.md">Deutsch</a>
</p>

---

## Обзор функции

В Chrome есть встроенная боковая панель вертикальных вкладок, но нет горячей клавиши для её переключения. Этот проект добавляет такую возможность. Он находит кнопку «Expand Tabs» / «Collapse Tabs» Chrome в дереве доступности ОС и нажимает её за вас — используя Hammerspoon в macOS и AutoHotkey в Windows. Тот же подход, что и в [ChromeSidebarToggleRaycast](https://github.com/RotulPlastik/ChromeSidebarToggleRaycast).

## Демо

https://github.com/user-attachments/assets/bcf2a76a-8028-4b63-bc8a-f0b9e1178a25

## Выберите свою платформу

| Платформа | Как это работает | Начало работы |
|-----------|------------------|---------------|
| **macOS** | Hammerspoon + API Универсального доступа. Клавиатура, наведение на край экрана, или оба варианта. | [Установка → macOS](#installation) ↓ |
| **Windows** | AutoHotkey v2 + UI Automation. Только клавиатура (`Ctrl+S`). | [Установка → Windows](#installation) ↓ |

Обе платформы полностью описаны на этой странице: см. [справочник по macOS](#macos-reference) и [справочник по Windows](#windows-reference) ниже.

## Поддерживаемые языковые среды Chrome

Скрипт сопоставляет метки кнопок боковой панели в дереве доступности Chrome. Работает из коробки с любой из этих языковых сред:

| Язык | Языковая среда | Развернуть вкладки | Свернуть вкладки |
|------|----------------|--------------------|--------------------|
| Английский | `en` | Expand tabs | Collapse tabs |
| Традиционный китайский | `zh-TW` / `zh-HK` | 展開分頁 | 收合分頁 |
| Упрощённый китайский | `zh-CN` | 展开标签页 | 收起标签页 |
| Японский | `ja` | タブを開く | タブを閉じる |
| Корейский | `ko` | 탭 펼치기 | 탭 접기 |
| Немецкий | `de` | Tabs maximieren | Tabs minimieren |
| Испанский | `es` | Mostrar pestañas | Ocultar pestañas |
| Французский | `fr` | Développer les onglets | Réduire les onglets |
| Португальский (Бразилия) | `pt-BR` | Mostrar guias | Ocultar guias |
| Русский | `ru` | Развернуть вкладки | Свернуть вкладки |

Чтобы добавить другой язык, найдите метку кнопки в вашей языковой среде Chrome и добавьте её в список `SIDEBAR_LABELS` — в `init.lua` (macOS) или `windows/ChromeVTabToggle.ahk` (Windows).

## Включение боковой панели вертикальных вкладок в Chrome

Боковая панель вертикальных вкладок по умолчанию отключена. Чтобы включить:

1. Введите `chrome://flags/#vertical-tabs` в адресной строке
2. Измените **Vertical tabs** на **Enabled**
3. Нажмите **Relaunch** для перезапуска Chrome
4. После перезапуска щёлкните правой кнопкой мыши по пустой области панели вкладок, чтобы увидеть опцию

## Установка

Выберите свою платформу. Обе делают одно и то же; различаются лишь инструменты.

<details open>
<summary><b>macOS</b> — Hammerspoon (клавиатура / наведение на край экрана / оба)</summary>

**Требования:** macOS 13+, [Hammerspoon](https://www.hammerspoon.org), Chrome с включённой боковой панелью вертикальных вкладок и разрешение на Универсальный доступ для Hammerspoon.

1. Установите Hammerspoon:

   ```bash
   brew install --cask hammerspoon
   ```

2. Выберите версию и скопируйте в конфигурацию Hammerspoon:

   **Версия со схемами** (три режима, по умолчанию):
   ```bash
   cp init.lua ~/.hammerspoon/init.lua
   ```

   **Версия только с клавиатурой**:
   ```bash
   cp init-keyboard-only.lua ~/.hammerspoon/init.lua
   ```

   Если у вас уже есть `~/.hammerspoon/init.lua`, добавьте содержимое в конец.

3. Предоставьте доступ к Универсальному доступу:
   - Системные настройки → Конфиденциальность и безопасность → Универсальный доступ
   - Добавьте и включите Hammerspoon

4. Перезагрузите конфигурацию Hammerspoon (нажмите на значок в строке меню → Перезагрузить конфигурацию)

5. (Необязательно) Добавьте Hammerspoon в элементы входа для автоматического запуска:
   - Системные настройки → Основные → Объекты входа
   - Добавьте Hammerspoon

См. [конфигурацию macOS](#schemes-macos-initlua) ниже о схемах, триггерах и настройке горячих клавиш.

</details>

<details open>
<summary><b>Windows</b> — AutoHotkey v2 (только клавиатура, <code>Ctrl+S</code>)</summary>

**Требования:** Windows 10/11, [AutoHotkey **v2**](https://www.autohotkey.com/), [`UIA.ahk` от Descolada](https://github.com/Descolada/UIA-v2) (загружается отдельно) и Chrome с включённой боковой панелью вертикальных вкладок.

1. Установите **AutoHotkey v2** с <https://www.autohotkey.com/> (не v1.1).

2. Загрузите **`UIA.ahk`** из [Descolada/UIA-v2](https://github.com/Descolada/UIA-v2) (`Lib/UIA.ahk`) и поместите его в папку `windows/`, рядом с `ChromeVTabToggle.ahk`:

   ```
   windows/
   ├── ChromeVTabToggle.ahk
   └── UIA.ahk          ← вы загружаете этот файл (~400 КБ, сторонний, отсутствует в этом репозитории)
   ```

3. Дважды щёлкните `windows/ChromeVTabToggle.ahk`, чтобы запустить его. Уведомление в трее подтвердит запуск.

4. Нажмите **`Ctrl+S`**, когда Chrome в фокусе, чтобы переключить боковую панель. (`Ctrl+S` по-прежнему работает как обычное сохранение во всех остальных приложениях.)

5. (Необязательно) Автозапуск при входе: нажмите `Win+R`, введите `shell:startup` и поместите **ярлык** на `ChromeVTabToggle.ahk` в эту папку.

О настройке горячих клавиш и устранении неполадок см. [подробные заметки по Windows](windows/README.md).

</details>

---

# macOS reference

Разделы ниже относятся к версии для **macOS (Hammerspoon)**. [Справочник по Windows](#windows-reference) находится далее.

## Schemes (macOS, `init.lua`)

Отредактируйте переменную `SCHEME` в верхней части `init.lua` для выбора режима:

| Схема | Значение | Триггеры |
|-------|----------|----------|
| Только клавиатура | `1` | `Cmd+S` переключает боковую панель |
| Только наведение на край экрана | `2` | Наведение курсора на левый край экрана для развёртывания, перемещение за 380px для свёртывания |
| Клавиатура + Мышь | `3` | Оба триггера активны (по умолчанию) |

```lua
local SCHEME = 3  -- 1 = Клавиатура, 2 = Наведение на край экрана, 3 = Оба
```

Когда Chrome не является активным приложением, все триггеры автоматически отключаются.

## Триггеры (macOS)

| Триггер | Действие | Схема |
|---------|----------|-------|
| `Cmd+S` | Переключить боковую панель | 1 & 3 |
| Мышь на левом краю (0-2px) в течение 0,15 с | Развёрнуть боковую панель | 2 & 3 |
| Мышь перемещается за 380px от левого края | Свернуть боковую панель | 2 & 3 |

## Отладка (macOS)

| Комбинация | Действие |
|------------|----------|
| `Cmd+Alt+D` | Показать статус службы |
| `Cmd+Alt+B` | Вывести все кнопки AX Chrome в консоль |
| `Cmd+Alt+R` | Принудительный перезапуск всех служб |

## Конфигурация (macOS)

### Селектор схемы (`init.lua`)

```lua
local SCHEME = 3  -- 1 = Клавиатура, 2 = Наведение на край экрана, 3 = Оба
```

### Пороговые значения наведения на край экрана (`init.lua`, схемы 2 & 3)

```lua
local EDGE_THRESHOLD    = 2       -- пикселей от левого края для срабатывания
local EXIT_THRESHOLD    = 380     -- пикселей от левого края для свёртывания
local WAIT_TIME         = 0.15    -- время ожидания в секундах перед срабатыванием (0,15 с)
local MOUSE_POLL_INTERVAL = 0.05  -- секунд между проверками позиции мыши
```

### Обе версии

```lua
local DEBUG = true  -- выводить отладочные сообщения в консоль
```

## Настройка горячих клавиш (macOS)

Доступно в `init.lua` и `init-keyboard-only.lua`. Комбинация по умолчанию — `Cmd+S`, которая перезаписывает стандартное сочетание клавиш Chrome для «Сохранить страницу». Для изменения отредактируйте проверку клавиши в функции `createKeyTap`:

```lua
-- Cmd+S -> toggle sidebar
if flags.cmd and not flags.ctrl and not flags.alt and not flags.shift
    and keyCode == keycodes.map["s"] then
```

### Модификаторы

Измените условия `flags.*` для установки желаемой комбинации модификаторов:

| Модификатор | Флаг | Пример |
|-------------|------|--------|
| Cmd | `flags.cmd` | `flags.cmd and not flags.ctrl` |
| Ctrl | `flags.ctrl` | `flags.ctrl and not flags.cmd` |
| Alt/Option | `flags.alt` | `flags.alt` |
| Shift | `flags.shift` | `flags.shift` |

Установите флаг в `true` для требования, `not flags.xxx` для исключения.

### Код клавиши

Замените `keycodes.map["s"]` на любое имя клавиши. Частые примеры:

```lua
keycodes.map["s"]       -- S
keycodes.map["b"]       -- B
keycodes.map["/"]       -- /
keycodes.map["return"]  -- Return/Enter
keycodes.map["space"]   -- Пробел
keycodes.map["f1"]      -- F1
```

Полный список имён клавиш: выполните `hs.keycodes.map` в консоли Hammerspoon.

### Примеры

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

После редактирования перезагрузите конфигурацию Hammerspoon для применения изменений.

## Как это работает (macOS)

1. `eventtap` перехватывает `Cmd+S`, когда Chrome является активным приложением (схемы 1 & 3)
2. Таймер опроса положения мыши (50 Гц) обнаруживает наведение на левый край экрана и уход курсора (схемы 2 & 3)
3. Оба триггера вызывают функцию `toggleSidebar()`, которая:
   - Получает корневой элемент `AXUIElement` Chrome через `hs.axuielement.applicationElement()`
   - Ищет в окнах кнопку с `AXDescription`, соответствующим "Expand Tabs" или "Collapse Tabs"
   - Вызывает `performAction("AXPress")` на найденной кнопке
4. Сторожевой таймер (watchdog) обнаруживает сбой таймера опроса мыши и автоматически перезапускает его (схемы 2 & 3)
5. Периоды задержки предотвращают ложные срабатывания при переключении приложений

---

# Windows reference


Разделы ниже относятся к версии для **Windows (AutoHotkey)**. См. [заметки по Windows](windows/README.md) об автозапуске и устранении неполадок.

## Использование (Windows)

| Комбинация | Действие |
|------------|----------|
| `Ctrl+S` (в Chrome) | Переключить боковую панель вертикальных вкладок |
| `Ctrl+S` (в другом месте) | Передаётся как обычное сочетание для сохранения |
| `Ctrl+Alt+Q` | Завершить работу скрипта |

Скрипт перехватывает `Ctrl+S` только тогда, когда активное окно является окном Chromium (класс окна `Chrome_WidgetWin_1`), поэтому сохранение по-прежнему работает во всех остальных приложениях.

## Настройка горячих клавиш (Windows)

По умолчанию используется `Ctrl+S`. Чтобы использовать другую клавишу, отредактируйте строку горячей клавиши в `windows/ChromeVTabToggle.ahk`:

```autohotkey
$^s:: {        ; ^ = Ctrl, ! = Alt, + = Shift, # = Win
```

Например, `Ctrl+Alt+S` будет `$^!s::`. Если вы перейдёте с `Ctrl+S` на другую комбинацию, можно также удалить ветку проброса `{Blind}^s`, поскольку больше не нужно сохранять стандартное сочетание.

## Как это работает (Windows)

1. Глобальная горячая клавиша `Ctrl+S` проверяет, является ли активное окно окном Chromium (`WinGetClass = "Chrome_WidgetWin_1"`). Если нет, она пробрасывает `Ctrl+S` дальше.
2. `UIA.ElementFromHandle()` получает корень UI Automation для активного окна.
3. `FindSidebarButton()` обходит дерево UIA в поисках кнопки, имя которой соответствует любой метке из `SIDEBAR_LABELS`.
4. `button.Invoke()` переключает боковую панель — это эквивалент `AXPress` из macOS в UIA.

## Файлы

| Файл | Описание |
|------|----------|
| `init.lua` | Версия с тремя схемами (клавиатура / мышь / оба) — macOS |
| `init-keyboard-only.lua` | Версия только с клавиатурой, без обнаружения мыши — macOS |
| `windows/ChromeVTabToggle.ahk` | Порт для Windows (AutoHotkey v2, только клавиатура) |
| `windows/README.md` | Полный справочник по Windows (настройка, устранение неполадок) |

## Благодарности

- Оригинальная концепция: [ChromeSidebarToggleRaycast](https://github.com/RotulPlastik/ChromeSidebarToggleRaycast) by RotulPlastik
- Адаптировано для Hammerspoon с поддержкой активации при наведении на край экрана

## Лицензия

MIT
