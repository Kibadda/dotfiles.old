function! s:small_terminal() abort
  new
  wincmd J
  call nvim_win_set_height(0, 12)
  set winfixheight
  term
endfunction

nnoremap <LEADER>st :call <SID>small_terminal()<CR>

function! s:lazygit_terminal() abort
  vnew
  wincmd L
  set winfixwidth
  term lazygit
endfunction

nnoremap <LEADER>gg :call <SID>lazygit_terminal()<CR>

function! s:ranger_terminal() abort
  vnew
  wincmd L
  set winfixwidth
  term ranger
endfunction

nnoremap <LEADER>rr :call <SID>ranger_terminal()<CR>
