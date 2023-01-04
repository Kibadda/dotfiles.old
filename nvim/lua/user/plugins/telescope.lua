local M = {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-telescope/telescope-symbols.nvim",
  },
}

function M.config()
  require("telescope").setup {
    defaults = {
      sorting_strategy = "ascending",
      layout_strategy = "bottom_pane",
      winblend = 20,
      prompt_prefix = "Search: ",
      results_title = false,
      borderchars = {
        prompt = { "─", "│", " ", "│", "┌", "┐", " ", " " },
        results = { " ", " ", "─", "│", " ", " ", "─", "└" },
        preview = { "─", "│", "─", "│", "┌", "┤", "┘", "┴" },
      },
      mappings = {
        i = {
          ["<C-j>"] = "move_selection_next",
          ["<C-k>"] = "move_selection_previous",
        },
      },
    },
  }

  -- pcall(require("telescope").load_extension, "laravel-docs")

  require("user.utils.register").keymaps {
    mode = "n",
    prefix = "<Leader>",
    {
      f = { "<Cmd>Telescope find_files<CR>", "Find Files" },
      F = { "<Cmd>Telescope find_files no_ignore=true<CR>", "Find All Files" },
      s = {
        name = "Search",
        g = { "<Cmd>Telescope live_grep<CR>", "Live Grep" },
        h = { "<Cmd>Telescope help_tags<CR>", "Help" },
        b = { "<Cmd>Telescope builtin<CR>", "Builtin" },
        n = { "<Cmd>Telescope notify<CR>", "Notifications" },
        k = { "<Cmd>Telescope keymaps<CR>", "Keymaps" },
        H = { "<Cmd>Telescope highlights<CR>", "Highlights" },
        r = { "<Cmd>Telescope registers<CR>", "Registers" },
        c = { "<Cmd>Telescope commands<CR>", "Commands" },
        R = { "<Cmd>Telescope resume<CR>", "Resume" },
        e = { "<Cmd>Telescope symbols<CR>", "Emojis" },
        o = { "<Cmd>Telescope oldfiles only_cwd=true<CR>", "Recent Files" },
        a = { "<Cmd>Telescope telescope-alternate alternate_file<CR>", "Alternate" },
        l = { "<Cmd>Telescope laravel-docs<CR>", "Laravel Docs" },
      },
    },
  }

  require("user.utils.register").keymaps {
    mode = "i",
    prefix = "",
    {
      ["<M-e>"] = { "<Cmd>Telescope symbols<CR>", "Emojis" },
    },
  }
end

return M
