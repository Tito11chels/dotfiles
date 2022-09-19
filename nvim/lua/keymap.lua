local keymap = vim.api.nvim_set_keymap

-- Mappings
---jj to escape
keymap('i', 'jj', '<Esc>', {noremap = true})
--- enable copy to system clipboard
keymap('v', '<C-c>', '"+y', {noremap = true})
--- enable paste from system clipboard
keymap('n', '<C-v>', '"+p', {noremap = true})
--- completion brackets
keymap('i', '(', '()<Esc>i', {noremap = true})
