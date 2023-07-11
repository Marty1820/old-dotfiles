local wezterm = require("wezterm")

-- Title/Tab Bar
require("title_bar")

-- All Other Settings
return {
	-- Fonts
	font = wezterm.font("Hack Nerd Font Mono"),
	font_size = 12.0,

	-- Colors
	color_scheme = "Dracula (Official)", -- full list @ wezfurlong.org/wezterm/colorschemes/index.html
	tab_bar_at_bottom = false,
	use_fancy_tab_bar = true,
	window_decorations = "RESIZE",

	-- Keybindings
	keys = require("keys"),

	-- Appearance/Settings
	enable_tab_bar = true,
	hide_tab_bar_if_only_one_tab = true,
	scrollback_lines = 5000,
	adjust_window_size_when_changing_font_size = false,
	window_close_confirmation = "NeverPrompt",
	warn_about_missing_glyphs = false,
	cursor_blink_rate = 0,
}
