-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()
config.automatically_reload_config = true
config.initial_cols = 100
config.initial_rows = 30
config.font = wezterm.font_with_fallback({
  'JetBrains Mono',
  'ヒラギノ角ゴシック',
  'Apple Color Emoji',
})
config.font_size = 18.0
config.use_ime = true

config.window_background_opacity = 0.9
config.macos_window_background_blur = 5

config.window_decorations = "RESIZE"

config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true
config.show_new_tab_button_in_tab_bar = false
config.show_close_tab_button_in_tabs = false

-- ベル音をオフにする
config.audible_bell = "Disabled"

-- 右のOptionキーをショートカットに利用可能にする
config.send_composed_key_when_right_alt_is_pressed = false

-- 矢印キーを無効化する
config.keys = {
  { key = 'LeftArrow', mods = 'NONE', action = wezterm.action.Nop },
  { key = 'RightArrow', mods = 'NONE', action = wezterm.action.Nop },
  { key = 'UpArrow', mods = 'NONE', action = wezterm.action.Nop },
  { key = 'DownArrow', mods = 'NONE', action = wezterm.action.Nop },
  { key = 'LeftArrow', mods = 'OPT', action = wezterm.action.Nop },
  { key = 'RightArrow', mods = 'OPT', action = wezterm.action.Nop },
  { key = 'UpArrow', mods = 'OPT', action = wezterm.action.Nop },
  { key = 'DownArrow', mods = 'OPT', action = wezterm.action.Nop },
  { key = 'LeftArrow', mods = 'CTRL', action = wezterm.action.Nop },
  { key = 'RightArrow', mods = 'CTRL', action = wezterm.action.Nop },
  { key = 'UpArrow', mods = 'CTRL', action = wezterm.action.Nop },
  { key = 'DownArrow', mods = 'CTRL', action = wezterm.action.Nop },
}

-- tabのタイトルに現在のディレクトリ名のみ表示
-- format-tab-titleは速度重視のため内部で同期関数しか呼べず、get_current_working_dir()を呼べないため、pane_idごとにキャッシュしておく
local dir_cache = {}

local function title(pane)
  local cwd_uri = pane:get_current_working_dir()

  local cwd_uri_string = wezterm.to_string(cwd_uri)
  print(cwd_uri_string)
  local cwd = cwd_uri_string:gsub("^file://", "")

  -- cwdがnilになってしまうことがあるので、その場合はキャッシュさせない
  if (not cwd) then
    return nil
  end

  local current_dir = cwd:match("^.*/(.*)/$") or "---"
  print(current_dir)
  return current_dir
end

wezterm.on("update-status", function(window, pane)
  local title = title(pane)
  if (title) then
    local pane_id = pane:pane_id()
    dir_cache[pane_id] = title
  end
end)

wezterm.on('format-tab-title', function(tab, tabs, panes, config, hover, max_width)
  local pane = tab.active_pane
  local pane_id = pane.pane_id

  if dir_cache[pane_id] then
    return {
      -- ショートカットとタブ番号がずれているため揃える
      { Text = ' ' .. tab.tab_index + 1  .. ': ' .. dir_cache[pane_id] .. ' ' },
    }
  else
    return {
      { Text = ' ' .. tab.tab_index + 1  .. ': ' .. tab.active_pane.title .. ' ' },
    }
  end
end)

config.leader = { key = "q", mods = "CTRL", timeout_milliseconds = 2000 }

local color_scheme = 'kanagawa (Gogh)'
config.color_scheme = color_scheme

-- active tabの色をcolor schemeに揃える
local scheme_def = wezterm.color.get_builtin_schemes()[color_scheme]
config.colors = {
  tab_bar = {
    active_tab = {
      bg_color = scheme_def.background,
      fg_color = scheme_def.foreground,
    }
  }
}

return config

