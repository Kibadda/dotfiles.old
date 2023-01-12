require("user.utils.options").set {
  formatoptions = require("user.utils.globals").get("", "formatoptions"),
}

if vim.endswith(vim.fn.fnamemodify(vim.fn.expand "%", ":h"), "plugins") then
  require("user.utils.register").keymaps {
    [{ mode = "n", buffer = 0 }] = {
      g = {
        P = { require("user.utils").open_plugin, "Open Plugin" },
      },
    },
  }
end
