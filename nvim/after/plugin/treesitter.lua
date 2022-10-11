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
    "http",
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
  autotag = {
    enable = true,
    filetypes = {
      "html",
      "smarty",
    },
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        ["af"] = { query = "@function.outer", desc = "outer function" },
        ["if"] = { query = "@function.inner", desc = "inner function" },
        ["aa"] = { query = "@parameter.outer", desc = "outer function argument" },
        ["ia"] = { query = "@parameter.inner", desc = "inner function argument" },
      },
      selection_modes = {
        ["@function.outer"] = "V",
        ["@function.inner"] = "V",
      },
    },
    move = {
      enable = true,
      set_jumps = true,
      goto_next_start = {
        ["]a"] = "@parameter.inner",
      },
      goto_next_end = {
        ["]A"] = "@parameter.inner",
      },
      goto_previous_start = {
        ["[a"] = "@parameter.inner",
      },
      goto_previous_end = {
        ["[A"] = "@parameter.inner",
      },
    },
  },
}

require("nvim-treesitter.parsers").get_parser_configs().smarty = {
  install_info = {
    url = "https://github.com/Kibadda/tree-sitter-smarty",
    -- url = "/home/michael/plugins/tree-sitter-smarty",
    files = { "src/parser.c", "src/scanner.cc" },
    branch = "master",
  },
  filetype = "smarty",
}
