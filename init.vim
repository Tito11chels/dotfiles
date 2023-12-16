set encoding=utf-8
set number
set expandtab
set smartindent
set shiftwidth=2
set softtabstop=2
set autochdir
set encoding=utf-8
syntax enable
set matchpairs+=（:）,「:」,『:』,【:】,［:］,＜:＞

set foldmethod=marker
set foldmarker='!>>>','<<<!'

" set jj to <Esc>
inoremap jj <Esc><silent>
" set cursor move while insert mode
inoremap <C-h> <Left>
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-l> <Right>
" set window move

call plug#begin()
Plug 'itchyny/lightline.vim'
Plug 'olimorris/onedarkpro.nvim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'lambdalisue/fern.vim'
Plug 'lambdalisue/nerdfont.vim'
Plug 'lambdalisue/glyph-palette.vim'
Plug 'thinca/vim-quickrun'
Plug 'github/copilot.vim'
" git
Plug 'akinsho/toggleterm.nvim'
Plug 'jesseduffield/lazygit'
" latex
Plug 'lervag/vimtex'
call plug#end()

" ui
colorscheme onedark

" coc.nvim
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()
""" <Tab>で次、<S+Tab>で前
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" LaTeX
let g:quickrun_config={
      \'tex':{
      \ 'command': 'latexmk',
      \'exec': ['-gg','-pdflua','%s', 'open %s:r.pdf']
      \},
      \}

" Fern
nnoremap <C-n> :Fern . -reveal=% -drawer -toggle -width=40<CR>
let g:fern#renderer = 'nerdfont'
let g:fern#default_hidden=1
