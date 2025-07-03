local wezterm = require("wezterm")

local config = wezterm.config_builder()

config.disable_default_key_bindings = true
config.enable_tab_bar = false

config.font = wezterm.font("CodeNewRoman Nerd Font Propo")
config.font_size = 12

config.color_scheme = "Tokyo Night"
config.window_decorations = "TITLE | RESIZE"
config.window_frame = {
	active_titlebar_bg = "#111117",
	inactive_titlebar_bg = "#1B1A26",
	button_bg = "#111117",
	button_fg = "#cccccc",
	button_hover_fg = "#9ece6a",
}

config.keys = {
	{ key = "v", mods = "CTRL|SHIFT", action = wezterm.action.PasteFrom("Clipboard") },
	{ key = "c", mods = "CTRL|SHIFT", action = wezterm.action.CopyTo("Clipboard") },
	{ key = "x", mods = "CTRL|SHIFT", action = wezterm.action.CloseCurrentTab({ confirm = true }) },
}

return config
