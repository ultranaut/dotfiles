" USA, USA, USA,...
set spelllang=en_us

" Spell-check Markdown files and Git commit messages
autocmd FileType markdown setlocal spell
autocmd FileType gitcommit setlocal spell

" toggle spell check
nnoremap <leader>sc :setlocal spell!<cr>

" vertically center the next/previous spelling error
nnoremap ]s ]szz
nnoremap [s [szz

" super cool highlighting
hi SpellBad cterm=underline ctermfg=yellow ctermbg=red
hi SpellCap cterm=underline ctermfg=red ctermbg=yellow
hi SpellLocal cterm=underline ctermfg=black ctermbg=green 
