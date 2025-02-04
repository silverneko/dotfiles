set completeopt=menuone,noselect,noinsert

" :help vimcomplete.txt
augroup SetVimCompleteOptions | autocmd!
  autocmd VimEnter * call g:VimCompleteOptionsSet(#{
        \ completor:  #{infoPopup: v:false, alwaysOn: v:true, throttleTimeout: 250},
        \ lsp:        #{enable: v:true, priority: 15},
        \ buffer:     #{enable: v:true, priority: 10, dup: v:false},
        \ path:       #{enable: v:true, priority: 5,
        \   groupDirectoriesFirst: v:true, showPathSeparatorAtEnd: v:true},
        \ vimscript:  #{enable: v:true, priority: 5},
        \ })
augroup END

" Vimcomplete would map these for us.
" inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
" inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
let g:vimcomplete_tab_enable = v:true

" <CR> shenanigans. Every plugin wants to map <CR>, yet they can't play nice together.
" See: https://github.com/tpope/vim-endwise/issues/22
"   https://github.com/girishji/vimcomplete/blob/main/README.md#enter-key-handling
let g:endwise_no_mappings = v:true
let g:endwise_no_maps = v:true
let g:vimcomplete_cr_enable = v:false
inoremap <expr> <CR>
      \ "\<Plug>(vimcomplete-skip)"
      \ .. (pumvisible() ? "\<C-Y>" : "\<C-G>u\<CR>")
      \ .. "\<Plug>DiscretionaryEnd"
