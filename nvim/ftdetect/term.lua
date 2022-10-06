vim.api.nvim_create_autocmd("TermOpen", {
  pattern = "*",
  callback = function()
    SetBufferOptions {
      filetype = "term",
    }
  end,
})
