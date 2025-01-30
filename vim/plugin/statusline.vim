set noshowmode
set showcmd
set cmdheight=1
set laststatus=2
" Show search count like "[1/5]"
set shortmess-=S
" Don't show completion messages like "match 1 of 2"
set shortmess+=c

" :help lightline.txt
let g:lightline = {
      \ 'colorscheme': 'everforest',
      \ 'active': {
      \   'left': [
      \     ['mode', 'paste'],
      \     ['my_filename'],
      \     ['alternate_name'],
      \   ],
      \   'right': [
      \     ['percentwin'],
      \     ['line_column', 'charhexvalue'],
      \     ['gitbranch', 'lsp_server', 'filetype', 'my_fileencoding'] ,
      \   ],
      \ },
      \ 'tabline': {'left': [['tabs']], 'right': []},
      \ 'tab': {'active': ['tabtitle'], 'inactive': ['tabtitle']},
      \ 'component': {
      \   'charhexvalue': '0x%02B',
      \   'my_filename': '%f%{%&modified||!&modifiable||&readonly?" %m%r":""%}',
      \   'line_column': '%3l/%LL %2vC',
      \ },
      \ 'component_function': {
      \   'gitbranch': 'gitbranch#name',
      \   'my_fileencoding': expand('<SID>') .. 'Fileencoding',
      \   'alternate_name': expand('<SID>') .. 'AltName',
      \   'lsp_server': expand('<SID>') .. 'LspServer',
      \ },
      \ 'component_expand': {'tabs': expand('<SID>') .. "LightlineTabs"},
      \ 'tab_component_function': {'tabtitle': expand('<SID>') .. 'TabTitle'},
      \ 'tabline_subseparator': {'left': '', 'right': ''},
      \ }

function! s:AltName()
  let alt = getbufinfo('#')
  return alt->empty() ? '' :
        \ '[#' .. (alt[0].changed ? '+' : ' ') .. (alt[0].name->fnamemodify(':t') ?? '(No Name)') .. ']'
endfunction

function! s:LspServer()
  let lspserver = lsp#buffer#CurbufGetServer()
  return !lspserver->empty() ? lspserver.name : ''
endfunction

function! s:Fileencoding()
  return substitute(&fenc ?? &enc, '^utf-8$\c', '', '')
endfunction

function! s:TabTitle(n)
  return '[' .. a:n .. '] '
        \ .. lightline#tab#filename(a:n)
        \ .. (lightline#tab#modified(a:n) == '+' ? '*' : '')
endfunction

function! s:LightlineTabs() abort
  let [x, y, z] = [[], [], []]
  let nr = tabpagenr()
  let cnt = tabpagenr('$')
  for i in range(1, cnt)
    call add(i < nr ? x : i == nr ? y : z, (i > nr + 3 ? '%<' : '') . '%' . i . 'T%{lightline#onetab(' . i . ',' . (i == nr) . ')}' . (i == cnt ? '%T' : ''))
  endfor
  return [x, y, z]
endfunction
