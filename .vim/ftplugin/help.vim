" https://vim.fandom.com/wiki/Learn_to_use_help

" jump to subject under cursor
nnoremap <buffer> <cr> <c-]>
" jump back to previous position
nnoremap <buffer> <bs> <c-t>

" search forward/backward for subjects
nnoremap <buffer> s /\|\zs\S\+\ze\|<cr>:noh<cr>
nnoremap <buffer> S ?\|\zs\S\+\ze\|<cr>:noh<cr>

" search forward/backward for options
nnoremap <buffer> o /'\l\{2,\}'<cr>:noh<cr>
nnoremap <buffer> O ?'\l\{2,\}'<cr>:noh<cr>
