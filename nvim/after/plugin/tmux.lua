if not pcall(require, "nvim-tmux-navigation") then
  return
end

local ntn = require("nvim-tmux-navigation")

ntn.setup {
  disable_when_zoomed = true,
}

RegisterKeymaps("", {
  ["<C-h>"] = { ntn.NvimTmuxNavigateLeft, "Tmux move left" },
  ["<C-j>"] = { ntn.NvimTmuxNavigateDown, "Tmux move down" },
  ["<C-k>"] = { ntn.NvimTmuxNavigateUp, "Tmux move up" },
  ["<C-l>"] = { ntn.NvimTmuxNavigateRight, "Tmux move right" },
})
