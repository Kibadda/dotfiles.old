if not pcall(require, "searchbox") then
  return
end

require("searchbox").setup {
  defaults = {
    modifier = "plain",
    confirm = "menu",
    show_matches = true,
  },
}

vim.cmd [[highlight FloatBorder guifg=#e0e0e0 guibg=#282c34]]

RegisterKeymaps("n", "", {
  ["/"] = { "<Cmd>SearchBoxIncSearch<CR>", "Search" },
  ["?"] = { "<Cmd>SearchBoxIncSearch reverse=true<CR>", "Search Back" },
  ["\\"] = { "<Cmd>SearchBoxMatchAll title=' Match ' clear_matches=false<CR>", "Search" },
  R = { "<Cmd>SearchBoxReplace<CR>", "Replace" },
})

RegisterKeymaps("x", "", {
  ["/"] = { ":SearchBoxIncSearch visual_mode=true<CR>", "Search" },
  ["\\"] = { ":SearchBoxMatchAll title=' Match ' visual_mode=true clear_matches=false<CR>", "Search" },
  R = { ":SearchBoxReplace visual_mode=true<CR>", "Replace" },
  ["<C-r>"] = { '"hy:SearchBoxReplace -- <C-r>h<CR>', "Replace current word" },
})
