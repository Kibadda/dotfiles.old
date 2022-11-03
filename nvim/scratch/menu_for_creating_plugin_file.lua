local function open_menu()
  local Menu = require "nui.menu"
  local Input = require "nui.input"

  local options = {
    position = "50%",
    size = {
      width = 25,
      height = 3,
    },
    border = {
      style = "double",
      text = {
        top_align = "center",
      },
    },
    win_options = {
      winhighlight = "Normal:Normal,FloatBorder:Normal",
    },
  }

  local menu = Menu(
    vim.tbl_deep_extend("force", options, {
      border = {
        style = "single",
        text = {
          top = "[Choose]",
        },
      },
    }),
    {
      lines = {
        Menu.item("Create File", { id = 1 }),
        Menu.item("Create File (other name)", { id = 2 }),
        Menu.item("Nothing", { id = 3 }),
      },
      max_width = 20,
      keymap = {
        focus_next = { "j", "<Tab>" },
        focus_prev = { "k", "<S-Tab>" },
        close = { "<Esc>" },
        submit = { "<CR>", "<Space>" },
      },
      on_submit = function(item)
        if item.id == 1 then
          vim.pretty_print "open file"
        elseif item.id == 2 then
          local input = Input(
            vim.tbl_deep_extend("force", options, {
              border = {
                text = {
                  top = "[Filename]",
                },
              },
            }),
            {
              prompt = "> ",
              on_submit = function(value)
                vim.pretty_print("open file " .. value)
              end,
            }
          )

          input:mount()
        end
      end,
    }
  )

  menu:mount()
end

open_menu()
