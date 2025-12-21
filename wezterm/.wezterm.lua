-- Pull in the wezterm API
local wezterm = require("wezterm")
local smart_splits = wezterm.plugin.require("https://github.com/mrjones2014/smart-splits.nvim")

-- This will hold the configuration.
local config = wezterm.config_builder()

local is_linux = wezterm.target_triple:find("linux") ~= nil

config.wsl_domains = {
	{
		-- The name of this specific domain.  Must be unique amonst all types
		-- of domain in the configuration file.
		name = "WSL:Ubuntu-22.04",

		-- The name of the distribution.  This identifies the WSL distribution.
		-- It must match a valid distribution from your `wsl -l -v` output in
		-- order for the domain to be useful.
		distribution = "Ubuntu-22.04",
	},
}
-- config.default_domain = 'WSL:Ubuntu-22.04'

if is_linux then
	config.enable_wayland = true
	config.default_prog = { "/usr/bin/fish" }
else
	config.default_prog = { "pwsh.exe" }
	config.default_cwd = "C:/dev/git"
end

config.leader = { key = "a", mods = "CTRL" }
config.keys = {
	{
		key = "t",
		mods = "LEADER",
		action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "v",
		mods = "LEADER",
		action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
	},
	-- Send "CTRL-A" to the terminal when pressing CTRL-A, CTRL-A
	{
		key = "a",
		mods = "LEADER|CTRL",
		action = wezterm.action.SendKey({ key = "a", mods = "CTRL" }),
	},
	-- {
	-- 	key = "h",
	-- 	mods = "LEADER",
	-- 	action = wezterm.action.ActivatePaneDirection("Left"),
	-- },
	-- {
	-- 	key = "l",
	-- 	mods = "LEADER",
	-- 	action = wezterm.action.ActivatePaneDirection("Right"),
	-- },
	-- {
	-- 	key = "k",
	-- 	mods = "LEADER",
	-- 	action = wezterm.action.ActivatePaneDirection("Up"),
	-- },
	-- {
	-- 	key = "j",
	-- 	mods = "LEADER",
	-- 	action = wezterm.action.ActivatePaneDirection("Down"),
	-- },
}

--   -- This causes `wezterm` to act as though it was started as
--   -- `wezterm connect unix` by default, connecting to the unix
--   -- domain on startup.
--   -- If you prefer to connect manually, leave out this line.
--   config.default_gui_startup_args = { 'connect', 'unix' }

-- This is where you actually apply your config choices

-- General config
config.max_fps = 120 -- is ignored on Wayland
config.hide_tab_bar_if_only_one_tab = true
config.font_size = 11
config.line_height = 0.95
config.window_padding = {
	left = "0.25cell",
	right = "0",
	top = "0.3cell",
	bottom = "0",
}

-- OS specific config
if is_linux then
	config.color_scheme = "Gruvbox dark, hard (base16)"
	config.window_background_opacity = 0.5
	-- TODO: workaround to updated Hyprland - https://github.com/wezterm/wezterm/issues/7156
	-- This makes use need to either disable wayland in wezterm or double dpi:
	--	https://github.com/hyprwm/Hyprland/releases/tag/v0.51.0
	config.dpi = 192.0 * 2 -- twice the default
else
	config.color_scheme = "Gruvbox dark, hard (base16)"
end

-- you can put the rest of your Wezterm config here
smart_splits.apply_to_config(config)

-- and finally, return the configuration to wezterm
return config
