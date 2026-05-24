vim9script
# SPDX-License-Identifier: MIT

# Sets the search pattern register, pushes its value into the search history,
# and then immediately jumps to the `count`-th occurrence.
export def SmartVisualSearch(count: number, search_command: string)
  var visual_mode = mode()
  var temp = @s

  # Grab the highlighted region into a [s]cratchpad register.
  # Also puts us into NORMAL mode.
  silent noa normal! "sy
  var text = @s
  # Restore the "s register
  @s = temp

  # Escaping '?' is tricky.
  # Problem is we don't want '\?' to be added into the search pattern, because
  # '\?' would be interpreted as the ? operator even in very-nomagic mode.
  # Thus we escape it by making it a regex character collection pattern.
  text = text->escape('/\')->substitute('?', '\\[?]', 'g')

  var pattern: string
  if visual_mode ==# 'v'
    # For standard Visual mode: Escape and convert newlines
    pattern = text->substitute('\n', '\\n', 'g')
  else
    # For Line/Block mode: Split lines, strip whitespace, and join with OR
    pattern = text
      ->split('\n')
      ->map((_, line) => trim(line))
      ->filter((_, v) => !empty(v))
      ->join('\|')
  endif

  if empty(pattern)
    echomsg 'SmartVisualSearch: Ignored blank selection'
    return
  endif

  # Very nomagic
  @/ = '\V' .. pattern
  histadd('/', @/)

  # We cannot simply `execute()` "normal! {count}{search_command}\<CR>" here,
  # because v:searchforward would be restored when returning from a function.
  # `feedkeys()` is fine though, because the commands are queued and executed
  # only after the function is returned.
  feedkeys($"{count}{search_command}\<CR>", 'n')
enddef
