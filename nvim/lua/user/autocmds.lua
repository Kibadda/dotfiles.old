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
  group = vim.api.nvim_create_augroup("CloseBufferAfterTermClose", { clear = true }),
  pattern = "*",
  callback = function()
    if vim.bo.filetype ~= "TelescopePrompt" then
      vim.cmd.bd { bang = true }
    end
  end,
})

vim.api.nvim_create_autocmd("BufEnter", {
  group = vim.api.nvim_create_augroup("EnterInsertInTerm", { clear = true }),
  pattern = "term://*",
  callback = function()
    vim.cmd.startinsert()
  end,
})

vim.api.nvim_create_autocmd("TermOpen", {
  group = vim.api.nvim_create_augroup("TermFileType", { clear = true }),
  pattern = "*",
  callback = function()
    require("user.utils.options").set {
      filetype = "term",
    }
  end,
})
