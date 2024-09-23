local wezterm = require("wezterm")
local config = {}

if wezterm.config_builder then
	config = wezterm.config_builder()
end

config = {
	window_decorations = "NONE",
	automatically_reload_config = true,
	color_scheme = "Catppuccin Mocha",
	font = wezterm.font("DaddyTimeMono Nerd Font Mono"),
	font_size = 15,
	window_close_confirmation = "NeverPrompt",
	hide_tab_bar_if_only_one_tab = true,
	window_background_opacity = 0.8,
	text_background_opacity = 0.9,
}

return config
