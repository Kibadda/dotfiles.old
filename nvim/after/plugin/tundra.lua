if not plugins_ok "nvim-tundra" then
  return
end

require("nvim-tundra").setup {
  overwrite = {
    highlights = {
      ["@constant"] = { fg = "#DE935F", bold = true },
    },
  },
}

vim.cmd.colorscheme "tundra"
