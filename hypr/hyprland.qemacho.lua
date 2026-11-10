-- Hyprland config for qemacho (MacBookPro15,4, 13" 2019, Intel Iris Plus 645).
--
-- Derived from the owner's ASUS laptop config so the muscle memory transfers.
-- Host-specific differences from that config, all deliberate:
--
--   * AQ_DRM_DEVICES is gone. That line exists on the ASUS to steer Aquamarine
--     away from the NVIDIA card; qemacho has one GPU (i915) and one card node.
--   * Internal panel is 2560x1600 on 13" - scale 1 would be unusable, so the
--     eDP gets scale 1.5.
--   * The one external display is driven over Thunderbolt 3 (DP alt-mode). Its
--     output name varies with the adapter/dock, so it is matched by description
--     rather than pinned to DP-1/HDMI-A-1.
--   * polkit-kde-agent is not installed here (graphical_packages does not ship
--     it); hyprpolkitagent is installed by the role instead.
--   * Touchpad sensitivity/accel tuned down - the T2 trackpad is coarse compared
--     to the ASUS and the owner's settings feel twitchy on it.
--
-- Keybinds are identical to the owner's laptop on purpose.

--###############
--## MONITORS ###
--###############

-- Internal Retina panel. 2560x1600 on 13" -> 1.5 is the readable scale.
hl.monitor({
    output = "eDP-1",
    mode = "2560x1600@60.00",
    position = "0x0",
    scale = "1.5",
})

-- External display over TB3, positioned to the right of the laptop panel.
-- Matched by description so it works regardless of whether the adapter
-- enumerates as DP-1, DP-2 or HDMI-A-1.
--
-- The mode is PINNED to 100 Hz, not "preferred". This is the same monitor and the
-- same trap as qemini/qecarbon: it is a 100 Hz ultrawide whose EDID *preferred*
-- mode is 60 Hz, so "preferred" silently modesets to 60 and pointer motion looks
-- choppy. Verified on this machine: `hyprctl monitors` showed 2560x1080@59.978
-- while availableModes listed 2560x1080@100.00Hz.
-- Matched by EDID description: "LG Electronics LG ULTRAWIDE". A desc: match is
-- used rather than pinning DP-1 because the output name depends on which TB3
-- adapter/dongle is in use - it has enumerated as DP-1 here, but a different
-- adapter can present it as DP-2 or HDMI-A-1.
hl.monitor({
    output = "desc:LG Electronics LG ULTRAWIDE",
    mode = "2560x1080@100",
    position = "auto-right",
    scale = "1",
})

-- Catch-all: anything else (e.g. a second external) gets preferred + auto.
hl.monitor({
    output = "",
    mode = "preferred",
    position = "auto",
    scale = "1",
})

--##################
--## MY PROGRAMS ###
--##################

local terminal = "ghostty"
local fileManager = "thunar"
local menu = "bemenu-run"

--############################
--## ENVIRONMENT VARIABLES ###
--############################

hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")
hl.env("XDG_SESSION_TYPE", "wayland")

-- Intel: nothing to steer. Explicitly NOT setting AQ_DRM_DEVICES.
-- libva/mesa pick the iGPU automatically since it is the only one.

hl.curve("myBezier", { type = "bezier", points = { { 0.05, 0.9 }, { 0.1, 1.05 } } })

-- Animations off, matching the owner's laptop (also helps on a 15W iGPU).
hl.animation({ leaf = "windows",     enabled = false, speed = 7,  bezier = "myBezier" })
hl.animation({ leaf = "windowsOut",  enabled = false, speed = 7,  bezier = "default", style = "popin 80%" })
hl.animation({ leaf = "border",      enabled = false, speed = 10, bezier = "default" })
hl.animation({ leaf = "borderangle", enabled = false, speed = 8,  bezier = "default" })
hl.animation({ leaf = "fade",        enabled = false, speed = 7,  bezier = "default" })
hl.animation({ leaf = "workspaces",  enabled = false, speed = 6,  bezier = "default" })

--###################
--## KEYBINDINGS ###
--###################

local mainMod = "ALT"

hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + SHIFT + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + M", hl.dsp.exit())
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + Space", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }))
hl.bind(mainMod .. " + D", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())

hl.bind(mainMod .. " + h", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + l", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + j", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + k", hl.dsp.focus({ direction = "down" }))

hl.bind(mainMod .. " + SHIFT + h", hl.dsp.window.move({ direction = "l" }))
hl.bind(mainMod .. " + SHIFT + l", hl.dsp.window.move({ direction = "r" }))
hl.bind(mainMod .. " + SHIFT + j", hl.dsp.window.move({ direction = "u" }))
hl.bind(mainMod .. " + SHIFT + k", hl.dsp.window.move({ direction = "d" }))

hl.bind(mainMod .. " + SHIFT + right", hl.dsp.window.resize({ x = 10, y = 0, relative = true }))
hl.bind(mainMod .. " + SHIFT + left", hl.dsp.window.resize({ x = -10, y = 0, relative = true }))
hl.bind(mainMod .. " + SHIFT + up", hl.dsp.window.resize({ x = 0, y = -10, relative = true }))
hl.bind(mainMod .. " + SHIFT + down", hl.dsp.window.resize({ x = 0, y = 10, relative = true }))

for i = 1, 10 do
    local key = tostring(i % 10)
    hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("pactl -- set-sink-volume 0 -10%"))
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("pactl -- set-sink-volume 0 +10%"))
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("pactl -- set-sink-mute 0 toggle"))
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("pactl -- set-source-mute 0 toggle"))
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl s 10%-"))
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl s +10%"))

hl.config({
    cursor = {
        no_hardware_cursors = true,
    },
    general = {
        gaps_in = 2,
        gaps_out = 2,
        border_size = 1,
        col = {
            active_border = { colors = { "rgba(33ccffee)", "rgba(00ff99ee)" }, angle = 45 },
            inactive_border = "rgba(595959aa)",
        },
        resize_on_border = true,
        allow_tearing = false,
        layout = "dwindle",
    },
    decoration = {
        rounding = 10,
        active_opacity = 1.0,
        inactive_opacity = 1.0,
        -- Blur stays on but light: Iris Plus 645 is a 15W iGPU.
        blur = {
            enabled = true,
            size = 3,
            passes = 1,
            vibrancy = 0.1696,
        },
    },
    animations = {
        enabled = false,
    },
    dwindle = {
        preserve_split = true,
    },
    misc = {
        force_default_wallpaper = 0,
        disable_hyprland_logo = false,
    },
    input = {
        kb_layout = "us",
        kb_variant = "",
        kb_model = "",
        kb_options = "ctrl:nocaps",
        kb_rules = "",
        repeat_rate = 40,
        repeat_delay = 300,
        follow_mouse = 1,
        -- Softer than the ASUS (0.2 / flat / force_no_accel): the T2 trackpad
        -- reports differently and those values feel overshot here.
        sensitivity = 0.0,
        accel_profile = "adaptive",
        touchpad = {
            scroll_factor = 0.4,
            natural_scroll = true,
            clickfinger_behavior = true,
            tap_to_click = true,
        },
    },
})

hl.on("hyprland.start", function()
    hl.exec_cmd("mako")
    hl.exec_cmd("waybar")
    -- hyprpolkitagent is what roles/graphical installs here, not polkit-kde-agent.
    hl.exec_cmd("/usr/lib/hyprpolkitagent/hyprpolkitagent")
end)
