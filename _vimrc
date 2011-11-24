"
" Personal preferences .vimrc file
" john shearer <john@ultranaut.com>
"
" Some sources for this mishmash:
"   http://nvie.com/posts/how-i-boosted-my-vim/
"   https://raw.github.com/nvie/vimrc/master/vimrc
"   http://stevelosh.com/blog/2010/09/coming-home-to-vim/
"   http://stackoverflow.com/q/96044/452233

let g:netrw_liststyle=3    " Use tree-mode as default view
let g:netrw_browse_split=4 " Open file in previous buffer
let g:netrw_preview=1      " preview window shown in vertical split

filetype off
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()
filetype plugin indent on

set nocompatible

"   Editor behavior
set autoindent
set backspace=indent,eol,start
set clipboard=unnamed
set copyindent         " copy the previous indentation on autoindenting
set gdefault           " default to global substitutions
set hidden             " hide rather than close buffer on opening new file
set history=1000       " lots of history
set hlsearch           " highlight search terms
set ignorecase         " ignore case when searching (but see smartcase)
set incsearch          " show search matches as you type
set linebreak
set modelines=0        " disable modelines
set nobackup           " turn off auto-backup
set noerrorbells       " no bell, thank you.
set number             " always show line numbers
set relativenumber     " show relative line numbers, ie distance from current line
set ruler              " show the cursor position all the time
set shiftround         " use multiple of shiftwidth when indenting with '<' and '>'
set shiftwidth=2       " number of spaces to use for autoindent
set showmatch          " set show matching parenthesis
set smartcase          " ignore case if search pattern is all lowercase, case-sensitive otherwise
set smarttab           " insert tabs on the start of a line according to shiftwidth, not tabstop
set softtabstop=2      " 
set statusline=Last\ modified:\ \%{strftime(\"\%c\",getftime(expand(\"\%\%\")))}
set tabstop=2          " tabs are 2 spaces wide
set title              " change the terminal's title
set undolevels=1000    " lots of undo
set visualbell         " visual cue instead of bell
set wildignore=*.swp,*.bak
set wrap

" change the mapleader from \ to ,
let mapleader=","

" split windows conveniences
noremap <leader>w <C-w>v<C-w>l
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" re-education
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
"inoremap <up> <nop>
"inoremap <down> <nop>
"inoremap <left> <nop>
"inoremap <right> <nop>
nnoremap j gj
nnoremap k gk

" some better search settings
nnoremap / /\v
vnoremap / /\v
nnoremap <leader><space> :noh<cr>
nnoremap <tab> %
vnoremap <tab> %

" quick save
nnoremap <F2> :w<cr>
inoremap <F2> <C-o>:w<cr>

" Act in haste, repent at leisure
cmap w!! w !sudo tee % >/dev/null

" Shortcut to toggle `set list`
nmap <leader>l :set list!<CR>
" Use the same symbols as TextMate for tabstops and EOLs
set listchars=tab:▸\ ,nbsp:%,eol:¬

" Quickly edit/reload the vimrc file
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>

" Swap default Command-T file open actions
let g:CommandTAcceptSelectionMap = '<C-t>'
let g:CommandTAcceptSelectionTabMap = '<CR>'

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

iab lorem Lorem ipsum dolor sit amet, consectetur adipiscing elit
iab llorem Lorem ipsum dolor sit amet, consectetur adipiscing elit.  Etiam lacus ligula, accumsan id imperdiet rhoncus, dapibus vitae arcu.  Nulla non quam erat, luctus consequat nisi
iab lllorem Lorem ipsum dolor sit amet, consectetur adipiscing elit.  Etiam lacus ligula, accumsan id imperdiet rhoncus, dapibus vitae arcu.  Nulla non quam erat, luctus consequat nisi.  Integer hendrerit lacus sagittis erat fermentum tincidunt.  Cras vel dui neque.  In sagittis commodo luctus.  Mauris non metus dolor, ut suscipit dui.  Aliquam mauris lacus, laoreet et consequat quis, bibendum id ipsum.  Donec gravida, diam id imperdiet cursus, nunc nisl bibendum sapien, eget tempor neque elit in tortor
