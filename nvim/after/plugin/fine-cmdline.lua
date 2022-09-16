if not PluginsOk "fine-cmdline" then
  return
end

require("fine-cmdline").setup {
  cmdline = {
    prompt = " ",
  },
  popup = {
    win_options = {
      winhighlight = "Normal:FloatBorder,FloatBorder:FloatBorder",
    },
  },
}

RegisterKeymaps {
  mode = "n",
  prefix = "",
  {
    ["<CR>"] = { "<Cmd>FineCmdline<CR>", "Cmd Line" },
  },
}
