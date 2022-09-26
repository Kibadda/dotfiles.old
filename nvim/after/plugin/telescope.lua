if not PluginsOk "telescope" then
  return
end

require("telescope").setup {
  defaults = {
    winblend = 20,
    mappings = {
      i = {
        ["<C-j>"] = "move_selection_next",
        ["<C-k>"] = "move_selection_previous",
      },
    },
    -- TODO: somehow exclude files which path start with htdocs
    -- file_ignore_patterns = {},
  },
  extensions = {
    -- FIX: multiple files not working
    ["telescope-alternate"] = {
      mappings = {
        {
          "project/lib/objects/(.*).class.php",
          { "project/lib/dao/[1]DAO.class.php", "DAO" },
          { "project/templates/**/[1:pascal_to_snake]*.tpl", "Template" },
          { "project/htdocs/**/[1:pascal_to_snake]*.php", "Controller" },
          { "project/htdocs/static/js/*[1:pascal_to_snake]*.js", "Script" },
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
    ["laravel-docs"] = {
      preview = false,
    },
  },
}

require("telescope").load_extension "telescope-alternate"
require("telescope").load_extension "laravel-docs"

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
      e = { "<Cmd>Telescope symbols theme=ivy<CR>", "Emojis" },
      a = { "<Cmd>Telescope telescope-alternate alternate_file theme=ivy<CR>", "Alternate" },
      l = { "<Cmd>Telescope laravel-docs theme=dropdown<CR>", "Laravel Docs" },
    },
  },
}

RegisterKeymaps {
  mode = "i",
  prefix = "",
  {
    ["<M-e>"] = { "<Cmd>Telescope symbols theme=ivy<CR>", "Emojis" },
  },
}

local function terminal_emojis(source)
  if type(source) ~= "table" then
    source = { source }
  end

  require("telescope.builtin").symbols(require("telescope.themes").get_ivy {
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
  })
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
