vim9script

var is_win = has('win32') || has('win64')

def ShortPath(path: string): string
  var slash = is_win && !&shellslash ? '\' : '/'
  var short = path->fnamemodify(':~:.')->pathshorten()
  if empty(short)
    short = '<?>'
  elseif short[short->len() - 1] != slash
    short ..= slash
  endif
  return short
enddef

def GitRoot(): string
  var dir = split(expand('%:p:h'), '[/\\]\.git\([/\\]\|$\)')[0]
  var root = systemlist('git -C ' .. fzf#shellescape(dir) .. ' rev-parse --show-toplevel')[0]
  return v:shell_error != 0 ? '' : root
enddef

# TODO: Support repo root
export def CtrlP()
  var path = GitRoot() ?? expand('%:p:h')
  # var args = fzf#vim#with_preview({
  #   dir: path,
  #   options: ['-m', '--prompt', ShortPath(path)],
  # })
  # fzf#run(fzf#wrap('ctrlp', args, false))
  var prompt_override = {options: ['--prompt', ShortPath(path)]}
  fzf#vim#files(path, fzf#vim#with_preview(prompt_override))
enddef
