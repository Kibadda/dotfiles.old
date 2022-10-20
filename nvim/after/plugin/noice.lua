if true or not PluginsOk "noice" then
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
  views = {
    split = {
      enter = true,
    },
    -- cmdline_popup = {
    --   position = {
    --     row = 10,
    --     col = "50%",
    --   },
    --   size = {
    --     width = 60,
    --     height = "auto",
    --   },
    -- },
    -- popupmenu = {
    --   relative = "editor",
    --   position = {
    --     row = 13,
    --     col = "50%",
    --   },
    --   size = {
    --     width = 60,
    --     height = 10,
    --   },
    --   border = {
    --     style = "rounded",
    --     padding = { 0, 1 },
    --   },
    --   win_options = {
    --     winhighlight = { Normal = "Normal", FloatBorder = "DiagnosticInfo" },
    --   },
    -- },
  },
}
