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

set clipboard=unnamed,unnamedplus

set noswapfile

set fileformats=unix

set wildmode=longest:full,full
set wildmenu

if v:version >= 900
  set wildoptions=pum
endif

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
nnoremap Y y$
nnoremap n nzz
nnoremap N Nzz
nnoremap # #zz
nnoremap * *zz

xnoremap y myy`y
xnoremap Y myY`y
xnoremap < <gv
xnoremap > >gv

au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

augroup highlightYankedText
  autocmd!
  autocmd TextYankPost * call FlashYankedText()
augroup END

function! FlashYankedText()
  if (!exists('g:yankedTextMatches'))
    let g:yankedTextMatches = []
  endif

  let matchId = matchadd('Search', ".\\%>'\\[\\_.*\\%<']..")
  let windowId = winnr()

	call add(g:yankedTextMatches, [windowId, matchId])
	call timer_start(200, 'DeleteTemporaryMatch')
endfunction

function! DeleteTemporaryMatch(timerId)
  while !empty(g:yankedTextMatches)
    let match = remove(g:yankedTextMatches, 0)
    let windowID = match[0]
    let matchID = match[1]

    try
      call matchdelete(matchID, windowID)
    endtry
  endwhile
endfunction
