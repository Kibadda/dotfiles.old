if not PluginsOk "fine-cmdline" then
  return
end

require("fine-cmdline").setup {
  cmdline = {
    prompt = " ",
  },
}

RegisterKeymaps {
  mode = "n",
  prefix = "",
  {
    ["<CR>"] = { "<Cmd>FineCmdline<CR>", "Cmd Line" },
  },
}
