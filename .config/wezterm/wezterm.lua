local wezterm = require 'wezterm';
local act = wezterm.action

-- Tab Title
wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
  if tab.is_active then
    local title = wezterm.truncate_right(tab.active_pane.title, max_width)
    return {
      { Text = title },
    }
  end
  return { tab.active_pane.title }
end)

-- Window Title
wezterm.on('format-window-title', function(tab, pane, tabs, panes, config)
  local zoomed = ''
  if tab.active_pane.is_zoomed then
    zoomed = '[Z] '
  end

  local index = ''
  if #tabs > 1 then
    index = string.format('[%d/%d] ', tab.tab_index + 1, #tabs )
  end

  return zoomed .. index .. tab.active_pane.title
end)

-- All Other Settings
return {
  -- Fonts
  font = wezterm.font 'Hack Nerd Font Mono',
  font_size	= 12.0,

  -- Colors
  color_scheme = "Dracula (Official)", -- full list @ wezfurlong.org/wezterm/colorschemes/index.html

  -- Key Assignments
  keys = {
    { key = 't', mods = 'CTRL', action = act.SpawnTab 'CurrentPaneDomain', },
    -- This will create a new split and run the `top` program inside it
    {
      key = 'T',
      mods = 'CTRL|SHIFT',
      action = wezterm.action.SplitPane {
        direction = 'Right',
        -- command = { args = { 'top' } },
        size = { Percent = 50 },
      },
    },
    { key = 'w', mods = 'CTRL', action = act.CloseCurrentTab { confirm = true }, },
    { key = 'PageUp', mods = 'SHIFT', action = act.ScrollByPage(-1) },
    { key = 'PageDown', mods = 'SHIFT', action = act.ScrollByPage(1) },
    { key = 'Home', mods = 'SHIFT', action = act.ScrollToTop },
    { key = 'End', mods = 'SHIFT', action = act.ScrollToBottom },
    { key = 'l', mods = 'ALT|SHIFT', action = act.ActivateTabRelative(1) },
    { key = 'h', mods = 'ALT|SHIFT', action = act.ActivateTabRelative(-1) },
    {
      key = 'w',
      mods = 'ALT',
      action = wezterm.action.CloseCurrentPane { confirm = true },
    },
  },

  -- Appearance/Settings
  window_background_opacity = 1.0,
  enable_tab_bar = true,
  hide_tab_bar_if_only_one_tab = true,
  scrollback_lines = 5000,
  adjust_window_size_when_changing_font_size = false,

  term = "wezterm"
}

