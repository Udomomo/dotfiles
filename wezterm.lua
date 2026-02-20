-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()
config.automatically_reload_config = true
config.initial_cols = 100
config.initial_rows = 30
config.font_size = 18.0
config.use_ime = true

config.window_background_opacity = 0.85
config.macos_window_background_blur = 20

config.window_decorations = "RESIZE"
config.hide_tab_bar_if_only_one_tab = true
config.show_new_tab_button_in_tab_bar = false
config.show_close_tab_button_in_tabs = false

config.leader = { key = "j", mods = "CTRL", timeout_milliseconds = 2000 }

config.color_scheme = 'Kanagawa (Gogh)'

return config
