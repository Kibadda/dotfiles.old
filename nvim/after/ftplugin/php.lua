vim.defer_fn(function()
  require("user.utils.options").set {
    tabstop = 4,
    shiftwidth = 4,
    formatoptions = vim.g.formatoptions,
  }
end, 100)
