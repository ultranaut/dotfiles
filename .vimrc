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
call plug#end()


" --- Editor behavior -------------------------------------------------
set backspace=indent,eol,start    " unrestricted backspacing in insert mode
set clipboard=unnamed             " use the * register for yank, delete, etc.
set encoding=utf-8                " show unicode glyphs
set hidden                        " hide buffer on opening new file
set history=1000                  " lots of history
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
set title                         " change the terminal's title
set wildmenu                      " visual autocomplete command line menu

" wrap long lines
set wrap                          " enable soft-wrapping
set linebreak                     " break lines at sensible points

" completely disable error alerts
set noerrorbells                  " no bell on errors
set visualbell                    " disable non-error beeping
set t_vb=                         " disable screen flash

" Shortcut to toggle `set list`
nnoremap <leader>l :set list!<CR>

" Use the same symbols as TextMate for tabstops and EOLs
set listchars=tab:▸\ ,nbsp:%,eol:¬

" visual indicator at column 72
if exists('+colorcolumn')
  set colorcolumn=72,80
endif

" highlight trailing whitespace except when typing in insert mode
" http://vim.wikia.com/wiki/Highlight_unwanted_spaces
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()


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


" --- gruvbox ---------------------------------------------------------
colorscheme gruvbox
let g:airline_theme='gruvbox'


" --- Airline ---------------------------------------------------------
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline_powerline_fonts = 1
