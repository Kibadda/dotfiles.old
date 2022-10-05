if true or not PluginsOk "noice" then
  return
end

require("noice").setup {
  routes = {
    {
      view = "split",
      filter = { event = "msg_show", min_height = 20 },
    },
    {
      filter = { event = "msg_show", find = "level" },
      opts = { skip = true },
    },
  },
}
