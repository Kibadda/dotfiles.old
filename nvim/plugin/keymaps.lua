SetGlobal("", {
  mapleader = " ",
})

RegisterKeymaps {
  mode = "n",
  prefix = "<Leader>",
  {
    p = {
      name = "Packer",
      s = { "<Cmd>PackerSync<CR>", "Sync" },
      S = { "<Cmd>PackerStatus<CR>", "Status" },
      i = { "<Cmd>PackerInstall<CR>", "Install" },
      u = { "<Cmd>PackerUpdate<CR>", "Update" },
      C = { "<Cmd>PackerClean<CR>", "Clean" },
      c = { "<Cmd>PackerCompile<CR>", "Compile" },
    },
    h = { "<Cmd>SearchBoxClear<CR>", "Remove highlight" },
    Q = { "<Cmd>DetachTmux<CR>", "Detach" },
  },
}

RegisterKeymaps {
  mode = "n",
  prefix = "",
  {
    Y = { "Yank till EOL" },
    ["gJ"] = { "Join lines" },
    ["gS"] = { "Split line" },
    ["<C-q>"] = { "<Plug>(qf_qf_toggle_stay)", "QF: toggle" },
    ["<C-Up>"] = { "<Plug>(qf_qf_previous)", "QF: prev" },
    ["<C-Down>"] = { "<Plug>(qf_qf_next)", "QF: next" },
    p = { "Paste" },
    P = { "Paste before" },
    n = { "nzz", "next search" },
    N = { "Nzz", "next search" },
    ["#"] = { "#zz", "next search" },
    ["*"] = { "*zz", "next search" },
    ["gB"] = { "Browser: Open URL" },
    ["g<CR>"] = { "Browser: Search word under cursor" },
    ["gG"] = { "Browser: Google Search word under cursor" },
    ["gW"] = { "Browser: Wikipedia Search word under cursor" },
    j = { "<Cmd>lua JumpDirection('j')<CR>", "Down" },
    k = { "<Cmd>lua JumpDirection('k')<CR>", "Up" },
    ["<M-j>"] = { "<Cmd>m .+1<CR>==", "Move line down" },
    ["<M-k>"] = { "<Cmd>m .-2<CR>==", "Move line up" },
    ["yA"] = { "<Cmd>%y+<CR>", "Yank file content" },
  },
}

RegisterKeymaps {
  mode = "x",
  prefix = "",
  {
    y = { "myy`y", "yank" },
    Y = { "myY`y", "Yank" },
    ["<"] = { "<gv", "dedent" },
    [">"] = { ">gv", "indent" },
  },
}

-- this needs mapping in kitty.conf
-- default behaviour <S-CR> == <C-CR> == <CR>
-- explanation: https://www.reddit.com/r/neovim/comments/mbj8m5/how_to_setup_ctrlshiftkey_mappings_in_neovim_and/
RegisterKeymaps {
  mode = "i",
  prefix = "",
  {
    ["<S-CR>"] = { "<C-o>o", "New line on bottom" },
    ["<C-CR>"] = { "<C-o>O", "New line on top" },
  },
}
