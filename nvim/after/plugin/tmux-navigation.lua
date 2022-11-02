if true or not PluginsOk "nvim-tmux-navigation" then
  return
end

local ntn = require "nvim-tmux-navigation"

ntn.setup {
  disable_when_zoomed = true,
}

require("user.utils.register").keymaps {
  mode = "n",
  prefix = "",
  {
    ["<C-h>"] = { ntn.NvimTmuxNavigateLeft, "Tmux: move left" },
    ["<C-j>"] = { ntn.NvimTmuxNavigateDown, "Tmux: move down" },
    ["<C-k>"] = { ntn.NvimTmuxNavigateUp, "Tmux: move up" },
    ["<C-l>"] = { ntn.NvimTmuxNavigateRight, "Tmux: move right" },
  },
}

local function tmux_command(command)
  local tmux_socket = vim.fn.split(vim.env.TMUX, ",")[1]
  return vim.fn.system(("tmux -S %s %s"):format(tmux_socket, command))
end

require("user.utils.register").keymaps {
  mode = "n",
  prefix = "<Leader>",
  {
    t = {
      name = "Tmux",
      h = {
        function()
          tmux_command "split-window -h"
        end,
        "Split Horizontal",
      },
      v = {
        function()
          tmux_command "split-window -v"
        end,
        "Split Vertical",
      },
      c = {
        function()
          tmux_command "new-window"
        end,
        "New Window",
      },
    },
  },
}
