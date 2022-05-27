if vim.fn.executable "stylua" == 0 then
  return
end

vim.cmd [[
  augroup StyluaAuto
    au!
    autocmd BufWritePre *.lua :lua require("kibadda.stylua").format()
  augroup END
]]
