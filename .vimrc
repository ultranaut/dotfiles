"
" Personal preferences .vimrc file
" john shearer <john@ultranaut.com>
"
" Some sources for some of this mishmash:
"   http://nvie.com/posts/how-i-boosted-my-vim/
"   https://raw.github.com/nvie/vimrc/master/vimrc
"   http://stevelosh.com/blog/2010/09/coming-home-to-vim/
"   http://stackoverflow.com/q/96044/452233


" --- first things first ----------------------------------------------
" This must be first, because it changes other options as a side effect.
set nocompatible                  " disable vi-compatibility

" needs to be reset before any mappings that use it
let mapleader=","
let maplocalleader="\\"


" --- vim-plug --------------------------------------------------------
call plug#begin()
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-commentary'
Plug 'mattn/emmet-vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'sheerun/vim-polyglot'
Plug 'dense-analysis/ale'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'morhetz/gruvbox'
Plug 'SirVer/ultisnips'
Plug 'junegunn/goyo.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()


" --- Editor behavior -------------------------------------------------
set backspace=indent,eol,start    " unrestricted backspacing in insert mode
set clipboard=unnamed             " use the * register for yank, delete, etc.
set encoding=utf-8                " show unicode glyphs
set hidden                        " hide buffer on opening new file
set history=1000                  " lots of history
set shortmess+=c                  " Don't pass messages to |ins-completion-menu|.
set nobackup                      " turn off auto-backup
set switchbuf+=usetab,newtab
set undolevels=1000               " lots of undo
set wildignore+=*.swp             " files to ignore in wildmenu, etc
set wildignore+=*.bak
set wildignore+=*.jpg
set wildignore+=*.gif
set wildignore+=*.png
set wildignore+=*.ico
set wildmode+=list:full           " list all matches and complete the first
set wildmode+=full                " complete next full match

set nomodeline                    " disable modeline
set modelines=0                   " same

" quick escape in insert mode, keep cursor in same spot
inoremap jk <Esc>l

" quick save
nnoremap <leader>s :w<cr>
inoremap <leader>s <esc>:w<cr>li

" quick exit
nnoremap <leader>x :x<cr>
inoremap <leader>x <esc>:x<cr>

" yank entire buffer
nnoremap <leader>c :%y+<CR>
inoremap <leader>c <C-o>:%y+<CR>

" Act in haste, repent at leisure
cmap w!! w !sudo tee % >/dev/null

" Quickly edit/reload the vimrc file
nnoremap <silent> <leader>ev :vsplit $MYVIMRC<CR>
nnoremap <silent> <leader>sv :source $MYVIMRC<CR>

" `sort` visual selection
vnoremap <leader>r :sort<cr>'>

" Avoid ending up in Ex mode
nnoremap Q <nop>
nnoremap q: <nop>

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>


" --- UI chrome -------------------------------------------------------
set cursorline                    " highlight line cursor is on
set laststatus=2                  " always display status line
set number                        " always show line numbers
set relativenumber                " use hybrid line numbering
set ruler                         " show the cursor position all the time
set showmatch                     " set show matching parenthesis
set showcmd                       " show current command at bottom of screen
set signcolumn=yes                " always show the signcolumn
set title                         " change the terminal's title
set wildmenu                      " visual autocomplete command line menu

" wrap long lines
set wrap                          " enable soft-wrapping
set linebreak                     " break lines at sensible points

" completely disable error alerts
set noerrorbells                  " no bell on errors
set visualbell                    " disable non-error beeping
set t_vb=                         " disable screen flash

if has('termguicolors')
  set termguicolors               " enable 24-bit color
endif

" Shortcut to toggle `set list`
nnoremap <leader>l :set list!<CR>

" Use the same symbols as TextMate for tabstops and EOLs
set listchars=tab:▸\ ,nbsp:%,eol:¬

" visual indicator at column 72
if exists('+colorcolumn')
  set colorcolumn=72,80
endif

" Change cursor shape between insert and normal mode in iTerm2.app
" https://hamberg.no/erlend/posts/2014-03-09-change-vim-cursor-in-iterm.html
if $TERM_PROGRAM =~ "iTerm"
    let &t_SI = "\<Esc>]50;CursorShape=1\x7" " Vertical bar in insert mode
    let &t_EI = "\<Esc>]50;CursorShape=0\x7" " Block in normal mode
