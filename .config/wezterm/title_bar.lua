local wezterm = require 'wezterm'

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
