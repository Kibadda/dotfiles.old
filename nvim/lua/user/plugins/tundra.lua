local M = {
  "sam4llis/nvim-tundra",
  lazy = false,
}

function M.config()
  require("nvim-tundra").setup {
    overwrite = {
      highlights = {
        ["@constant"] = { fg = "#DE935F", bold = true },
      },
    },
  }

  vim.cmd.colorscheme "tundra"
end

return M
