vim.ui.select = function(items, opts, on_choice)
  opts = opts or {}
  require("telescope.pickers")
    .new({}, {
      borderchars = {
        prompt = { "─", "│", " ", "│", "┌", "┐", " ", " " },
        results = { " ", "│", "─", "│", " ", " ", "┘", "└" },
      },
      prompt_title = (opts.prompt or "Select on of"):gsub(":", ""),
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
