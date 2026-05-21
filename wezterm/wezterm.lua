local wezterm = require 'wezterm'
local config = wezterm.config_builder()

-- config.color_scheme = 'Default Dark (base16)'
config.colors = require 'colors.0x96f'
config.font_size = 13
config.harfbuzz_features = { 'calt', 'clig', 'liga' }
config.font = wezterm.font_with_fallback {
  {
    family = 'CaskaydiaCove Nerd Font',
    weight = 'DemiLight',
  },
  {
    family = 'FiraCode Nerd Font',
    harfbuzz_features = { 'zero', 'ss03', 'ss05', 'ss06', 'ss09' },
  },
  {
    family = 'MonaspiceNe Nerd Font',
    harfbuzz_features = { 'ss01', 'ss02', 'ss03', 'ss04', 'ss05', 'ss06', 'ss07', 'ss08', 'ss09', 'ss10' },
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
