if not plugins_ok "gitsigns" then
  return
end

require("gitsigns").setup {
  on_attach = function(bufnr)
    require("user.utils.register").keymaps {
      mode = "n",
      prefix = "<Leader>",
      buffer = bufnr,
      {
        g = {
          name = "Git",
          d = { "<Cmd>Gitsigns diffthis<CR>", "Diff" },
          j = { "<Cmd>Gitsigns next_hunk<CR>", "Next Hunk" },
          k = { "<Cmd>Gitsigns prev_hunk<CR>", "Prev Hunk" },
          l = { "<Cmd>Gitsigns blame_line<CR>", "Blame Line" },
          s = { "<Cmd>Telescope git_status<CR>", "Status" },
          b = { "<Cmd>Telescope git_branches<CR>", "Checkout Branches" },
          c = { "<Cmd>Telescope git_commits<CR>", "Checkout Commit" },
          C = { "<Cmd>Telescope git_bcommits<CR>", "Checkout Commit (current file)" },
          r = { "<Cmd>Gitsigns reset_hunk<CR>", "Reset Hunk" },
          R = { "<Cmd>Gitsigns reset_buffer<CR>", "Reset Buffer" },
          g = { "<Cmd>Gitsigns stage_hunk<CR>", "Stage Hunk" },
          G = { "<Cmd>Gitsigns stage_buffer<CR>", "Stage Buffer" },
          u = { "<Cmd>Gitsigns undo_stage_hunk<CR>", "Undo Stage Hunk" },
        },
      },
    }

    require("user.utils.register").keymaps {
      mode = { "o", "x" },
      prefix = "",
      buffer = bufnr,
      {
        ih = { ":<C-u>Gitsigns select_hunk<CR>", "Hunk" },
      },
    }
  end,
}
