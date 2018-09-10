call plug#begin('~/.vim/plugged')

Plug 'scrooloose/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'

Plug 'tpope/vim-endwise'

Plug 'majutsushi/tagbar'

Plug 'sheerun/vim-polyglot'

Plug 'Shougo/neocomplete.vim'

Plug 'fidian/hexmode'

Plug 'google/vim-searchindex'

Plug 'mhinz/vim-signify'

call plug#end()


" Tagbar
let g:tagbar_autofocus = 1

" vim-nerdtree-tabs
let g:nerdtree_tabs_open_on_gui_startup = 0

" neocomplete
" START of neocomplete
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 2

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
  " return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
  return pumvisible() ? "\<C-y>" : "\<CR>"
endfunction

" <TAB>: completion.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ neocomplete#start_manual_complete()
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <expr><S-TAB>  pumvisible() ? "\<C-p>" : "\<S-TAB>"

" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
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


syntax enable
filetype plugin indent on
colorscheme nolife

" Disable the preview (scratch) window
set completeopt=menu,menuone
set splitbelow

set t_Co=256
set nocompatible
set nomodeline
set noerrorbells

set scrolloff=999
set cursorline
set ruler
set number
set mouse=a
set guifont=DejaVu\ Sans\ Mono\ 14
set guicursor+=a:blinkon0

set listchars=trail:␣,tab:»\ ,nbsp:¬
set list

set colorcolumn=81
set backspace=indent,eol,start
set history=500      " keep 500 lines of command line history
set showcmd          " display incomplete commands
set incsearch        " do incremental searching
set hlsearch

" Tab things
set tabstop=8        "A tab is 8 spaces
set expandtab        "Always uses spaces instead of tabs
set softtabstop=2    "Insert 4 spaces when tab is pressed
set shiftwidth=2     "An indent is 4 spaces
set shiftround       "Round indent to nearest shiftwidth multiple

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
autocmd FileType python call SetIndent(4)
autocmd BufNewFile,BufRead *.rb,*.erb,*.tex call SetIndent(2)
autocmd BufNewFile,BufRead *.go,*.tmpl set expandtab
autocmd BufRead * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" Shortcuts
nnoremap <F2> :NERDTreeTabsToggle<CR>
nnoremap <F6> :nohlsearch<CR>
nnoremap <F7> :%y +<CR>
nnoremap <F8> :TagbarToggle<CR>

" Tab navigations
nnoremap <Tab> :tabnext<CR>
nnoremap <S-Tab> :tabprevious<CR>
nnoremap <C-Right> :tabnext<CR>
nnoremap <C-Left> :tabprevious<CR>
nnoremap <silent> <A-Right> :execute 'silent! tabmove ' . (tabpagenr()+1)<CR>
nnoremap <silent> <A-Left> :execute 'silent! tabmove ' . (tabpagenr()-2)<CR>

" http://vim.wikia.com/wiki/Recover_from_accidental_Ctrl-U
inoremap <C-U> <C-G>u<C-U>
inoremap <C-W> <C-G>u<C-W>

" CTRL-C in visual mode to fast copy to system clipboard.
vnoremap <C-C> "+y

" Change directory to current file directory.
command CD cd %:p:h
command LCD lcd %:p:h

set cmdheight=1
set laststatus=2
" %-0{minwid}.{maxwid}{item}
let &statusline = ""
let &stl .= " %<%f"
let &stl .= "%= "
let &stl .= "%(%m %)%(%r %)%(%w %)"
let &stl .= "%(%y %)"
" let &stl .= "%([%{&fileformat}] %)"
let &stl .= " 0x%02B  "
let &stl .= "%l/%LL "
let &stl .= "%4.(%vC%)  "
let &stl .= "%P"

func SetIndent(wid)
  exec "set shiftwidth=".a:wid
  exec "set softtabstop=".a:wid
endfunc
