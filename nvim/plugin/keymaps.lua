vim.g.mapleader = " "

RegisterKeymaps("<Leader>", {
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

RegisterKeymaps("", {
  Y = { "y$", "Yank till EOF" },
  ["gJ"] = { "<Cmd>SplitjoinJoin<CR>", "Join lines" },
  ["gS"] = { "<Cmd>SplitjoinSplit<CR>", "Split line" },
  -- ["<A-j>"] = ":m .+1<CR>==",
  -- ["<A-k>"] = ":m .-2<CR>==",
})

RegisterKeymaps("", {
  y = { "myy`y", "yank" },
  Y = { "myY`y", "Yank" },
  ["<"] = { "<gv", "dedent" },
  [">"] = { ">gv", "indent" },
  ["<C-r>"] = { '"hy:%s/<C-r>h/', "Replace" },
}, {
  mode = "v",
})

RegisterKeymaps("", {
  ["<S-CR>"] = { "<C-o>o", "New line on bottom" },
  ["<C-CR>"] = { "<C-o>O", "New line on top" },
}, {
  mode = "i",
})
