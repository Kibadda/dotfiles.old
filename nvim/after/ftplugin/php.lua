vim.defer_fn(function()
  SetBufferOptions {
    tabstop = 4,
    shiftwidth = 4,
    formatoptions = GetFormatOptions(),
  }
end, 100)
