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
  h = { "<Cmd>SearchBoxClear<CR>", "Remove highlight" },
})

RegisterKeymaps("n", "", {
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
})

RegisterKeymaps("x", "", {
  y = { "myy`y", "yank" },
  Y = { "myY`y", "Yank" },
  ["<"] = { "<gv", "dedent" },
  [">"] = { ">gv", "indent" },
})

-- this needs mapping in kitty.conf
-- default behaviour <S-CR> == <C-CR> == <CR>
-- explanation: https://www.reddit.com/r/neovim/comments/mbj8m5/how_to_setup_ctrlshiftkey_mappings_in_neovim_and/
RegisterKeymaps("i", "", {
  ["<S-CR>"] = { "<C-o>o", "New line on bottom" },
  ["<C-CR>"] = { "<C-o>O", "New line on top" },
})
