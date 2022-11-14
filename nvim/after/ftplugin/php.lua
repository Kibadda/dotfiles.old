vim.defer_fn(function()
  require("user.utils.options").set {
    tabstop = 4,
    shiftwidth = 4,
    formatoptions = require("user.utils.globals").get("", "formatoptions"),
  }
end, 100)
