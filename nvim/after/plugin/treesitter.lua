if not PluginsOk "nvim-treesitter" then
  return
end

require("nvim-treesitter.configs").setup {
  ensure_installed = {
    "bash",
    "javascript",
    "json",
    "lua",
    "python",
    "typescript",
    "tsx",
    "css",
    "yaml",
    "php",
    "vue",
    "haskell",
    "html",
    "sql",
  },
  highlight = {
    enable = true,
  },
  incremental_selection = {
    enable = true,
  },
  playground = {
    enable = true,
  },
  indent = {
    enable = true,
  },
}
