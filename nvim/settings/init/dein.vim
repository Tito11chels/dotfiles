let s:dein_dir = expand('$HOME/.cache/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
"if &compatible
"    set nocompatible               " Be iMproved
"endif
" dein.vimがない場合githubからDL
if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
    execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
endif
" 設定開始
if dein#load_state(s:dein_dir)
    call dein#begin(s:dein_dir)
    " プラグインリスト(toml)
    let g:rc_dir    = expand('$HOME/dotfiles/nvim/settings')
    let s:toml      = g:rc_dir . '/dein.toml'
    let s:lazy_toml = g:rc_dir . '/dein_lazy.toml'
    " tomlのロード
    call dein#load_toml(s:toml,      {'lazy':0})
    call dein#load_toml(s:lazy_toml, {'lazy':1})
    " 設定終了
    call dein#end()
    call dein#save_state()
endif
" Required:
filetype plugin indent on
syntax enable
" 未インストールがあればインストール
if dein#check_install()
    call dein#install()
endif
