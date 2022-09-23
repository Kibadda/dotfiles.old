local Popup = require "nui.popup"
local popup = Popup {
  enter = true,
  focusable = true,
  border = {
    style = "rounded",
  },
  position = "50%",
  size = {
    width = "50%",
    height = "50%",
  },
}
popup:mount()
vim.api.nvim_buf_set_lines(popup.bufnr, 0, 1, false, { "Hello World" })
