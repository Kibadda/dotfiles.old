if not pcall(require, "gitsigns") then
  return
end

require("gitsigns").setup {}

RegisterKeymaps("<Leader", {
  g = {
    name = "Git",
    d = { "<Cmd>Gitsigns diffthis<CR>", "Diff" },
    j = { "<Cmd>Gitsigns next_hunk<CR>", "Next Hunk" },
    k = { "<Cmd>Gitsigns prev_hunk<CR>", "Prev Hunk" },
    b = { "<Cmd>Gitsigns blame_line<CR>", "Blame Line" },
  },
})
