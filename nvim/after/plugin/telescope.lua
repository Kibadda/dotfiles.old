if not PluginsOk "telescope" then
  return
end

require("telescope").setup {
  defaults = {
    mappings = {
      i = {
        ["<C-j>"] = "move_selection_next",
        ["<C-k>"] = "move_selection_previous",
      },
    },
    -- TODO: somehow exclude files which path start with htdocs
    -- file_ignore_patterns = {},
  },
}

RegisterKeymaps {
  mode = "n",
  prefix = "<Leader>",
  {
    f = { "<Cmd>Telescope find_files theme=ivy<CR>", "Find Files" },
    F = { "<Cmd>Telescope find_files no_ignore=true theme=ivy<CR>", "Find All Files" },
    s = {
      name = "Search",
      g = { "<Cmd>Telescope live_grep theme=ivy<CR>", "Live Grep" },
      h = { "<Cmd>Telescope help_tags theme=ivy<CR>", "Help" },
      b = { "<Cmd>Telescope builtin theme=ivy<CR>", "Builtin" },
      n = { "<Cmd>Telescope notify theme=ivy<CR>", "Notifications" },
      k = { "<Cmd>Telescope keymaps theme=ivy<CR>", "Keymaps" },
      H = { "<Cmd>Telescope highlights theme=ivy<CR>", "Highlights" },
      r = { "<Cmd>Telescope registers theme=ivy<CR>", "Registers" },
      c = { "<Cmd>Telescope commands theme=ivy<CR>", "Commands" },
      R = { "<Cmd>Telescope resume<CR>", "Resume" },
      e = { "<Cmd>Telescope symbols<CR>", "Emojis" },
    },
  },
}

RegisterKeymaps {
  mode = "i",
  prefix = "",
  {
    ["<M-e>"] = { "<Cmd>Telescope symbols<CR>", "Emojis" },
  },
}

local function terminal_emojis(source)
  require("telescope.builtin").symbols {
    attach_mappings = function(prompt_bufnr, map)
      local function close_telescope(callback)
        local actions = require "telescope.actions"
        actions.close(prompt_bufnr)
        vim.defer_fn(function()
          _ = callback and callback()
          vim.cmd.startinsert()
        end, 0)
      end
      map("i", "<CR>", function()
        close_telescope(function()
          local state = require "telescope.actions.state"
          vim.api.nvim_put({ state.get_selected_entry().value[1] }, "", true, true)
        end)
      end)
      map("n", "<ESC>", function()
        close_telescope()
      end)
      return true
    end,
    sources = { source },
  }
end

RegisterKeymaps {
  mode = "t",
  prefix = "",
  {
    ["<M-e>"] = {
      function()
        terminal_emojis "gitmoji"
      end,
      "Emojis",
    },
    ["<M-w>"] = {
      function()
        terminal_emojis "emoji"
      end,
      "Emojis",
    },
  },
}
