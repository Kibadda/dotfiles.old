vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.v",
  callback = function()
    SetBufferOptions {
      filetype = "vlang",
    }
  end,
})
