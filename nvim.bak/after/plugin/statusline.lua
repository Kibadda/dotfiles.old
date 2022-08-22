if not pcall(require, "statusline") then
  return
end

vim.opt.laststatus = 3

require("statusline").setup {}
