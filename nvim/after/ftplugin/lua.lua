SetBufferOptions {
  formatoptions = GetFormatOptions(),
}

if vim.fn.fnamemodify(vim.fn.expandcmd "%", ":t") == "plugins.lua" then
  require("user.utils").register_keymaps {
    mode = "n",
    prefix = "",
    buffer = 0,
    {
      gX = {
        function()
          OpenPlugin(true)
        end,
        "Open plugin in Browser",
      },
      gF = {
        function()
          OpenPlugin(false)
        end,
        "Open plugin file",
      },
    },
  }
end
