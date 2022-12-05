if not plugins_ok "telescope" then
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
    -- TODO: somehow exclude files which path start with htdocs in "Telescope lsp_references"
    -- file_ignore_patterns = {
    --   "^htdocs/",
    -- },
  },
}

pcall(require("telescope").load_extension, "laravel-docs")

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

require("user.utils.register").keymaps {
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

if false then
  vim.ui.select = function(items, opts, on_choice)
    opts = opts or {}
    require("telescope.pickers")
      .new({}, {
        borderchars = {
          prompt = { "─", "│", " ", "│", "┌", "┐", " ", " " },
          results = { " ", "│", "─", "│", " ", " ", "┘", "└" },
        },
        prompt_title = (opts.prompt or "Select one of"):gsub(":", ""),
        finder = require("telescope.finders").new_table {
          results = items,
          entry_maker = function(item)
            return {
              display = item,
              ordinal = item,
              value = item,
            }
          end,
        },
        attach_mappings = function(prompt_bufnr)
          require("telescope.actions").select_default:replace(function()
            local selection = require("telescope.actions.state").get_selected_entry()
            if not selection then
              return
            end
            require("telescope.actions").close(prompt_bufnr)
            local idx = nil
            for i, item in ipairs(items) do
              if item == selection.value then
                idx = i
                break
              end
            end
            on_choice(selection.value, idx)
          end)
          return true
        end,
        sorter = require("telescope.config").values.generic_sorter(),
      })
      :find()
  end
end
