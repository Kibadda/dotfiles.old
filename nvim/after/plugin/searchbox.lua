if true or not PluginsOk "searchbox" then
  return
end

require("searchbox").setup {
  defaults = {
    modifier = "plain",
    confirm = "menu",
    show_matches = true,
  },
  popup = {
    win_options = {
      winhighlight = "Normal:FloatBorder,FloatBorder:FloatBorder",
    },
  },
}

require("user.utils").register_keymaps {
  mode = "n",
  prefix = "",
  {
    ["/"] = { "<Cmd>SearchBoxIncSearch<CR>", "Search" },
    ["?"] = { "<Cmd>SearchBoxIncSearch reverse=true<CR>", "Search Back" },
    ["\\"] = { "<Cmd>SearchBoxMatchAll title=' Match ' clear_matches=false<CR>", "Search" },
    R = { "<Cmd>SearchBoxReplace<CR>", "Replace" },
  },
}

require("user.utils").register_keymaps {
  mode = "x",
  prefix = "",
  {
    ["/"] = { ":SearchBoxIncSearch visual_mode=true<CR>", "Search" },
    ["\\"] = { ":SearchBoxMatchAll title=' Match ' visual_mode=true clear_matches=false<CR>", "Search" },
    R = { ":SearchBoxReplace visual_mode=true<CR>", "Replace" },
    ["<C-r>"] = { '"hy:SearchBoxReplace -- <C-r>h<CR>', "Replace current word" },
  },
}
