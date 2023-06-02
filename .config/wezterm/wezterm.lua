local wezterm = require 'wezterm';

title = require('title_bar');

-- All Other Settings
return {
  -- Fonts
  font = wezterm.font 'Hack Nerd Font Mono',
  font_size	= 12.0,

  -- Colors
  color_scheme = "Dracula (Official)", -- full list @ wezfurlong.org/wezterm/colorschemes/index.html

  -- Key Assignments
  keys = require('keys'),

  -- Appearance/Settings
  window_background_opacity = 1.0,
  enable_tab_bar = true,
  hide_tab_bar_if_only_one_tab = true,
  scrollback_lines = 5000,
  adjust_window_size_when_changing_font_size = false,
  window_close_confirmation = 'NeverPrompt',
}

