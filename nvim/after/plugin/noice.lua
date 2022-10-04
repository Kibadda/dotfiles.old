if true or not PluginsOk "noice" then
  return
end

require("noice").setup {
  -- routes = {
  --   {
  --     filter = {
  --       event = "msg_show",
  --       kind = "",
  --       find = "level",
  --     },
  --     opts = {
  --       skip = true,
  --     },
  --   },
  --   {
  --     filter = {
  --       event = "msg_show",
  --       min_height = 10,
  --       ["not"] = { kind = { "search_count", "echo" } },
  --     },
  --     view = "split",
  --   },
  -- },
}
