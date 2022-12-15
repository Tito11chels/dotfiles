-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- GitHub copilot
  use 'github/copilot.vim'

  -- LaTeX support
  use 'vim-latex/vim-latex'

  -- Markdown support
  use 'plasticboy/vim-markdown'

  -- pandoc support
  use 'vim-pandoc/vim-pandoc'

  -- Git support
  use 'tpope/vim-fugitive'
  use 'airblade/vim-gitgutter'

  -- GitHub support
  use 'tpope/vim-rhubarb'

  -- dotfiles editor
  use 'tpope/vim-dotenv'

  -- lua support
  use 'tjdevries/nlua.nvim'
  --- lua lsp
  use 'neovim/nvim-lspconfig'

  -- fzf.vim
  use 'junegunn/fzf.vim'
end)
