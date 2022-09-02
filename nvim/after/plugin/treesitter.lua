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
    "phpdoc",
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

require("nvim-treesitter.parsers").get_parser_configs().smarty = {
  install_info = {
    url = "https://github.com/Kibadda/tree-sitter-smarty",
    files = { "src/parser.c", "src/scanner.cc" },
    branch = "master",
  },
  filetype = "smarty",
}
