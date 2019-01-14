"
" Personal preferences .vimrc file
" john shearer <john@ultranaut.com>
"
" Some sources for some of this mishmash:
"   http://nvie.com/posts/how-i-boosted-my-vim/
"   https://raw.github.com/nvie/vimrc/master/vimrc
"   http://stevelosh.com/blog/2010/09/coming-home-to-vim/
"   http://stackoverflow.com/q/96044/452233

filetype off

" load pathogen from bundle directory
runtime bundle/pathogen/autoload/pathogen.vim
call pathogen#infect('bundle/{}')
call pathogen#helptags()

filetype plugin indent on

set nocompatible       " disable vi-compatibility

"   Editor behavior
set backspace=2        " indent,eol,start
set clipboard=unnamed
set cursorline         " highlight line cursor is on
set encoding=utf-8     " show unicode glyphs
set foldcolumn=4       " foldcolumn width
set foldmethod=manual  " set fold method
set gdefault           " default to global substitutions
set hidden             " hide rather than close buffer on opening new file
set history=1000       " lots of history
set laststatus=2       " display status line
set linebreak
set nobackup           " turn off auto-backup
set number             " always show line numbers
set ruler              " show the cursor position all the time
set showmatch          " set show matching parenthesis
set statusline=%<\"%f\"\ %m%h%r\ [\%{strftime(\"\%m.\%d.\%Y\ \%H\:\%S\",getftime(expand(\"\%\%\")))}]%=%-14.(%l,%c%V%)\ %p%%\ [%L]
set showcmd            " show current command at bottom of screen
set switchbuf+=usetab,newtab
set title              " change the terminal's title
set undolevels=1000    " lots of undo
set wildignore=*.swp,*.bak,*.jpg,*.gif,*.png,*.ico
set wrap               " enable soft-wrapping


" disable modeline
set nomodeline
set modelines=0

" completely disable error alerts
set noerrorbells       " no bell on errors
set visualbell         " disable non-error beeping
set t_vb=              " disable screen flash

" search
set hlsearch           " highlight search terms
set ignorecase         " ignore case when searching (but see smartcase)
set incsearch          " show search matches as you type
set smartcase          " ignore case if search pattern is all lowercase, case-sensitive otherwise

" whitespace and indentation
set autoindent
set copyindent         " copy the previous indentation on autoindenting
set expandtab          " spaces, not tabs
set tabstop=2          " tab characters are 2 spaces wide
set softtabstop=2      " so are soft tabs
set shiftwidth=2       " number of spaces to use for indentation in normal mode
set smarttab           " insert tabs on the start of a line according to shiftwidth, not tabstop
set shiftround         " use multiple of shiftwidth when indenting with '<' and '>'


" change the mapleader from \ to ,
let mapleader=","

" retain visual selection when block indenting
vnoremap > >gv
vnoremap < <gv

" quick escape in insert mode, keep cursor in same spot
inoremap jk <Esc>l

" --- split windows ---------------------------------------------------
" move cursor between windows
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
" switch horizontal split to vertical and vice versa
nnoremap <leader>v <C-w>t<C-w>H
nnoremap <leader>h <C-w>t<C-w>K

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

" --- search settings -------------------------------------------------
nnoremap <leader><space> :noh<cr>

" search directory recursively for word under cursor
map <F4> :execute "vimgrep /" .expand("<cword>") . "/j **" <Bar> cw<CR>
" search and replace visual selection
vnoremap <C-r> "hy:%s/<C-r>h//c<left><left>

" quick save
nnoremap <F2> :w<cr>
inoremap <F2> <C-o>:w<cr>

" quicker save
nnoremap <leader>ss :w<cr>
inoremap <leader>ss <esc>:w<cr>li
"quick exit
nnoremap <leader>x :x<cr>
inoremap <leader>x <esc>:x<cr>

" yank entire buffer
nnoremap <leader>c :%y+<CR>
inoremap <leader>c <C-o>:%y+<CR>

" vertically center the current cursor location
nmap <space> zz

" vertically center the next/previous search result
nmap n nzz
nmap N Nzz

" Act in haste, repent at leisure
cmap w!! w !sudo tee % >/dev/null

