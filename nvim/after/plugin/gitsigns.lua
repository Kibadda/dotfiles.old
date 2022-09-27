if not PluginsOk "gitsigns" then
  return
end

require("gitsigns").setup {}

RegisterKeymaps {
  mode = "n",
  prefix = "<Leader>",
  {
    g = {
      name = "Git",
      d = { "<Cmd>Gitsigns diffthis<CR>", "Diff" },
      j = { "<Cmd>Gitsigns next_hunk<CR>", "Next Hunk" },
      k = { "<Cmd>Gitsigns prev_hunk<CR>", "Prev Hunk" },
      l = { "<Cmd>Gitsigns blame_line<CR>", "Blame Line" },
      s = { "<Cmd>Telescope git_status<CR>", "Status" },
      g = {
        -- FIX: I really do not know why
        function()
          if not string.find(vim.fn.getcwd(), "^/media/beta/") then
            vim.cmd.Lazygit()
          end
        end,
        "Lazygit",
      },
      b = { "<Cmd>Telescope git_branches<CR>", "Checkout Branches" },
      c = { "<Cmd>Telescope git_commits<CR>", "Checkout Commit" },
      C = { "<Cmd>Telescope git_bcommits<CR>", "Checkout Commit (current file)" },
      r = { "<Cmd>Gitsigns reset_hunk<CR>", "Reset Hunk" },
      R = { "<Cmd>Gitsigns reset_buffer<CR>", "Reset Buffer" },
    },
  },
}
