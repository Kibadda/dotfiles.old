if not PluginsOk "noice" then
  return
end

require("noice").setup {
  popupmenu = {
    backend = "cmp",
  },
  routes = {
    {
      view = "split",
      filter = { event = "msg_show", min_height = 10 },
    },
    {
      filter = { event = "msg_show", find = "level" },
      opts = { skip = true },
    },
    {
      filter = { event = "msg_show", find = "written" },
      opts = { skip = true },
    },
    {
      filter = { event = "msg_show", find = "L, " },
      opts = { skip = true },
    },
  },
}
