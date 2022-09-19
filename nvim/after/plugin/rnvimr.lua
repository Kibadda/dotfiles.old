if not GetGlobal("loaded", "rnvimr") then
  return
end

SetGlobal("rnvimr", {
  vanilla = true,
  enable_ex = true,
  enable_picker = true,
  hide_gitignore = true,
  border_attr = {
    fg = 14,
    bg = -1,
  },
  enable_bw = true,
  ranger_cmd = {
    "ranger",
    "--cmd=set draw_borders both",
  },
})
vim.cmd.highlight "link RnvimrNormal CursorLine"

RegisterKeymaps {
  mode = "n",
  prefix = "<Leader>",
  {
    e = { "<Cmd>RnvimrToggle<CR>", "Browse Files" },
  },
}
