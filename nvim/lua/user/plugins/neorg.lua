require('neorg').setup{
  load = {
    ['core.defaults'] = {},
    ['core.norg.dirman'] = {
      config = {
        workspaces = {
          home = "~/notes/home",
        },
      },
    },
    ["core.gtd.base"] = {
      config = {
        workspace = "home",
      },
    },
    ["core.norg.completion"] = {
      config = {
        engine = 'nvim-cmp',
      },
    },
    ["core.norg.concealer"] = {},
    ["core.keybinds"] = {},
    ["core.presenter"] = {},
    ["core.highlights"] = {},
    ["core.norg.qol.toc"] = {},
    ["core.norg.manoeuvre"] = {},
  },
}
