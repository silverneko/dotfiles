vim9script
# SPDX-License-Identifier: MIT
#
# Vim Smart Visual Search
#
# Search text highlighted in visual mode.
#
# Usage: Bind to your preferred key.
# ```
# xmap * <Plug>(smart-visual-search-*)
# xmap # <Plug>(smart-visual-search-#)
# ```
#
# Also supports `{count}*` and `{count}#` to go straight to `count`-th
# occurrence.
#
# Visual mode differences:
#
# * Visual char mode (`v`): Find exact.
# * Visual line/block mode (`V`/`<CTRL-V>`): Logical OR match any of the
#   selected lines. Strip whitespace.

import autoload 'smartvisualsearch.vim'

xnoremap <Plug>(smart-visual-search-*) <ScriptCmd>smartvisualsearch.SmartVisualSearch(v:count1, '/')<CR>
xnoremap <Plug>(smart-visual-search-#) <ScriptCmd>smartvisualsearch.SmartVisualSearch(v:count1, '?')<CR>
