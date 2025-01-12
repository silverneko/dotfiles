local wezterm = require 'wezterm'
local config = wezterm.config_builder()

config.audible_bell = 'Disabled'
config.color_scheme = 'Default Dark (base16)'
config.hide_tab_bar_if_only_one_tab  = true
config.initial_cols = 120
config.initial_rows = 30
config.font_size = 11

return config