endif

" --- Folding ---------------------------------------------------------
set foldcolumn=4                  " foldcolumn width
set foldmethod=manual             " set fold method


" --- Search ----------------------------------------------------------
set hlsearch           " highlight search terms
set incsearch          " show search matches as you type
set ignorecase         " ignore case when searching (but see smartcase)
set smartcase          " ignore case only if search pattern is all lowercase

" toggle search highlighting
nnoremap <leader><space> :set hlsearch!<cr>

" search and replace word under cursor
nnoremap <leader>fr :%s/<c-r><c-w>//c<left><left>

" search and replace visual selection
vnoremap <leader>fr "hy:%s/<C-r>h//c<left><left>

" vertically center the next/previous search result
nnoremap n nzz
nnoremap N Nzz


" --- Whitespace & indentation ----------------------------------------
set autoindent         " copy indent from current line when starting a new line
set copyindent         " copy the previous indentation on autoindenting
set expandtab          " spaces, not tabs
set tabstop=2          " tab characters are 2 spaces wide
set softtabstop=2      " so are soft tabs
set shiftwidth=2       " number of spaces to use for indentation in normal mode
set smarttab           " insert tabs on the start of a line according to shiftwidth, not tabstop
set shiftround         " use multiple of shiftwidth when indenting with '<' and '>'


" --- splits ----------------------------------------------------------
" move cursor between splits
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" switch horizontal split to vertical and vice versa
nnoremap <leader>v <C-w>t<C-w>H
nnoremap <leader>h <C-w>t<C-w>K


" --- buffers ---------------------------------------------------------
" navigate previous/next
nnoremap <space>h :bp<cr>
nnoremap <space>l :bn<cr>
" list buffers
nnoremap <space>s :ls<cr>
" close current buffer
nnoremap <space>d :bd<cr>


" --- cursor behaviors ------------------------------------------------
" disable arrow keys
nnoremap <up>    <nop>
nnoremap <down>  <nop>
nnoremap <left>  <nop>
nnoremap <right> <nop>
inoremap <up>    <nop>
inoremap <down>  <nop>
inoremap <left>  <nop>
inoremap <right> <nop>

" move cursor by display lines when wrapping
nnoremap j gj
nnoremap k gk

" tob to matching bracket { } [ ] ( )
nnoremap <tab> %
vnoremap <tab> %

" liven up the page scrolling
nnoremap <c-e> 3<c-e>
nnoremap <c-y> 3<c-y>


" --- text manipulation -----------------------------------------------
" move a line up or down
nnoremap _ kddpk
nnoremap - ddp

" retain visual selection when block indenting
vnoremap > >gv
vnoremap < <gv


" --- terminal --------------------------------------------------------
nnoremap <leader>t :vertical below terminal<cr>


" --- sessions --------------------------------------------------------
" create a 'workspace' -- :mksession to create, <F3> to restore
nnoremap <F3> <ESC>:call LoadSession()<CR>
let s:sessionloaded = 0
function LoadSession()
  source Session.vim
  let s:sessionloaded = 1
endfunction
function SaveSession()
  if s:sessionloaded == 1
    mksession!
  end
endfunction
autocmd VimLeave * call SaveSession()

" .mksession options
set ssop+=globals         " save global variables
set ssop-=blank           " don't save empty windows
set ssop-=options         " don't save options and mappings

" ---------------------------------------------------------------------

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
if &t_Co > 2 || has("gui_running")
  syntax on
endif

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
      \ | wincmd p | diffthis
endif

" http://vim.wikia.com/wiki/Remove_unwanted_spaces
:nnoremap <silent> <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>


" Set swap, backup and views directories
" Put them in $HOMEDIR to avoid clutter in working files
" http://spf13.com/post/perfect-vimrc-vim-config-file
function! InitializeDirectories()
  let separator = "."
  let parent = $HOME
  let prefix = '.vim'
  let dir_list = {
              \ 'backup': 'backupdir',
              \ 'views': 'viewdir',
              \ 'swap': 'directory' }

  for [dirname, settingname] in items(dir_list)
      let directory = parent . '/' . prefix . dirname . "/"
      if exists("*mkdir")
          if !isdirectory(directory)
              call mkdir(directory)
          endif
      endif
      if !isdirectory(directory)
          echo "Warning: Unable to create backup directory: " . directory
          echo "Try: mkdir -p " . directory
      else
          let directory = substitute(directory, " ", "\\\\ ", "")
          exec "set " . settingname . "=" . directory
      endif
  endfor
