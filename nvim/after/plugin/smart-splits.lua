if not PluginsOk "smart-splits" then
  return
end

require("smart-splits").setup {
  resize_mode = {
    silent = true,
    hooks = {
      on_enter = function()
        vim.notify("Entering resize mode", nil, { title = "Tmux" })
      end,
      on_leave = function()
        vim.notify("Leaving resize mode", nil, { title = "Tmux" })
      end,
    },
  },
}

require("user.utils.register").keymaps {
  mode = "n",
  prefix = "",
  {
    ["<C-h>"] = { require("smart-splits").move_cursor_left, "Tmux: move left" },
    ["<C-j>"] = { require("smart-splits").move_cursor_down, "Tmux: move down" },
    ["<C-k>"] = { require("smart-splits").move_cursor_up, "Tmux: move up" },
    ["<C-l>"] = { require("smart-splits").move_cursor_right, "Tmux: move right" },
  },
}

require("user.utils.register").keymaps {
  mode = "n",
  prefix = "<Leader>",
  {
    t = {
      name = "Tmux",
      r = { require("smart-splits").start_resize_mode, "resize mode" },
    },
  },
}
