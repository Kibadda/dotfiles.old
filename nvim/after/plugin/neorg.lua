if not pcall(require, "neorg") then
  return
end

require("neorg").setup {
  load = {
    ["core.defaults"] = {},
    ["core.norg.concealer"] = {
      config = {
        conceals = false,
      },
    },
    ["core.norg.dirman"] = {
      config = {
        workspaces = {
          kibadda = "~/kibadda",
        },
      },
    },
    ["core.export"] = {},
  },
}

local parser_configs = require("nvim-treesitter.parsers").get_parser_configs()

parser_configs.norg = {
  install_info = {
    url = "https://github.com/vhyrro/tree-sitter-norg",
    files = { "src/parser.c" },
    branch = "main",
  },
}
