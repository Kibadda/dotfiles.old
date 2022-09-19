if not PluginsOk "colorbuddy" then
  return
end

require("colorbuddy").colorscheme "gruvbuddy"

vim.api.nvim_set_hl(0, "BufferLineBackground", { fg = "#80a0ff", bg = "#1e2127" })
vim.api.nvim_set_hl(0, "BufferLineDuplicate", { fg = "#e0e0e0", bg = "#1e2127" })
vim.api.nvim_set_hl(0, "BufferLineFill", { fg = "#80a0ff", bg = "#1e2127" })
vim.api.nvim_set_hl(0, "BufferLineSeparator", { bg = "#1e2127" })
vim.api.nvim_set_hl(0, "BufferLineModified", { fg = "#ffa0a0", bg = "#1e2127" })
vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#e0e0e0", bg = "#111317" })
