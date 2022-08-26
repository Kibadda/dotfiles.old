if not pcall(require, "tabline") then
  return
end

vim.opt.showtabline = 2

require("tabline").setup {}
