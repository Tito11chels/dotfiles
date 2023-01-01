" LaTeX Quickrun
let g:quickrun_config = {
\   'tex': {
\       'command': 'latexmk',
\       'exec': ['%c -gg -pdflua %s', 'open %s:r.pdf']
\   },
\}
nnoremap <silent><C-x>c :QuickRun<CR>