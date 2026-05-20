local wezterm = require 'wezterm'
local config = wezterm.config_builder()

-- config.color_scheme = 'Default Dark (base16)'
config.colors = require 'colors.0x96f'
config.font_size = 13
config.font = wezterm.font_with_fallback {
  {
    family = 'CaskaydiaCove Nerd Font',
  },
  {
    family = 'FiraCode Nerd Font',
    harfbuzz_features = { 'calt=1', 'clig=1', 'liga=1', 'cv11=1', 'ss05=1', 'ss09=1' },
  },
}

config.force_reverse_video_cursor = true
config.initial_cols = 120
config.initial_rows = 30

config.audible_bell = 'Disabled'
config.hide_tab_bar_if_only_one_tab  = true

-- config.front_end = "WebGpu"
config.enable_wayland = false
--local gpus = wezterm.gui.enumerate_gpus()
--config.webgpu_preferred_adapter = gpus[1]

config.mouse_bindings = {
  {
    event = { Down = { streak = 3, button = 'Left' } },
    action = wezterm.action.SelectTextAtMouseCursor 'SemanticZone',
    mods = 'NONE',
  },
}

return config
