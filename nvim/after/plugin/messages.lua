if not PluginsOk "messages" then
  return
end

require("messages").setup {
  prepare_buffer = function()
    vim.cmd.vsplit()

    local win = vim.api.nvim_get_current_win()
    local buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_win_set_buf(win, buf)

    require("user.utils.register").keymaps {
      mode = "n",
      prefix = "",
      buffer = buf,
      {
        q = { "<Cmd>q<CR>", "Close" },
      },
    }

    return win
  end,
}

function Msg(...)
  require("messages.api").capture_thing(...)
end

require("user.utils.register").keymaps {
  mode = "n",
  prefix = "<Leader>",
  {
    M = { "<Cmd>Messages<CR>", "Messages" },
  },
}
