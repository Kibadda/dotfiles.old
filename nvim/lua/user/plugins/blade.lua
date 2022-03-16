vim.cmd([[
  let g:blade_custom_directives = ['date', 'datetime', 'time', 'datediff', 'currency']

  let g:blade_custom_directives_pairs = {
      \ 'hssp' : 'endhssp',
      \ 'bgm' : 'endbgm',
      \ 'subscribed' : 'endsubscribed',
      \ 'before' : 'endbefore',
      \ 'after' : 'endafter'
  \ }
]])
