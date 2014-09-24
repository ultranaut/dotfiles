"
" Personal preferences .vimrc file
" john shearer <john@ultranaut.com>
"
" Some sources for this mishmash:
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
set backspace=indent,eol,start
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
set modelines=0        " disable modelines
set nobackup           " turn off auto-backup
set noerrorbells       " no bell, thank you.
set number             " always show line numbers
set ruler              " show the cursor position all the time
set showmatch          " set show matching parenthesis
set statusline=%<\"%f\"\ %m%h%r\ [\%{strftime(\"\%m.\%d.\%Y\ \%H\:\%S\",getftime(expand(\"\%\%\")))}]%=%-14.(%l,%c%V%)\ %p%%\ [%L]
set switchbuf+=usetab,newtab
set title              " change the terminal's title
set undolevels=1000    " lots of undo
set visualbell         " visual cue instead of bell
set wildignore=*.swp,*.bak,*.jpg,*.gif,*.png,*.ico
set wrap               " enable soft-wrapping

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
set softtabstop=2      "
set shiftwidth=2       " number of spaces to use for indentation in normal mode
set smarttab           " insert tabs on the start of a line according to shiftwidth, not tabstop
set shiftround         " use multiple of shiftwidth when indenting with '<' and '>'

" change the mapleader from \ to ,
let mapleader=","

" quick escape in insert mode, keep cursor in same spot
inoremap jk <Esc>l

" netrw settings to make it more nerdtree-ish
let g:netrw_liststyle=3     " Use tree-mode as default view
let g:netrw_preview=1       " preview window shown in vertical split
let g:netrw_browse_split=3  " Open file in previous buffer
                            "   =0: re-using the same window
                            "   =1: horizontally splitting the window first
                            "   =2: vertically   splitting the window first
                            "   =3: open file in new tab
                            "   =4: act like 'P' (ie. open previous window)

" vim-powerline settings
let g:Powerline_symbols='fancy'
" let g:Powerline_theme='solarized256'


" split windows conveniences
noremap <leader>w <C-w>v<C-w>l
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" re-education
nnoremap <up>    <nop>
nnoremap <down>  <nop>
nnoremap <left>  <nop>
nnoremap <right> <nop>
inoremap <up>    <nop>
inoremap <down>  <nop>
inoremap <left>  <nop>
inoremap <right> <nop>

nnoremap j gj
nnoremap k gk

" some better search settings
nnoremap / /\v
vnoremap / /\v

nnoremap <leader><space> :noh<cr>
nnoremap <tab> %
vnoremap <tab> %

" search directory recursively for word under cursor
map <F4> :execute "vimgrep /" .expand("<cword>") . "/j **" <Bar> cw<CR>
" search and replace visual selection
vnoremap <C-r> "hy:%s/<C-r>h//c<left><left>

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

" Color scheme for tabs (tabline.vim)
hi TabLine      ctermfg=Black  ctermbg=Yellow    cterm=NONE
hi TabLineFill  ctermfg=Black  ctermbg=Yellow    cterm=NONE
hi TabLineSel   ctermfg=White  ctermbg=DarkBlue  cterm=NONE

" http://vim.wikia.com/wiki/Remove_unwanted_spaces
:nnoremap <silent> <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>


" Automatically set filetype for specific files or file extensions
autocmd BufNewFile,BufRead composer.lock set filetype=json   " what it says


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


" ------------------------------------------------------------------------------
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


" ------------------------------------------------------------------------------
" Abbreviations
iab rrc http://www.rachaelray.com/
iab lorem Lorem ipsum dolor sit amet, consectetur adipiscing elit etiam lacus ligula accumsan id.
iab llorem Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam lacus ligula, accumsan id imperdiet rhoncus, dapibus vitae arcu. Nulla non quam erat, luctus consequat nisi.
iab lllorem Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam lacus ligula, accumsan id imperdiet rhoncus, dapibus vitae arcu. Nulla non quam erat, luctus consequat nisi. Integer hendrerit lacus sagittis erat fermentum tincidunt. Cras vel dui neque. In sagittis commodo luctus. Mauris non metus dolor, ut suscipit dui. Aliquam mauris lacus, laoreet et consequat quis, bibendum id ipsum. Donec gravida, diam id imperdiet cursus, nunc nisl bibendum sapien, eget tempor neque elit in tortor.

