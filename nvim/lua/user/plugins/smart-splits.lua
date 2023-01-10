local M = {
  "mrjones2014/smart-splits.nvim",
  keys = {
    "<Leader>t",
    "<C-h>",
    "<C-j>",
    "<C-k>",
    "<C-l>",
  },
}

function M.init()
  require("user.utils.register").keymaps {
    n = {
      ["<Leader>"] = {
        t = {
          function()
            require("smart-splits").start_resize_mode()
          end,
          "Resize Tmux",
        },
      },
      ["<C-h>"] = {
        function()
          require("smart-splits").move_cursor_left()
        end,
        "Tmux: move left",
      },
      ["<C-j>"] = {
        function()
          require("smart-splits").move_cursor_down()
        end,
        "Tmux: move down",
      },
      ["<C-k>"] = {
        function()
          require("smart-splits").move_cursor_up()
        end,
        "Tmux: move up",
      },
      ["<C-l>"] = {
        function()
          require("smart-splits").move_cursor_right()
        end,
        "Tmux: move right",
      },
    },
  }
end

function M.config()
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
end

return M
