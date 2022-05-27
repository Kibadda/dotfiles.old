" open small terminal on the bottom
function! s:small_terminal() abort
  new
  wincmd J
  call nvim_win_set_height(0, 12)
  set winfixheight
  term
endfunction

" open terminal to the side
function! s:side_terminal() abort
  vnew
  wincmd L
  set winfixwidth
  term
endfunction

" open lazygit to the side
function! s:lazygit_terminal() abort
  vnew
  wincmd L
  set winfixwidth
  term lazygit
endfunction

" open ranger to the side
function! s:ranger_terminal() abort
  vnew
  wincmd L
  set winfixwidth
  term ranger
endfunction

nnoremap <LEADER>td :call <SID>small_terminal()<CR>
nnoremap <LEADER>tr :call <SID>side_terminal()<CR>
nnoremap <LEADER>gg :call <SID>lazygit_terminal()<CR>
nnoremap <LEADER>rr :call <SID>ranger_terminal()<CR>
