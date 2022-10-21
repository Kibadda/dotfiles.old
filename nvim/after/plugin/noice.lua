if not PluginsOk "noice" then
  return
end

require("noice").setup {
  popupmenu = {
    backend = "cmp",
  },
  cmdline = {
    format = {
      IncRename = {
        pattern = "^:%s*IncRename%s+",
        icon = " ",
        conceal = true,
        opts = {
          relative = "cursor",
          size = {
            min_width = 20,
          },
          position = {
            row = -3,
            col = 0,
          },
          buf_options = {
            filetype = "text",
          },
        },
      },
    },
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
