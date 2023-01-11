local M = {
  "sam4llis/nvim-tundra",
  lazy = false,
  priority = 1000,
}

function M.init()
  require("user.utils.register").keymaps {
    n = {
      ["<Leader>"] = {
        a = {
          function()
            require("nvim-tundra.commands").toggle_transparency()

            os.execute(
              ("kitty @ --to %s set-background-opactiy"):format(
                vim.env.KITTY_LISTEN_ON,
                vim.g.tundra_opts.transparent_background and 0.9 or 1
              )
            )
          end,
          "Toggle transparent background",
        },
      },
    },
  }
end

function M.config()
  require("nvim-tundra").setup {
    transparent_background = true,
    overwrite = {
      highlights = {
        ["@constant"] = { fg = "#DE935F", bold = true },
      },
    },
  }

  vim.cmd.colorscheme "tundra"
end

return M
