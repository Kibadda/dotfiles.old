local components = {
  active = {
    {},
    {},
    {},
  },
  inactive = {
    {},
    {},
  },
}

components.active[1][1] = {
  provider = 'vi_mode',
  hl = function()
    return {
      name = require('feline.providers.vi_mode').get_mode_highlight_name(),
      fg = 'fg',
      bg = require('feline.providers.vi_mode').get_mode_color(),
      style = 'bold'
    }
  end,
  opts = {
    padding = 'center',
  },
  left_sep = ' ',
  right_sep = ' ',
  icon = ''
}

require('feline').setup {
  components = components,
}
