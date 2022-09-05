local function ui_input(options, on_confirm)
  local Input = require "nui.input"
  local event = require("nui.utils.autocmd").event
  local input = Input(
    vim.tbl_deep_extend("force", {
      position = "50%",
      size = {
        width = 25,
        height = 3,
      },
      border = {
        style = "double",
        text = {
          top = "[Input]",
          top_align = "center",
        },
      },
      win_options = {
        winhighlight = "Normal:Normal,FloarBorder:Normal",
      },
    }, options.popup_options or {}),
    vim.tbl_deep_extend("force", {
      prompt = "> ",
      on_submit = function(value)
        on_confirm(value)
      end,
    }, options.input_options or {})
  )

  input:mount()

  input:on(event.BufLeave, function()
    input:unmount()
  end)
end

vim.ui.input = ui_input
