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
