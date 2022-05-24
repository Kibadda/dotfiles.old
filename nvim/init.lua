-- Highly inspired by https://github.com/tjdevries

require "kibadda.globals"

if require "kibadda.first_load"() then
  return
end

vim.g.mapleader = " "
vim.g.maplocalleader = " "

require "kibadda.disable_builtin"

require "kibadda.lsp"

require "kibadda.telescope.setup"
require "kibadda.telescope.mappings"

-- require "user.plugins"
require "kibadda.plugins"
