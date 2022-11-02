require("user.utils").register_keymaps {
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
      p = { "<Cmd>PackerSync --preview<CR>", "Sync with preview" },
    },
    h = { "<Cmd>nohl<CR>", "Remove highlight" },
    Q = { require("user.utils").detach_from_tmux, "Detach" },
    P = { "<Cmd>e nvim/lua/user/plugins.lua<CR>", "Edit Plugins" },
    I = { "<Cmd>e nvim/init.lua<CR>", "Edit Init" },
  },
}

require("user.utils").register_keymaps {
  mode = "n",
  prefix = "",
  {
    Y = { "Yank till EOL" },
    gJ = { "Join lines" },
    gS = { "Split line" },
    p = { "Paste" },
    P = { "Paste before" },
    gB = { "Browser: Open URL" },
    ["g<CR>"] = { "Browser: Search word under cursor" },
    gG = { "Browser: Google Search word under cursor" },
    gW = { "Browser: Wikipedia Search word under cursor" },
    n = { "nzz", "next search" },
    N = { "Nzz", "next search" },
    ["#"] = { "#zz", "next search" },
    ["*"] = { "*zz", "next search" },
    ["<C-q>"] = { "<Plug>(qf_qf_toggle_stay)", "QF: toggle" },
    ["<C-Up>"] = { "<Plug>(qf_qf_previous)", "QF: prev" },
    ["<C-Down>"] = { "<Plug>(qf_qf_next)", "QF: next" },
    ["<C-S-j>"] = { "<Cmd>m .+1<CR>==", "Move line down" },
    ["<C-S-k>"] = { "<Cmd>m .-2<CR>==", "Move line up" },
    yA = { "<Cmd>%y+<CR>", "Yank file content" },
    gH = { require("user.utils").open_in_github, "Open current github" },
    j = {
      function()
        require("user.utils").jump_direction "j"
      end,
      "Down",
    },
    k = {
      function()
        require("user.utils").jump_direction "k"
      end,
      "Up",
    },
  },
}

require("user.utils").register_keymaps {
  mode = "x",
  prefix = "",
  {
    y = { "myy`y", "yank" },
    Y = { "myY`y", "Yank" },
    ["<"] = { "<gv", "dedent" },
    [">"] = { ">gv", "indent" },
    ["<C-S-j>"] = { ":m '>+1<CR>gv=gv", "Move lines down" },
    ["<C-S-k>"] = { ":m '<-2<CR>gv=gv", "Move lines up" },
    j = {
      function()
        require("user.utils").jump_direction "j"
      end,
      "Down",
    },
    k = {
      function()
        require("user.utils").jump_direction "k"
      end,
      "Up",
    },
  },
}

-- this needs mapping in kitty.conf
-- default behaviour <S-CR> == <C-CR> == <CR>
-- explanation: https://www.reddit.com/r/neovim/comments/mbj8m5/how_to_setup_ctrlshiftkey_mappings_in_neovim_and/
require("user.utils").register_keymaps {
  mode = "i",
  prefix = "",
  {
    ["<S-CR>"] = { "<C-o>o", "New line on bottom" },
    ["<C-CR>"] = { "<C-o>O", "New line on top" },
    -- <C-h> == <C-BS>
    ["<C-h>"] = { "<C-w>", "Remove previous word" },
  },
}

-- RegisterKeymaps {
--   mode = "c",
--   prefix = "",
--   {
--     w = { "<Cmd>checktime<Bar>w<CR>", "checktime if file is on samba share" },
--   },
-- }
