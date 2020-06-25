" jump to subject under cursor
nnoremap <buffer> <cr> <c-]>
" jump back to previous position
nnoremap <buffer> <bs> <c-t>

" search forward/backward for options
nnoremap <buffer> o /'\l\{2,\}'<cr>zz
nnoremap <buffer> O ?'\l\{2,\}'<cr>zz

" search forward/backward for subjects
nnoremap <buffer> s /\|\zs\S\+\ze\|<cr>zz
nnoremap <buffer> S ?\|\zs\S\+\ze\|<cr>zz
