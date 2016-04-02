execute pathogen#infect()
syntax on
filetype plugin indent on

" Tagbar
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
"let g:go_auto_type_info = 1

" START of neocomplete
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
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
" Close popup by <Space>.
inoremap <expr><Space> pumvisible() ? "\<C-y>\<Space>" : "\<Space>"
" <BS>: close popup and delete backword char.
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"

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
let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

" For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'

" END of neocomplete

" neco-ghc
" Disable haskell-vim omnifunc
let g:haskellmode_completion_ghc = 0
let g:necoghc_enable_detailed_browse = 1
autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc

" Haskell things
let g:haskell_enable_quantification = 1
let g:haskell_enable_recursivedo = 1
let g:haskell_enable_arrowsyntax = 1
let g:haskell_enable_pattern_synonyms = 1
let g:haskell_enable_typeroles = 1
let g:haskell_enable_static_pointers = 1

" disable the annoying preview window
set completeopt=menu,menuone

set t_Co=256
set nocompatible
set scrolloff=999
set cursorline
set ruler
set number
" set autochdir
set mouse=a
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
set tabstop=8        "A tab is 8 spaces
set expandtab        "Always uses spaces instead of tabs
set softtabstop=2    "Insert 4 spaces when tab is pressed
set shiftwidth=2     "An indent is 4 spaces
set shiftround       "Round indent to nearest shiftwidth multiple

colorscheme nolife
let g:tex_flavor = 'latex'
let g:markdown_fenced_languages = ['html', 'python', 'bash=sh']
let g:markdown_fenced_languages += ['ruby', 'go', 'c', 'cpp', 'haskell']

" Optional
" C/C++ programming helpers
augroup csrc
  au!
  autocmd FileType *      set nocindent smartindent
  autocmd FileType c,cpp,cuda  set cindent
augroup END
" Set a few indentation parameters. See the VIM help for cinoptions-values for
" details.  These aren't absolute rules; they're just an approximation of
" common style in LLVM source.
set cinoptions=:0,g0,(0,Ws,l1
" Vim tend to a have issues with flagging braces as errors, see for example
" https://github.com/vim-jp/vim-cpp/issues/16. A workaround is to set:
let c_no_curly_error = 1

augroup filetype
  au! BufNewFile,BufRead *Makefile*   set filetype=make
  au! BufNewFile,BufRead *.ll         set filetype=llvm
  au! BufNewFile,BufRead *.td         set filetype=tablegen
  au! BufNewFile,BufRead *.rst        set filetype=rest
  "au! BufNewFile,BufRead *.md         set filetype=markdown
augroup END
autocmd FileType make set noexpandtab
autocmd BufNewFile,BufRead *.rb,*.erb,*.tex call SetIndent(2)
autocmd BufNewFile,BufRead *.go,*.tmpl set expandtab
autocmd BufRead * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

autocmd FileType go map <F3> <Plug>(go-doc)
autocmd FileType go map <F4> :GoLint<CR>
autocmd FileType go map <F5> <Plug>(go-info)
autocmd FileType haskell map <F3> :GhcModCheckAndLint<CR>
autocmd FileType haskell map <F4> :GhcModLint<CR>
autocmd FileType haskell map <F5> :GhcModType<CR>
map <silent> <F2> :NERDTreeTabsToggle<CR>
map <silent> <F6> :call ClearSearchPattern()<CR>
map <silent> <F7> :1,%y+<CR>:echo "Yanked All"<CR>
map <silent> <F8> :TagbarToggle<CR>
map <silent> <F9> :call DefaultCode()<CR>
map <C-Right> :tabnext<CR>
map <C-Left>  :tabprevious<CR>
inoremap <C-U> <C-G>u<C-U>  "can undo ctrl-u
inoremap <c-w> <c-g>u<c-w>

set ch=1  "cmdheigh
set laststatus=2
" %-0{minwid}.{maxwid}{item}
let &statusline = ""
let &stl .= " %<%f"
let &stl .= "%= "
let &stl .= "%(%m %)%(%r %)%(%w %)"
let &stl .= "%(%y %)"
" let &stl .= "%([%{&fileformat}] %)"
let &stl .= "0x%02B  "
let &stl .= "%l/%LL "
let &stl .= "%4.(%vC%)  "
let &stl .= "%P"

func SetIndent(wid)
  "exec "set tabstop=".a:wid
  exec "set shiftwidth=".a:wid
  exec "set softtabstop=".a:wid
endfunc

func ClearSearchPattern()
  if exists('b:did_ftplugin_ghcmod') && b:did_ftplugin_ghcmod
    exec "GhcModTypeClear"
  endif
  let @/ = ""
  echo "Search Pattern Cleared"
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

