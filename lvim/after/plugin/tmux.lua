if not pcall(require, "nvim-tmux-navigation") then
  return
end

require("nvim-tmux-navigation").setup {
  disable_when_zoomed = true,
  keybindings = {
    left = "<C-h>",
    down = "<C-j>",
    up = "<C-k>",
    right = "<C-l>",
    -- last_active = "<C-\\>",
    -- next = "<C-Space>",
  },
}
