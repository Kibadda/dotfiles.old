local M = {
  "nvim-neorg/neorg",
  build = ":Neorg sync-parsers",
}

function M.config()
  require("neorg").setup {
    load = {
      ["core.defaults"] = {},
      ["core.norg.dirman"] = {
        config = {
          workspaces = {
            notes = "~/notes",
          },
        },
      },
      ["core.norg.concealer"] = {},
      ["core.norg.completion"] = {
        config = {
          engine = "nvim-cmp",
        },
      },
      ["core.export"] = {},
      ["core.export.markdown"] = {
        config = {
          extensions = "all",
        },
      },
      ["core.presenter"] = {
        config = {
          zen_mode = "zen-mode",
        },
      },
    },
  }
end

return M
