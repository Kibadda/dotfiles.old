if not PluginsOk "neorg" then
  return
end

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
  },
}
