if not PluginsOk "telescope" then
  return
end

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
    generic_sorter = require("mini.fuzzy").get_telescope_sorter,
    -- TODO: somehow exclude files which path start with htdocs in "Telescope lsp_references"
    -- file_ignore_patterns = {
    --   "^htdocs/",
    -- },
  },
  extensions = {
    -- FIX: multiple files not working
    ["telescope-alternate"] = {
      mappings = {
        {
          pattern = "project/lib/objects/(.*).class.php",
          targets = {
            { "project/lib/dao/[1]DAO.class.php", "DAO" },
            { "project/templates/**/[1:pascal_to_snake]*.tpl", "Template" },
            { "project/htdocs/**/[1:pascal_to_snake]*.php", "Controller" },
            { "project/htdocs/static/js/*[1:pascal_to_snake]*.js", "Script" },
          },
        },
        {
          pattern = "project/lib/dao/(.*)DAO.class.php",
          targets = {
            { "project/lib/objects/[1].class.php", "Model" },
            { "project/templates/**/[1:pascal_to_snake]*.tpl", "Template" },
            { "project/htdocs/**/[1:pascal_to_snake]*.php", "Controller" },
            { "project/htdocs/static/js/*[1:pascal_to_snake]*.js", "Script" },
          },
        },
      },
      transformers = {
        pascal_to_snake = function(w)
          local toReturn = {}
          for word in string.gmatch(w, "%u%U*") do
            table.insert(toReturn, string.lower(word))
          end
          return table.concat(toReturn, "_")
        end,
      },
    },
  },
}

require("telescope").load_extension "telescope-alternate"
require("telescope").load_extension "laravel-docs"

require("user.utils").register_keymaps {
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
      o = { "<Cmd>Telescope oldfiles only_cwd=true<CR>", "Laravel Docs" },
      a = { "<Cmd>Telescope telescope-alternate alternate_file<CR>", "Alternate" },
      l = { "<Cmd>Telescope laravel-docs<CR>", "Laravel Docs" },
    },
  },
}

require("user.utils").register_keymaps {
  mode = "i",
  prefix = "",
  {
    ["<M-e>"] = { "<Cmd>Telescope symbols<CR>", "Emojis" },
  },
}

local function terminal_emojis(source)
  if type(source) ~= "table" then
    source = { source }
  end

  require("telescope.builtin").symbols {
    winblend = 0,
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
    sources = source,
  }
end

require("user.utils").register_keymaps {
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
