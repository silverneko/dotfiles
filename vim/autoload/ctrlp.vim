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

def StartsWith(s: string, prefix: string): bool
  return s->match('^' .. prefix) != -1
enddef

# TODO: Support repo root
export def CtrlP()
  var path = GitRoot()
  if empty(path)
    # Basedir of current file
    path = expand('%:p:h')
    # If base is subdir of cwd AND cwd is not root, then use cwd instead.
    var cwd = getcwd()
    if cwd->len() > 1 && path->StartsWith(cwd)
      path = cwd
    endif
  endif
  fzf#vim#files(path, fzf#vim#with_preview({options: ['--prompt', ShortPath(path)]}))
enddef
