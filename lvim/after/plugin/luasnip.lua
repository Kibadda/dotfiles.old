local ls = require "luasnip"

ls.cleanup()

for _, ft_path in ipairs(vim.api.nvim_get_runtime_file("lua/user/snippets/ft/*.lua", true)) do
  loadfile(ft_path)()
end
