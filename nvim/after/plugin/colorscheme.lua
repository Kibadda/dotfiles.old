if not pcall(require, "colorbuddy") then
  return
end

require("colorizer").setup {
  "*",
}
require("colorbuddy").colorscheme "gruvbuddy"

vim.api.nvim_set_hl(0, "BufferLineBackground", { fg = "#80a0ff", bg = "#1e2127" })
vim.api.nvim_set_hl(0, "BufferLineFill", { fg = "#80a0ff", bg = "#1e2127" })
vim.api.nvim_set_hl(0, "BufferLineSeparator", { bg = "#1e2127" })