" http://vim.wikia.com/wiki/Multi-line_abbreviations
iab plorem Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque fringilla eros nisi, quis consectetur diam condimentum at. Praesent posuere rhoncus orci, id iaculis est bibendum tristique. Suspendisse a nisi egestas, luctus dui in, rutrum urna. Maecenas laoreet lorem velit, at venenatis metus interdum eu. Nulla tristique libero eu neque aliquam ultrices. Ut metus purus, porttitor in mi eu, tincidunt consequat mi. Aliquam ac fringilla nunc, eget dapibus arcu. Sed non fermentum lorem. Pellentesque viverra augue sapien, eu convallis metus tincidunt ac.
\<CR>
\<CR>Nullam risus felis, commodo varius vehicula eu, volutpat eget dui. Sed imperdiet dolor eu ante accumsan mattis. Etiam viverra libero nibh, in sollicitudin nunc tincidunt non. Integer ultricies quis risus mollis cursus. Donec erat lorem, venenatis vitae lectus ut, ultricies ornare lorem. Integer vel tellus tempor, vestibulum libero eget, rhoncus odio. Donec suscipit risus a nulla pellentesque, ac posuere risus lobortis. Vestibulum ornare faucibus nunc, ut rhoncus urna ullamcorper id. Nunc lorem libero, dictum a purus ac, faucibus vehicula metus. Cras quam sem, convallis a sem porta, ornare egestas lacus. Morbi consectetur, eros et dignissim gravida, urna mi dignissim leo, sit amet malesuada nibh eros vitae magna.
\<CR>
\<CR>Cras lorem nisl, dignissim ac turpis eu, ornare fringilla justo. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Fusce dapibus pellentesque magna, vel feugiat mi pellentesque at. Aliquam in consequat magna. Vestibulum pharetra eros quis iaculis vehicula. Mauris ac pulvinar urna, nec viverra arcu. Mauris mollis at arcu non aliquet. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Cras in erat augue. Sed vel iaculis ligula. Nunc fermentum interdum dui eu scelerisque. Morbi odio ligula, tempus non gravida vitae, dictum a diam.
\<CR>
\<CR>Sed sed cursus leo. Quisque quis hendrerit orci. Etiam congue ante vitae sem viverra interdum. Morbi iaculis leo felis, sed aliquet mauris fermentum eu. Mauris mollis consequat nibh, gravida vestibulum augue egestas ac. Ut bibendum luctus vehicula. Quisque lacinia aliquam odio id viverra. Donec ullamcorper leo non ligula tincidunt aliquam. Quisque vehicula turpis ut neque adipiscing rutrum. Pellentesque eleifend gravida sodales. Pellentesque vitae risus vel ante tempus molestie id sed ante.
\<CR>
\<CR>Suspendisse condimentum diam nunc, rhoncus lacinia sapien sodales a. Nullam tincidunt ultrices erat eu pretium. Morbi porta, sem nec sollicitudin tincidunt, arcu risus tincidunt ligula, a adipiscing sem sem id erat. Sed arcu metus, venenatis id urna vitae, dictum fringilla dolor. Integer in massa diam. Vivamus hendrerit lorem et tortor vehicula vehicula in ut nunc. Nunc eget tristique lectus. Vivamus rutrum rhoncus sem, quis malesuada purus condimentum eget. In hac habitasse platea dictumst. Mauris imperdiet feugiat sem, ac laoreet mi condimentum id. Sed pellentesque mauris diam. Etiam ac sem at mi condimentum interdum suscipit vel tortor. Mauris pellentesque dapibus velit quis feugiat. Mauris ut metus quam. Mauris rhoncus ligula enim, accumsan scelerisque felis eleifend nec. Proin non purus vel lacus interdum tincidunt.

