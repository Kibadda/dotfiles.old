local M = {
  "echasnovski/mini.starter",
  dependencies = {
    {
      "Kibadda/projectodo.nvim",
      dependencies = {
        "nvim-treesitter/nvim-treesitter",
      },
      dev = true,
    },
  },
  lazy = false,
  priority = 999,
}

function M.init()
  vim.api.nvim_create_autocmd("User", {
    group = vim.api.nvim_create_augroup("MiniStarterKeymaps", { clear = true }),
    pattern = "MiniStarterOpened",
    callback = function(args)
      vim.opt_local.statuscolumn = nil
      vim.opt_local.winbar = nil
      require("user.utils.register").keymaps {
        [{ mode = "n", buffer = args.buf }] = {
          ["<C-j>"] = {
            function()
              require("mini.starter").update_current_item "next"
            end,
            "Move down",
          },
          ["<C-k>"] = {
            function()
              require("mini.starter").update_current_item "prev"
            end,
            "Move down",
          },
        },
      }
    end,
  })
end

function M.config()
  local sections = require("projectodo").get_sections {
    plugin = "mini-starter",
    main_section = {
      name = "Dotfiles",
      sessions = { "dotfiles", "notes", "advent-of-code" },
    },
  }

  table.insert(sections, 1, function()
    return {
      {
        name = "Quit",
        action = "q",
        section = "",
      },
      {
        name = "Edit New Buffer",
        action = "enew",
        section = "",
      },
    }
  end)

  require("mini.starter").setup {
    header = table.concat({
      "┌───────────────────────────────────────────────────────┐",
      "│                                                       │",
      "│  ██┐  ██┐██┐██████┐  █████┐ ██████┐ ██████┐  █████┐   │",
      "│  ██│ ██┌┘██│██┌──██┐██┌──██┐██┌──██┐██┌──██┐██┌──██┐  │",
      "│  █████┌┘ ██│██████┌┘███████│██│  ██│██│  ██│███████│  │",
      "│  ██┌─██┐ ██│██┌──██┐██┌──██│██│  ██│██│  ██│██┌──██│  │",
      "│  ██│ └██┐██│██████┌┘██│  ██│██████┌┘██████┌┘██│  ██│  │",
      "│  └─┘  └─┘└─┘└─────┘ └─┘  └─┘└─────┘ └─────┘ └─┘  └─┘  │",
      "│                                                       │",
      "└───────────────────────────────────────────────────────┘",
    }, "\n"),
    items = sections,
    footer = "",
  }

  local colors = require "nvim-tundra.palette.arctic"
  vim.cmd.highlight("MiniStarterHeader guifg=" .. colors.red._600)
  vim.cmd.highlight("MiniStarterSection guifg=" .. colors.green._600)
end

return M
