
---------------------
---- MY PROGRAMS ----
---------------------

-- Set programs that you use
local terminal = "foot"
local fileManager = "nautilus"
local menu = "rofi -show run"


---------------------
---- KEYBINDINGS ----
---------------------

hl.bind("SUPER + RETURN", hl.dsp.exec_cmd(terminal))
local closeWindowBind = hl.bind("SUPER + Q", hl.dsp.window.close())
hl.bind("SUPER + E", hl.dsp.exec_cmd(fileManager))
hl.bind("SUPER + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind("SUPER + R", hl.dsp.exec_cmd(menu))

-- Quickshell
hl.bind("SUPER + SPACE", hl.dsp.global("quickshell:launcher"))
hl.bind("SUPER + ESCAPE", hl.dsp.global("quickshell:power"))
hl.bind("SUPER + M", hl.dsp.global("quickshell:music"))
hl.bind("SUPER + SHIFT + M", hl.dsp.global("quickshell:mpd"))
hl.bind("SUPER + L", hl.dsp.global("quickshell:lock"))
hl.bind("SUPER + W", hl.dsp.exec_cmd("qs -c hyprshell ipc call wallpaper random"))

hl.bind("SUPER + HOME", hl.dsp.exec_cmd("qs -c testshell ipc call panel toggle"))

-- Windows
hl.bind("SUPER + C", hl.dsp.layout("center"))
hl.bind("SUPER + F", hl.dsp.window.fullscreen({ mode = "fullscreen" }))
hl.bind("SUPER + SHIFT + F", hl.dsp.window.fullscreen({ mode = "maximized" }))
hl.bind("SUPER + BACKSLASH", function()
    local win = hl.get_active_window()
    local on = win and win.fullscreen_client == 2
    hl.dispatch(hl.dsp.window.fullscreen_state({ internal = 0, client = on and 0 or 2 }))
end)

-- Move focus with mainMod + arrow keys
hl.bind("SUPER + left",  hl.dsp.layout("focus l"))
hl.bind("SUPER + right",  hl.dsp.layout("focus r"))
hl.bind("SUPER + Prior", hl.dsp.focus({ direction = "up" }))
hl.bind("SUPER + Next",  hl.dsp.focus({ direction = "down" }))

hl.bind("SUPER + up",    hl.dsp.focus({ workspace = "r-1" }))
hl.bind("SUPER + down",  hl.dsp.focus({ workspace = "r+1" }))

-- Move Workspace up/down/left/right
hl.bind("SUPER + SHIFT + left",  hl.dsp.layout("swapcol l"))
hl.bind("SUPER + SHIFT + right",  hl.dsp.layout("swapcol r"))
hl.bind("SUPER + SHIFT + Prior", hl.dsp.window.move({ direction = "up" }))
hl.bind("SUPER + SHIFT + Next",  hl.dsp.window.move({ direction = "down" }))

-- Move Workspace up/down workspace
hl.bind("SUPER + SHIFT + up",    hl.dsp.window.move({ workspace = "r-1" }))
hl.bind("SUPER + SHIFT + down",  hl.dsp.window.move({ workspace = "r+1" }))

-- Move workspace in/out of group left/right
hl.bind("SUPER + SHIFT + ALT + left",  hl.dsp.layout("consume_or_expel prev"))
hl.bind("SUPER + SHIFT + ALT + right", hl.dsp.layout("consume_or_expel next"))

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with SUPER + SHIFT + [0-9]
-- Resize active window with SUPER + CONTROL + [0-9]
for i = 1, 10 do
    local key = i % 10
    hl.bind("SUPER + " .. key,             hl.dsp.focus({ workspace = i}))
    hl.bind("SUPER + SHIFT + " .. key,     hl.dsp.window.move({ workspace = i }))
    hl.bind("SUPER + CONTROL + " .. key,         hl.dsp.layout("colresize " .. (i / 10)))
end

-- Resizing Window
hl.bind("SUPER + CONTROL + EQUAL", hl.dsp.layout("colresize +0.05"))
hl.bind("SUPER + CONTROL + MINUS", hl.dsp.layout("colresize -0.05"))

-- Example special workspace (scratchpad)
hl.bind("SUPER + S",         hl.dsp.workspace.toggle_special("magic"))
hl.bind("SUPER + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind("SUPER + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind("SUPER + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Laptop multimedia keys for volume and LCD brightness
hl.bind("SUPER + ALT + EQUAL", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 1%+"), { locked = true, repeating = true })
hl.bind("SUPER + ALT + MINUS", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%-"),      { locked = true, repeating = true })
hl.bind("SUPER + ALT + 0",        hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),     { locked = true, repeating = true })
hl.bind("SUPER + ALT + SHIFT + 0",     hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),   { locked = true, repeating = true })

-- Requires playerctl
hl.bind("SUPER + ALT + 9",  hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind("SUPER + ALT + 8", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("SUPER + ALT + 7",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true })


