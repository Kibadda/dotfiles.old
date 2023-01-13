local utils = require "user.utils"

require("user.utils.register").keymaps {
  n = {
    ["<Leader>"] = {
      L = { "<Cmd>Lazy<CR>", "Lazy" },
      Q = { utils.detach_from_tmux, "Detach" },
      P = { require("user.utils.plugin").new, "New Plugin File" },
      T = { utils.open_terminal, "Terminal" },
      n = { utils.new_scratch, "New Scratch" },
    },
    g = {
      B = { utils.open_url, "Open URL" },
      H = { utils.open_in_github, "Open current github" },
    },
    y = {
      A = { "<Cmd>%y+<CR>", "Yank file content" },
    },
    n = { "nzz", "next search" },
    N = { "Nzz", "next search" },
    ["#"] = { "#zz", "next search" },
    ["*"] = { "*zz", "next search" },
    ["<C-S-j>"] = { "<Cmd>m .+1<CR>==", "Move line down" },
    ["<C-S-k>"] = { "<Cmd>m .-2<CR>==", "Move line up" },
    j = { utils.jump_direction "j", "Down" },
    k = { utils.jump_direction "k", "Up" },
  },
  x = {
    y = { "myy`y", "yank" },
    Y = { "myY`y", "Yank" },
    ["<"] = { "<gv", "dedent" },
    [">"] = { ">gv", "indent" },
    ["<C-S-j>"] = { ":m '>+1<CR>gv=gv", "Move lines down" },
    ["<C-S-k>"] = { ":m '<-2<CR>gv=gv", "Move lines up" },
    j = { utils.jump_direction "j", "Down" },
    k = { utils.jump_direction "k", "Up" },
  },
  i = {
    -- this needs mapping in kitty.conf
    -- default behaviour <S-CR> == <C-CR> == <CR>
    -- explanation: https://www.reddit.com/r/neovim/comments/mbj8m5/how_to_setup_ctrlshiftkey_mappings_in_neovim_and/
    ["<S-CR>"] = { "<C-o>o", "New line on bottom" },
    ["<C-CR>"] = { "<C-o>O", "New line on top" },
    -- <C-h> == <C-BS>
    ["<C-h>"] = { "<C-w>", "Remove previous word" },
  },
}
