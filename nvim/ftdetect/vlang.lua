vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.v",
  callback = function()
    SetOptionsLocal {
      filetype = "vlang",
    }
  end,
})
