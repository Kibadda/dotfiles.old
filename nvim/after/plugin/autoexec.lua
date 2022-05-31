local function save_and_exec()
  if vim.bo.filetype == "vim" then
    vim.cmd [[
      :silent! write
      :source %
     ]]
  elseif vim.bo.filetype == "lua" then
    vim.cmd [[
      :silent! write
      :luafile %
     ]]
  end
end

vim.keymap.set("n", "<LEADER>x", save_and_exec, { desc = "Save and Execute" })
