vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("HighlightYank", { clear = true }),
  pattern = "*",
  callback = function()
    vim.highlight.on_yank {
      higroup = "Search",
      timeout = 200,
    }
  end,
})

vim.api.nvim_create_autocmd("BufWritePost", {
  group = vim.api.nvim_create_augroup("SourcePluginFile", { clear = true }),
  pattern = "plugins.lua",
  callback = function()
    vim.cmd.source "<afile>"
  end,
})

vim.api.nvim_create_autocmd("TermClose", {
  group = vim.api.nvim_create_augroup("TermGroup", { clear = true }),
  pattern = "*",
  callback = function()
    vim.cmd.bd { bang = true }
  end,
})
