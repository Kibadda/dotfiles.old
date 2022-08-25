vim.g.mapleader = " "

RegisterKeymaps("n", "<Leader>", {
  p = {
    name = "Packer",
    s = { "<Cmd>PackerSync<CR>", "Sync" },
    S = { "<Cmd>PackerStatus<CR>", "Status" },
    i = { "<Cmd>PackerInstall<CR>", "Install" },
    u = { "<Cmd>PackerUpdate<CR>", "Update" },
    C = { "<Cmd>PackerClean<CR>", "Clean" },
    c = { "<Cmd>PackerCompile<CR>", "Compile" },
  },
  h = { "<Cmd>nohlsearch<CR>", "Remove highlight" },
})

RegisterKeymaps("n", "", {
  Y = { "y$", "Yank till EOL" },
  ["gJ"] = { "<Cmd>SplitjoinJoin<CR>", "Join lines" },
  ["gS"] = { "<Cmd>SplitjoinSplit<CR>", "Split line" },
  ["<C-q>"] = { "<Plug>(qf_qf_toggle_stay)", "QF: toggle" },
  ["<C-Up>"] = { "<Plug>(qf_qf_previous)", "QF: prev" },
  ["<C-Down>"] = { "<Plug>(qf_qf_next)", "QF: next" },
})

RegisterKeymaps("v", "", {
  y = { "myy`y", "yank" },
  Y = { "myY`y", "Yank" },
  ["<"] = { "<gv", "dedent" },
  [">"] = { ">gv", "indent" },
  ["<C-r>"] = { '"hy:%s/<C-r>h/', "Replace" },
})

RegisterKeymaps("i", "", {
  ["<S-CR>"] = { "<C-o>o", "New line on bottom" },
  ["<C-CR>"] = { "<C-o>O", "New line on top" },
})
