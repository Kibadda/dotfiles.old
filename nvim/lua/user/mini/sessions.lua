if not PluginsOk "mini.sessions" then
  return
end

require("mini.sessions").setup {
  hooks = {
    pre = {
      write = function()
        vim.cmd.Neotree { "close" }
      end,
    },
  },
}
