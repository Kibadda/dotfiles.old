if not plugins_ok "noice" then
  return
end

require("noice").setup {
  popupmenu = {
    backend = "cmp",
  },
  lsp = {
    progress = {
      enabled = false,
    },
    override = {
      ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
      ["vim.lsp.util.stylize_markdown"] = true,
      ["cmp.entry.get_documentation"] = true,
    },
    -- FIX: somehow this kills my neovim in intelephense
    -- together with treesitter
    -- without php parser -> no crash
    signature = {
      enabled = false,
    },
  },
  views = {
    cmdline_popup = {
      border = {
        style = "single",
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
