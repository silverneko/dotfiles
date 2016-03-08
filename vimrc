execute pathogen#infect()
syntax on
filetype plugin indent on

" Tabbar
let g:tagbar_autofocus = 1
" vim-nerdtree-tabs
let g:nerdtree_tabs_open_on_gui_startup = 0

" vim-go
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_interfaces = 1
"let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_fmt_autosave = 0

" neocomplete
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
        \ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? "\<C-y>" : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
" Close popup by <Space>.
"inoremap <expr><Space> pumvisible() ? "\<C-y>" : "\<Space>"

" AutoComplPop like behavior.
"let g:neocomplete#enable_auto_select = 1

" Shell like behavior(not recommended).
"set completeopt+=longest
"let g:neocomplete#enable_auto_select = 1
"let g:neocomplete#disable_auto_complete = 1
"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
"let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
"let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
"let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

" For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'

" end of neocomplete

" Supertab
"let g:SuperTabDefaultCompletionType = "context"
"let g:SuperTabContextDefaultCompletionType = "<c-p>"
"set completeopt=menu,preview,longest
"let g:SuperTabLongestEnhanced = 1
"let g:SuperTabLongestHighlight = 1

set t_Co=256
set nocompatible
set scrolloff=1
set cursorline
set ruler
set number
set autochdir
set mouse=a
set cindent
set guifont=DejaVu\ Sans\ Mono\ 14
set guicursor+=a:blinkon0
set listchars=trail:␣,tab:»\              ",eol:↲
set list

set backspace=indent,eol,start
set history=50       " keep 50 lines of command line history
set showcmd          " display incomplete commands
set incsearch        " do incremental searching
set hlsearch

" Tab things
set tabstop=8                   "A tab is 8 spaces
set expandtab                   "Always uses spaces instead of tabs
set softtabstop=2               "Insert 4 spaces when tab is pressed
set shiftwidth=2                "An indent is 4 spaces
set shiftround                  "Round indent to nearest shiftwidth multiple

let b:Compiler = 'nil'
let g:tex_flavor = 'latex'
autocmd BufNewFile,BufRead * let b:Compiler = 'nil' | colorscheme nolife
autocmd BufNewFile,BufRead *.c,*.cpp let b:Compiler = 'clang'
autocmd BufNewFile,BufRead *.hs let b:Compiler = 'GHCi'
autocmd BufNewFile,BufRead *.tex let b:Compiler = 'viewpdf'
autocmd BufNewFile,BufRead *.rb,*.erb,*.tex call SetIndent(2)
autocmd BufNewFile,BufRead makefile set noexpandtab
autocmd BufNewFile,BufRead *.md set filetype=markdown
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

com Compile call COMPILE()
map <silent> <F3> :call SwitchCompiler()<CR>
map <silent> <F4> :call COMPILE()<CR>
map <silent> <F5> :NERDTreeTabsToggle<CR>
map <silent> <F6> :let @/ = ""<CR>:echo "Search Pattern Cleared"<CR>
map <silent> <F7> :1,%y+<CR>:echo "Yanked All"<CR>
map <silent> <F8> :TagbarToggle<CR>
map <silent> <F9> :call DefaultCode()<CR>
map <C-Right> :tabnext<CR>
map <C-Left>  :tabprevious<CR>
inoremap <C-U> <C-G>u<C-U>  "can undo ctrl-u
inoremap <c-w> <c-g>u<c-w>

set ch=1  "cmdheigh
set laststatus=2
set statusline=%<
set statusline+=%-20.f
set statusline+=%=
set statusline+=%0.(\ %r%w%)
set statusline+=%5.5(\ %m\ %)
set statusline+=%-12.y
set statusline+=%-10.{ShowCompiler()}
set statusline+=%(0x%02B%)%(\ \ %)
set statusline+=%10.(%l/%LL%)%(\ \ %)
set statusline+=%-4.(%vC%)%(\ \ %)
set statusline+=%P

func SetIndent(wid)
  exec "set tabstop=".a:wid
  exec "set shiftwidth=".a:wid
  exec "set softtabstop=".a:wid
endfunc

func SwitchCompiler()
  if b:Compiler == 'clang'
    echo "compiler collection : gcc"
    let b:Compiler = 'gcc'
  elseif b:Compiler == 'gcc'
    echo "compiler collection : clang"
    let b:Compiler = 'clang'
  endif
  if b:Compiler == 'GHCi'
    let b:Compiler = 'ghc'
    echo "compiler : Glasgow Haskell Compiler"
  elseif b:Compiler == 'ghc'
    let b:Compiler = 'GHCi'
    echo "compiler : runhaskell"
  endif
  if b:Compiler == 'viewpdf'
    let b:Compiler = 'xelatex'
    echo "compiler : xelatex"
  elseif b:Compiler == 'xelatex'
    let b:Compiler = 'viewpdf'
    echo "compiler : xelatex-evince"
  endif
endfunc

func ShowCompiler()
  if exists("b:Compiler") == 0
    let b:Compiler = 'nil'
  endif
  if b:Compiler == 'nil'
    return ' '
  else
    return '['.b:Compiler.']'
  endif
endfunc

func COMPILE()
  exec "w"
  if &filetype == 'c'
    if b:Compiler == 'gcc'
      exec "!gcc % -Wall -o %< -std=c99 -fno-builtin -O1 -lm"
    else
      exec "!clang % -Wall -o %< -std=c99 -fno-builtin -O1 -lm"
    endif
  elseif &filetype == 'cpp'
    if b:Compiler == 'gcc'
      exec "!g++ % -Wall -o %< -std=c++11"
    else
      exec "!clang++ % -Wall -o %< -std=c++11"
    endif
  elseif &filetype == 'haskell'
    if b:Compiler == 'GHCi'
      exec "!ghci %"
    else
      exec "!ghc % -o %< -threaded -O"
    endif
  elseif &filetype == 'tex'
    exec "!xelatex -synctex=1 -file-line-error -interaction=errorstopmode %"
    if b:Compiler == 'viewpdf'
      exec "silent !evince %<.pdf &"
    endif
  endif
endfunc

func DefaultCode()
  if &filetype == 'c'
    exec ":0r ~/.vim/default_code/default.c"
  elseif &filetype == 'cpp'
    exec ":0r ~/.vim/default_code/default.cpp"
  elseif &filetype == 'haskell'
    exec ":0r ~/.vim/default_code/default.hs"
  elseif &filetype == 'make'
    exec ":0r ~/.vim/default_code/default.makefile"
  elseif &filetype == 'tex'
    exec ":0r ~/.vim/default_code/default.tex"
  endif
endfunc