" Shortcut to toggle `set list`
nmap <leader>l :set list!<CR>
" Use the same symbols as TextMate for tabstops and EOLs
set listchars=tab:▸\ ,nbsp:%,eol:¬

" Quickly edit/reload the vimrc file
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>


" `sort` visual selection
vnoremap <leader>r :sort<cr>'>

" --- views -----------------------------------------------------------
" load and create automatically
au BufWinLeave ?* mkview
au BufWinEnter ?* silent loadview

" --- sessions --------------------------------------------------------
" create a 'workspace' -- :mksession to create, <F3> to restore
nmap <F3> <ESC>:call LoadSession()<CR>
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
set ssop+=globals         " global variables
set ssop-=blank,buffers   " don't save blank windows or unopen buffers

" ---------------------------------------------------------------------

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
if &t_Co > 2 || has("gui_running")
  syntax on
endif

if &t_Co >= 256 || has("gui_running")
	" solarized options
	set background=dark
	let g:solarized_termcolors=256
	let g:solarized_visibility="normal"
	let g:solarized_contrast="high"
	colorscheme solarized
endif

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

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


" --- Google-style python indentation ---------------------------------
" https://google-styleguide.googlecode.com/svn/trunk/google_python_style.vim
function GetGooglePythonIndent(lnum)

  " Indent inside parens.
  " Align with the open paren unless it is at the end of the line.
  " E.g.
  "   open_paren_not_at_EOL(100,
  "                         (200,
  "                          300),
  "                         400)
  "   open_paren_at_EOL(
  "       100, 200, 300, 400)
  call cursor(a:lnum, 1)
  let [par_line, par_col] = searchpairpos('(\|{\|\[', '', ')\|}\|\]', 'bW',
        \ "line('.') < " . (a:lnum - s:maxoff) . " ? dummy :"
        \ . " synIDattr(synID(line('.'), col('.'), 1), 'name')"
        \ . " =~ '\\(Comment\\|String\\)$'")
  if par_line > 0
    call cursor(par_line, 1)
    if par_col != col("$") - 1
      return par_col
    endif
  endif

  " Delegate the rest to the original function.
  return GetPythonIndent(a:lnum)

endfunction


" --- plugins ---------------------------------------------------------

" netrw settings to make it more nerdtree-ish
let g:netrw_liststyle=3     " Use tree-mode as default view
let g:netrw_preview=1       " preview window shown in vertical split
let g:netrw_browse_split=3  " Open file in previous buffer
                            "   =0: re-using the same window
                            "   =1: horizontally splitting the window first
                            "   =2: vertically   splitting the window first
                            "   =3: open file in new tab
                            "   =4: act like 'P' (ie. open previous window)


" fugitive shortcuts, mostly match cli shortcuts
nnoremap <leader>gd :Gdiff<CR>
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>ga :Gwrite<CR>

" --- CtrlP -----------------------------------------------------------
" Use the CommandT mapping cause I'm used to it
nnoremap <leader>t :CtrlP<CR>
" Swap the default opening actions
let g:ctrlp_prompt_mappings = {
  \ 'AcceptSelection("e")': ['<c-t>'],
  \ 'AcceptSelection("t")': ['<cr>', '<2-LeftMouse>'],
  \ }

" --- Syntastic -------------------------------------------------------
let g:syntastic_check_on_open = 1

" Use eslint if a config file is available, otherwise fallbak to jshint
autocmd FileType javascript
  \ let b:syntastic_checkers = findfile('.eslintrc', '.;') != ''
  \                            ? ['eslint']
  \                            : ['jshint']

" bootstrap generates a lot of these
let g:syntastic_html_tidy_ignore_errors=['trimming empty']


" --- Tabline ---------------------------------------------------------
hi TabLine      ctermfg=Black  ctermbg=Yellow    cterm=NONE
hi TabLineFill  ctermfg=Black  ctermbg=Yellow    cterm=NONE
hi TabLineSel   ctermfg=White  ctermbg=DarkBlue  cterm=NONE


" --- Ack -------------------------------------------------------------
let g:ackprg = 'ag --nogroup --nocolor --column'


" --- Commentary ------------------------------------------------------
" set nginx comment string
autocmd FileType nginx setl cms=#\ %s


" --- incsearch.vim ---------------------------------------------------
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)
