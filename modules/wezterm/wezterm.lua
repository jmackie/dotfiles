local wezterm = require("wezterm")
local mux = wezterm.mux
local act = wezterm.action

-- Maximize the wezterm window on start up
wezterm.on("gui-startup", function(cmd)
	local tab, pane, window = mux.spawn_window(cmd or {})
	window:gui_window():maximize()
end)

-- wezterm.gui is not available to the mux server, so take care to
-- do something reasonable when this config is evaluated by the mux
function get_appearance()
	if wezterm.gui then
		return wezterm.gui.get_appearance()
	end
	return "Dark"
end

function set_theme_for_appearance(config, appearance)
	local is_dark = appearance:find("Dark")
	if is_dark then
		config.color_scheme = "Dark+"
		config.window_background_opacity = 0.85
	else
		config.color_scheme = "Solarized Light (Gogh)"
		config.window_background_opacity = 1
	end
	return is_dark
end

function write_adaptive_helix_theme(theme_name)
	local theme_file = os.getenv("HOME") .. "/.config/helix/themes/adaptive.toml"
	local file = assert(io.open(theme_file, "w"))
	file:write("inherits = '" .. theme_name .. "'")
	file:close()
end

wezterm.on("window-config-reloaded", function(window, pane)
	local overrides = window:get_config_overrides() or {}
	local appearance = window:get_appearance()
	local is_dark = set_theme_for_appearance(overrides, appearance)
	if is_dark then
		write_adaptive_helix_theme("jmackie_dark")
	else
		write_adaptive_helix_theme("jmackie_light")
	end
	window:set_config_overrides(overrides)
end)

local config = wezterm.config_builder()

set_theme_for_appearance(config, get_appearance())
config.hide_tab_bar_if_only_one_tab = true
config.window_decorations = "RESIZE" -- hide title bar
config.font_size = 11.0
config.default_cursor_style = "SteadyBar" -- i.e. line not block
config.leader = { key = "p", mods = "CTRL", timeout_milliseconds = 1000 }
config.keys = {
	-- pane splitting
	{ key = "\\", mods = "LEADER", action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
	{ key = "-", mods = "LEADER", action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }) },
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
