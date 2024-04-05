local wezterm = require("wezterm")

local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
	config = wezterm.config_builder()
end

-- This is where you actually apply your config choices
--
config.font = wezterm.font("JetBrainsMono Nerd Font", { weight = "Regular" })
config.font_size = 16.0

-- For example, changing the color scheme:
config.color_scheme = "Tokyo Night Moon"

config.hide_tab_bar_if_only_one_tab = true

-- and finally, return the configuration to wezterm
return config
