vim.defer_fn(function()
  SetBufferOptions {
    tabstop = 4,
    shiftwidth = 4,
    formatoptions = vim.g.formatoptions,
  }
end, 100)
