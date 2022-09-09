vim.api.nvim_create_autocmd("TermOpen", {
  pattern = "*",
  callback = function()
    SetOptionsLocal {
      filetype = "term",
    }
  end,
})
