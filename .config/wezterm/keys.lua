local wezterm = require("wezterm")
local act = wezterm.action

return {
	-- Tab Navigation
	{
		key = "LeftArrow",
		mods = "CTRL",
		action = act.ActivateTabRelative(-1),
	},
	{
		key = "RightArrow",
		mods = "CTRL",
		action = act.ActivateTabRelative(1),
	},
	{ key = "1", mods = "CTRL", action = act.ActivateTab(0) },
	{ key = "2", mods = "CTRL", action = act.ActivateTab(1) },
	{ key = "3", mods = "CTRL", action = act.ActivateTab(2) },
	{ key = "4", mods = "CTRL", action = act.ActivateTab(3) },
	{ key = "5", mods = "CTRL", action = act.ActivateTab(4) },
	-- Tab/Pane Creation
	{
		key = "t",
		mods = "CTRL",
		action = act.SpawnTab("CurrentPaneDomain"),
	},
	{
		key = "T",
		mods = "CTRL|SHIFT",
		action = act.SplitPane({
			direction = "Right",
			size = { Percent = 50 },
		}),
	},
	-- Tab/Pane Deletion
	{
		key = "w",
		mods = "CTRL",
		action = act.CloseCurrentTab({ confirm = false }),
	},
	{
		key = "w",
		mods = "ALT",
		action = act.CloseCurrentPane({ confirm = false }),
	},
	-- Terminal Navigation
	{ key = "PageUp", mods = "", action = act.ScrollByPage(-1) },
	{ key = "PageDown", mods = "", action = act.ScrollByPage(1) },
	{ key = "Home", mods = "", action = act.ScrollToTop },
	{ key = "End", mods = "", action = act.ScrollToBottom },
}
