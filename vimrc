let g:polyglot_disabled = ['autoindent']

" :PlugInstall
call plug#begin('~/.vim/plugged')

Plug 'scrooloose/nerdtree'

Plug 'jistr/vim-nerdtree-tabs'

Plug 'majutsushi/tagbar'

Plug 'fidian/hexmode'

Plug 'tpope/vim-endwise'

Plug 'sheerun/vim-polyglot'

Plug 'vim-scripts/SyntaxComplete'

Plug 'lifepillar/vim-mucomplete'

Plug 'google/vim-searchindex'

Plug 'kshenoy/vim-signature'

Plug 'mhinz/vim-signify'

Plug 'junegunn/fzf'

Plug 'morhetz/gruvbox'

Plug 'itchyny/lightline.vim'

Plug 'itchyny/vim-gitbranch'

Plug 'tpope/vim-repeat'

Plug 'tpope/vim-surround'

call plug#end()

let g:google_vimrc=expand('~/.dotfiles/vimrc.google')
if filereadable(g:google_vimrc)
  exec 'source' g:google_vimrc
endif

syntax enable
filetype plugin indent on

set nocompatible

" Tagbar
let g:tagbar_autofocus = 1

" vim-nerdtree-tabs
let g:nerdtree_tabs_open_on_gui_startup = 0

" mucomplate
let g:mucomplete#enable_auto_at_startup = 1
set completeopt=menuone,noselect
set shortmess+=c
call mucomplete#msg#set_notifications(1)

inoremap <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return pumvisible() ? "\<C-y>" : "\<CR>"
endfunction

" gruvbox
set t_Co=256
set termguicolors
set background=dark
let g:gruvbox_contrast_dark='hard'
let g:gruvbox_invert_tabline=1
let g:gruvbox_italic=0
" colorscheme nolife
colorscheme gruvbox

" lightline
let g:lightline = {
      \ 'colorscheme': 'seoul256',
      \ 'active': {
      \   'left': [
      \     ['mode', 'paste'],
      \     ['relativepath'],
      \   ],
      \   'right': [
      \     ['percentwin'],
      \     ['line', 'column'],
      \     ['modified', 'readonly', 'gitbranch', 'filetype', 'LightlineFileencoding', 'charhexvalue'] ,
      \   ],
      \ },
      \ 'enable': { 'tabline': 0 },
      \ 'component': {
      \   'charhexvalue': '0x%02B',
      \   'modified': '%m',
      \   'line': '%3l/%LL',
      \   'column': '%2vC',
      \ },
      \ 'component_function': {
      \   'gitbranch': 'gitbranch#name',
      \   'LightlineFileencoding': 'LightlineFileencoding',
      \ },
      \ }

function! LightlineFileencoding()
  let enc = &fenc !=# "" ? &fenc : &enc
  return enc == "utf-8" ? "" : enc
endfunction

set noshowmode
set display+=lastline
set cmdheight=1
set laststatus=2
set wildmenu

set ttimeout
augroup NoInsertKeycodes
  autocmd!
  autocmd InsertEnter * set ttimeoutlen=0
  autocmd InsertLeave * set ttimeoutlen=-1 "<--- default value; also try 100 or something
augroup END


set nomodeline
set noerrorbells
set splitbelow
set scrolloff=999
set cursorline
set ruler
set number
set mouse=nv
set guifont=DejaVu\ Sans\ Mono\ 14
set guicursor+=a:blinkon0

set listchars=trail:␣,tab:»\ ,nbsp:¬
set list

set colorcolumn=80
set backspace=indent,eol,start
set history=500      " keep 500 lines of command line history
set showcmd          " display incomplete commands
set incsearch        " do incremental searching
set hlsearch

" Tab things
set tabstop=8        "A tab is 8 spaces
set expandtab        "Always uses spaces instead of tabs
set softtabstop=2    "Insert 2 spaces when tab is pressed
set shiftwidth=2     "An indent is 2 spaces
set shiftround       "Round indent to nearest shiftwidth multiple

" Optional
" C/C++ programming helpers
augroup csrc
  autocmd!
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

augroup CustomFileTypeCommands
  autocmd!
  autocmd BufNewFile,BufRead *.aidl,*.hidl setfiletype java
  autocmd BufNewFile,BufRead *.bp set filetype=javascript
  autocmd BufNewFile,BufRead *.bp set softtabstop=4 shiftwidth=4
  autocmd FileType go set noexpandtab tabstop=2 colorcolumn=100
  autocmd FileType make set noexpandtab preserveindent
  autocmd BufRead * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
augroup END

" :help tmux-integration
if !has('gui_running') && &term =~ '^\(screen\|tmux\|xterm\)'
  " Insert / replace / normal = vertical bar / underline / block, :help termcap-cursor-shape
  let &t_SI = "\e[6 q"
  let &t_SR = "\e[4 q"
  let &t_EI = "\e[2 q"

  " Better mouse support, see  :help 'ttymouse'
  set ttymouse=sgr

  " Enable true colors, see  :help xterm-true-color
  set termguicolors
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

  " Enable bracketed paste mode, see  :help xterm-bracketed-paste
  let &t_BE = "\<Esc>[?2004h"
  let &t_BD = "\<Esc>[?2004l"
  let &t_PS = "\<Esc>[200~"
  let &t_PE = "\<Esc>[201~"

  " Enable focus event tracking, see  :help xterm-focus-event
  "let &t_fe = "\<Esc>[?1004h"
  "let &t_fd = "\<Esc>[?1004l"
  "execute "set <FocusGained>=\<Esc>[I"
  "execute "set <FocusLost>=\<Esc>[O"

  " Enable modified arrow keys, see  :help arrow_modifiers
  execute "silent! set <xUp>=\<Esc>[@;*A"
  execute "silent! set <xDown>=\<Esc>[@;*B"
  execute "silent! set <xRight>=\<Esc>[@;*C"
  execute "silent! set <xLeft>=\<Esc>[@;*D"
endif

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
