local wezterm = require("wezterm")

local mux = wezterm.mux

wezterm.on('gui-startup', function(cmd)
  local tab, pane, window = mux.spawn_window(cmd or {})
  window:gui_window():maximize()
end)

local act = wezterm.action

local config = wezterm.config_builder()
config.color_scheme = "Dark+"
config.window_background_opacity = 0.85
config.hide_tab_bar_if_only_one_tab = true
config.window_decorations = "RESIZE" -- hide title bar
config.font_size = 11.0
config.default_cursor_style = "SteadyBar" -- i.e. line not block
config.leader = { key = "p", mods = "CTRL", timeout_milliseconds = 1000 }
config.keys = {
	-- pane splitting
	{ key = "\\", mods = "LEADER", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
	{ key = "-", mods = "LEADER", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
	-- pane navigation
	{ key = "j", mods = "CTRL", action = act.ActivatePaneDirection("Down") },
	{ key = "k", mods = "CTRL", action = act.ActivatePaneDirection("Up") },
	{ key = "h", mods = "CTRL", action = act.ActivatePaneDirection("Left") },
	{ key = "l", mods = "CTRL", action = act.ActivatePaneDirection("Right") },
	-- pane resizing
	{ key = "J", mods = "SHIFT|CTRL", action = act.AdjustPaneSize({ "Down", 1 }) },
	{ key = "K", mods = "SHIFT|CTRL", action = act.AdjustPaneSize({ "Up", 1 }) },
	{ key = "H", mods = "SHIFT|CTRL", action = act.AdjustPaneSize({ "Left", 1 }) },
	{ key = "L", mods = "SHIFT|CTRL", action = act.AdjustPaneSize({ "Right", 1 }) },
	-- tab navigation
	{ key = "h", mods = "SUPER", action = act.ActivateTabRelative(-1) },
	{ key = "l", mods = "SUPER", action = act.ActivateTabRelative(1) },
}

return config
