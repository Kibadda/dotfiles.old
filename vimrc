set number
set relativenumber

set ignorecase
set smartcase

set scrolloff=8
set cursorline

set tabstop=2
set shiftwidth=2
set softtabstop=2

set breakindent
set wrap
set showbreak=+++\ 
set linebreak

set clipboard=unnamedplus

set noswapfile

set fileformats=unix

set wildmode=longest:full,full
set wildoptions=pum
set wildmenu

let g:currentmode={
  \ '__'     : '- ',
  \ 'c'      : 'COMMAND',
  \ 'i'      : 'INSERT',
  \ 'ic'     : 'INSERT',
  \ 'ix'     : 'INSERT',
  \ 'n'      : 'NORMAL',
  \ 'multi'  : 'M ',
  \ 'ni'     : 'NORMAL',
  \ 'no'     : 'NORMAL',
  \ 'R'      : 'REPLACE',
  \ 'Rv'     : 'REPLACE',
  \ 's'      : 'SELECT',
  \ 'S'      : 'SELECT',
  \ ''     : 'SELECT',
  \ 't'      : 'TERM',
  \ 'v'      : 'VISUAL',
  \ 'V'      : 'VISUAL',
  \ ''     : 'VISUAL',
  \}

set laststatus=2
set statusline=[%{g:currentmode[mode()]}][%{fnamemodify(expand('%'),':.')}]%=[%{&filetype}][%{getcurpos(0)[1]}:%{getcurpos(0)[2]}][%{getcurpos(0)[1]*100/len(getbufline(bufname(),1,'$'))}%%]

syntax on

nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <C-h> <C-w>h

au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