endfunction
call InitializeDirectories()


" --- Filetypes -------------------------------------------------------
" default *.md files to markdown instead of modula2
autocmd BufNewFile,BufReadPost *.md set filetype=markdown

" recognize C# html files as html
autocmd BufNewFile,BufRead *.cshtml set filetype=html


" --- netrw -----------------------------------------------------------
let g:netrw_liststyle=3     " Use tree-mode as default view
let g:netrw_preview=1       " preview window shown in vertical split
let g:netrw_browse_split=3  " Open file in previous buffer
                            "   =0: re-using the same window
                            "   =1: horizontally splitting the window first
                            "   =2: vertically   splitting the window first
                            "   =3: open file in new tab
                            "   =4: act like 'P' (ie. open previous window)


" --- fugitive --------------------------------------------------------
nnoremap <leader>gd  :Gdiffsplit<CR>zR
nnoremap <leader>gst :Git<CR>
nnoremap <leader>ga  :Gwrite<CR>
nnoremap <leader>gc  :G commit<CR>
nnoremap <leader>gp  :G push<CR>


" --- Commentary ------------------------------------------------------
" set nginx comment string
autocmd FileType nginx setl cms=#\ %s


" --- Emmet -----------------------------------------------------------
" redefine trigger key
let g:user_emmet_leader_key=','
" only load Emmet for html and css filetypes
let g:user_emmet_install_global = 0
autocmd FileType html,css,javascript EmmetInstall


" --- fzf -------------------------------------------------------------
nnoremap <leader>ff      :Files<CR>
inoremap <leader>ff <esc>:Files<CR>
nnoremap <leader>fb      :Buffers<CR>
inoremap <leader>fb <esc>:Buffers<CR>
nnoremap <leader>fg      :GFiles<CR>
inoremap <leader>fg <esc>:GFiles<CR>


" --- ALE -------------------------------------------------------------
" Only run linters named in ale_linters settings (in ftplugin files)
let g:ale_linters_explicit = 1

" better navigation between errors
nnoremap <silent> [v :ALEPreviousWrap<cr>
nnoremap <silent> ]v :ALENextWrap<cr>

" run ALEFix
nnoremap <F2> :ALEFix<cr>
inoremap <F2> <C-o>:ALEFix<cr>


" --- gruvbox ---------------------------------------------------------
" disable weird selection highlighting
let g:gruvbox_invert_selection='0'
let g:gruvbox_italic=1
colorscheme gruvbox

" highlight trailing whitespace except when typing in insert mode
" http://vim.wikia.com/wiki/Highlight_unwanted_spaces
"
" Needs to follow colorscheme declaration because gruvbox runs
" `:hi clear` command, nuking any custom highlighting set before it runs
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()


" --- Airline ---------------------------------------------------------
let g:airline_theme='gruvbox'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline_powerline_fonts = 1


" --- UltiSnips -------------------------------------------------------
" default setting of '<tab>' conflicts with CoC
let g:UltiSnipsExpandTrigger="<C-l>"


" --- CoC -------------------------------------------------------------
let g:coc_global_extensions = [
      \ 'coc-tsserver',
      \ 'coc-html',
      \ 'coc-css',
      \ 'coc-json',
      \ 'coc-git',
      \ 'coc-jedi',
      \ 'coc-highlight',
      \ 'coc-snippets', ]

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')
" coc's default hightlight is too subtle, as in I can't see it
highlight link CocHighlightText IncSearch

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}
" Airline integration
let g:airline#extensions#coc#enabled = 0
let airline#extensions#coc#error_symbol = 'Error:'
let airline#extensions#coc#warning_symbol = 'Warning:'
let airline#extensions#coc#stl_format_err = '%E{[%e(#%fe)]}'
let airline#extensions#coc#stl_format_warn = '%W{[%w(#%fw)]}'

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>
