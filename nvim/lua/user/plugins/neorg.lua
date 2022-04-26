require('neorg').setup{
  load = {
    ['core.defaults'] = {},
    ['core.norg.dirman'] = {
      config = {
        workspaces = {
          home = '~/notes/home',
          work = '~/notes/work',
        },
      },
    },
    ['core.gtd.base'] = {
      config = {
        workspace = 'work',
      },
    },
    ['core.norg.completion'] = {
      config = {
        engine = 'nvim-cmp',
      },
    },
    ['core.norg.concealer'] = {},
    ['core.keybinds'] = {},
    ['core.presenter'] = {},
    ['core.highlights'] = {},
    ['core.norg.qol.toc'] = {},
    ['core.norg.manoeuvre'] = {},
  },
}
