vim9script

# :help lsp.txt yegappan/lsp
augroup LspConfig | autocmd!
  autocmd User LspSetup g:LspOptionsSet(lsp_options)
  autocmd User LspSetup g:LspAddServer(lsp_servers)
  autocmd User LspAttached LspAttached()
augroup END

var lsp_options = {
  autoHighlightDiags: true,
  # showDiagInBalloon: true,
  showDiagWithVirtualText: true,
  semanticHighlight: true,
  showInlayHints: true,
  hoverInPreview: true,
}

var lsp_servers = [{
  name: 'rust-analyzer',
  filetype: ['rust'],
  path: exepath('rust-analyzer'),
  args: [],
  syncInit: true,
}]

def LspAttached()
  # <Shift-K> to lookup *K*eyword
  # :pclose to clone the *p*review window
  setlocal keywordprg=:LspHover
  # Jump around with <C-]>
  setlocal tagfunc=lsp#lsp#TagFunc
  # Format with gq{motion} {visual}gq
  setlocal formatexpr=lsp#lsp#FormatExpr()

  nnoremap <buffer> gd <Cmd>execute v:count .. 'LspGotoDefinition'<CR>
  nnoremap <buffer> gD <Cmd>execute v:count .. 'LspGotoDeclaration'<CR>
  nnoremap <buffer> gi <Cmd>execute v:count .. 'LspGotoImpl'<CR>
  nnoremap <buffer> gt <Cmd>execute v:count .. 'LspGotoTypeDef'<CR>
  nnoremap <buffer> gr :LspShowReferences<CR>
  nnoremap <buffer> ]d :LspDiagNextWrap<CR>
  nnoremap <buffer> [d :LspDiagPrevWrap<CR>
  nnoremap <buffer> ]D :LspDiagShow<CR>
enddef
