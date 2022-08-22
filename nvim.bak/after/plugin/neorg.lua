if not pcall(require, "neorg") then
  return
end

require("neorg").setup {
  load = {
    ["core.defaults"] = {},
    ["core.norg.concealer"] = {
      config = {
        conceals = true,
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
    ["core.gtd.base"] = {
      config = {
        workspace = "kibadda",
      },
    },
    ["core.presenter"] = {
      config = {
        zen_mode = "zen-mode",
      },
    },
    ["core.norg.completion"] = {
      config = {
        engine = "nvim-cmp",
      },
    },
    ["core.integrations.nvim-cmp"] = {},
    ["core.highlights"] = {},
    ["core.integrations.telescope"] = {},
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

local neorg_callbacks = require "neorg.callbacks"

neorg_callbacks.on_event("core.keybinds.events.enable_keybinds", function(_, keybinds)
  keybinds.map_event_to_mode("norg", {
    n = {
      { "<C-s>", "core.integrations.telescope.find_linkable" },
    },
    i = {
      { "<C-l>", "core.integrations.telescope.insert_link" },
    },
  }, {
    silent = true,
    noremap = true,
  })
end, function(_)
  return true
end)
