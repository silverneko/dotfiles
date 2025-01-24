" :help lightline.txt
let g:lightline = {
      \ 'colorscheme': 'everforest',
      \ 'active': {
      \   'left': [
      \     ['mode', 'paste'],
      \     ['relativepath', 'readonly'],
      \     ['modified'],
      \   ],
      \   'right': [
      \     ['percentwin'],
      \     ['line', 'column'],
      \     ['gitbranch', 'filetype', 'my_fileencoding', 'charhexvalue'] ,
      \   ],
      \ },
      \ 'tabline': {'left': [['tabs']], 'right': []},
      \ 'tab': {'active': ['tabtitle'], 'inactive': ['tabtitle']},
      \ 'component': {
      \   'charhexvalue': '0x%02B',
      \   'modified': '%m',
      \   'line': '%3l/%LL',
      \   'column': '%2vC',
      \ },
      \ 'component_function': {
      \   'gitbranch': 'gitbranch#name',
      \   'my_fileencoding': expand('<SID>') .. 'Fileencoding',
      \ },
      \ 'component_expand': {'tabs': expand('<SID>') .. "LightlineTabs"},
      \ 'tab_component_function': {'tabtitle': expand('<SID>') .. 'TabTitle'},
      \ 'tabline_subseparator': {'left': '', 'right': ''},
      \ }

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
