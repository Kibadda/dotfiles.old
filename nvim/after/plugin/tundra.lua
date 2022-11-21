if not plugins_ok "tundra" then
  return
end

require("tundra").setup {}

vim.cmd.colorscheme "tundra"
