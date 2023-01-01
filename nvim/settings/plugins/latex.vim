" LaTeX Quickrun
let g:quickrun_config = {}
let g:quickrun_config['lualatex'] = {
\   'tex': {
\       'command': 'latexmk',
\       'exec': ['%c -gg -pdflua %s', 'open %s:r.pdf']
\   },
\}
nnoremap <C-c>l :QuickRun<CR>