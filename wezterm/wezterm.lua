local wezterm = require 'wezterm';

local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
	config = wezterm.config_builder()
end

-- This is where you actually apply your config choices
--
config.font = wezterm.font("Cascadia Code", { weight = "Regular" })

-- For example, changing the color scheme:
config.color_scheme = 'Tokyo Night Moon'

config.default_prog = { 'Arch.exe' }

-- and finally, return the configuration to wezterm
return config
