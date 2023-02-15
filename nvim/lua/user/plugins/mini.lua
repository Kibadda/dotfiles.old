local M = {
  "echasnovski/mini.starter",
  dependencies = {
    {
      "Kibadda/projectodo.nvim",
      dependencies = {
        "nvim-treesitter/nvim-treesitter",
      },
      dev = true,
    },
  },
  event = "VimEnter",
}

function M.init()
  vim.api.nvim_create_autocmd("User", {
    group = vim.api.nvim_create_augroup("MiniStarterKeymaps", { clear = true }),
    pattern = "MiniStarterOpened",
    callback = function(args)
      vim.opt_local.statuscolumn = nil
      vim.opt_local.winbar = nil
      require("user.utils.register").keymaps {
        [{ mode = "n", buffer = args.buf }] = {
          ["<C-j>"] = {
            function()
              MiniStarter.update_current_item "next"
            end,
            "Move down",
          },
          ["<C-k>"] = {
            function()
              MiniStarter.update_current_item "prev"
            end,
            "Move down",
          },
        },
      }
    end,
  })
end

function M.config()
  local sections = require("projectodo").get_sections {
    plugin = "mini-starter",
    main_section = {
      name = "Dotfiles",
      sessions = { "dotfiles", "notes", "advent-of-code" },
    },
  }

  table.insert(sections, 1, function()
    return {
      {
        name = "Quit",
        action = "q",
        section = "",
      },
      {
        name = "Edit New Buffer",
        action = "enew",
        section = "",
      },
    }
  end)

  local day = table.concat(require("user.utils.weekdays")[tonumber(os.date "%w")], "\n")

  local starter = require "mini.starter"
  starter.setup {
    header = function()
      return day:gsub("AAAAAAAAAAAAAAAAAAA", os.date "%d.%m.%Y %H:%M:%S")
    end,
    items = sections,
    footer = function()
      local stats = require("lazy").stats()
      return ("Loaded %d/%d plugins in %dms"):format(stats.loaded, stats.count, stats.startuptime)
    end,
    content_hooks = {
      starter.gen_hook.adding_bullet(),
      function(content, buf_id)
        local win_id = vim.fn.bufwinid(buf_id)
        if win_id < 0 then
          return
        end

        local splitted = {
          header = {
            lines = {},
            width = 0,
            pad = 0,
          },
          items = {
            lines = {},
            width = 0,
            pad = 0,
          },
          footer = {
            lines = {},
            width = 0,
            pad = 0,
          },
        }

        for _, c in ipairs(content) do
          if c[1].type == "header" then
            table.insert(splitted.header.lines, c)
          elseif c[1].type == "footer" then
            table.insert(splitted.footer.lines, c)
          else
            table.insert(splitted.items.lines, c)
          end
        end

        for _, val in pairs(splitted) do
          for _, l in ipairs(MiniStarter.content_to_lines(val.lines)) do
            val.width = math.max(val.width, vim.fn.strdisplaywidth(l))
          end
          val.pad = math.max(math.floor(0.5 * (vim.api.nvim_win_get_width(win_id) - val.width)), 0)
        end

        local bottom_space = vim.api.nvim_win_get_height(win_id) - #content
        local top_pad = math.max(math.floor(0.5 * bottom_space), 0)

        content = MiniStarter.gen_hook.padding(splitted.header.pad, top_pad)(splitted.header.lines)
        for _, c in ipairs(MiniStarter.gen_hook.padding(splitted.items.pad, 0)(splitted.items.lines)) do
          table.insert(content, c)
        end
        for _, c in ipairs(MiniStarter.gen_hook.padding(splitted.footer.pad, 0)(splitted.footer.lines)) do
          table.insert(content, c)
        end

        return content
      end,
    },
  }

  local colors = require "nvim-tundra.palette.arctic"
  vim.cmd.highlight("MiniStarterHeader guifg=" .. colors.red._600)
  vim.cmd.highlight("MiniStarterSection guifg=" .. colors.green._600)
end

return M
