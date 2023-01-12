local M = {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-telescope/telescope-symbols.nvim",
    "nvim-telescope/telescope-ui-select.nvim",
  },
  cmd = "Telescope",
}

function M.init()
  require("user.utils.register").keymaps {
    n = {
      ["<Leader>"] = {
        f = { "<Cmd>Telescope find_files<CR>", "Find Files" },
        F = { "<Cmd>Telescope find_files no_ignore=true hidden=true<CR>", "Find All Files" },
        s = {
          name = "Search",
          g = { "<Cmd>Telescope live_grep<CR>", "Live Grep" },
          h = { "<Cmd>Telescope help_tags<CR>", "Help" },
          b = { "<Cmd>Telescope builtin<CR>", "Builtin" },
          k = { "<Cmd>Telescope keymaps<CR>", "Keymaps" },
          H = { "<Cmd>Telescope highlights<CR>", "Highlights" },
          r = { "<Cmd>Telescope registers<CR>", "Registers" },
          c = { "<Cmd>Telescope commands<CR>", "Commands" },
          R = { "<Cmd>Telescope resume<CR>", "Resume" },
        },
      },
    },
    i = {
      ["<M-e>"] = { "<Cmd>Telescope symbols<CR>", "Emojis" },
    },
  }
end

function M.config()
  require("telescope").setup {
    defaults = {
      sorting_strategy = "ascending",
      layout_strategy = "bottom_pane",
      winblend = 0,
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
    extensions = {
      ["ui-select"] = {
        require("telescope.themes").get_dropdown {
          borderchars = {
            prompt = { "─", "│", " ", "│", "┌", "┐", " ", " " },
            results = { "─", "│", "─", "│", "├", "┤", "┘", "└" },
          },
        },
      },
    },
  }

  require("telescope").load_extension "ui-select"
end

return M
