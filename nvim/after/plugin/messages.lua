if not PluginsOk "messages" then
  return
end

require("messages").setup {
  prepare_buffer = function(opts)
    vim.cmd.split()

    local win = vim.api.nvim_get_current_win()
    local buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_win_set_height(win, opts.height)
    vim.api.nvim_win_set_buf(win, buf)

    RegisterKeymaps {
      mode = "n",
      prefix = "",
      buffer = buf,
      {
        q = { "<Cmd>q<CR>", "Close" },
      },
    }

    return win
  end,
  buffer_opts = function(lines)
    local gheight = vim.api.nvim_list_uis()[1].height
    return {
      height = math.floor(require("messages.utils").clip_val(1, #lines, gheight * 0.5)),
    }
  end,
}

function Msg(...)
  require("messages.api").capture_thing(...)
end

RegisterKeymaps {
  mode = "n",
  prefix = "<Leader>",
  {
    M = { "<Cmd>Messages<CR>", "Messages" },
  },
}
