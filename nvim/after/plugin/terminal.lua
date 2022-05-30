function OpenTerminalToBottom()
  vim.cmd [[
    new
    wincmd J
    call nvim_win_set_height(0, 12)
    set winfixheight
    term
  ]]
end

function OpenTerminalToSide()
  vim.cmd [[
    vnew
    wincmd L
    set winfixwidth
    term
  ]]
end

function OpenLazygitToSide()
  vim.cmd [[
    vnew
    wincmd L
    set winfixwidth
    term lazygit
  ]]
end

-- function OpenRangerToSide()
--   vim.cmd [[
--     vnew
--     wincmd L
--     set winfixwidth
--     term ranger
--   ]]
-- end

vim.keymap.set("n", "<LEADER>td", "<CMD>lua OpenTerminalToBottom()<CR>")
vim.keymap.set("n", "<LEADER>tr", "<CMD>lua OpenTerminalToSide()<CR>")
vim.keymap.set("n", "<LEADER>gg", "<CMD>lua OpenLazygitToSide()<CR>")
-- vim.keymap.set("n", "<LEADER>rr", "<CMD>lua OpenRangerToSide()<CR>")
