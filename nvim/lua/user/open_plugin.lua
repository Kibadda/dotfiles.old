local M = {}

local prefix = "nvim/after/plugin/"
local suffix = ".lua"

local function trim_plugin_name(name)
  local split = vim.split(name, "/", { plain = true })
  local file_name = split[#split]
  file_name = string.gsub(file_name, "nvim%-", "")
  file_name = string.gsub(file_name, "%.nvim", "")
  file_name = string.gsub(file_name, "vim%-", "")
  file_name = string.gsub(file_name, "%.vim", "")
  file_name = string.gsub(file_name, "%.lua", "")
  file_name = string.lower(file_name)

  return file_name
end

local function get_nui_options(title)
  return {
    position = "50%",
    size = {
      width = 25,
      height = 3,
    },
    border = {
      style = "single",
      text = {
        top = title,
        top_align = "center",
      },
    },
    win_options = {
      winhighlight = "Normal:Normal,FloatBorder:Normal",
    },
  }
end

local function open_menu(file_path)
  local Menu = require "nui.menu"
  local Input = require "nui.input"

  Menu(get_nui_options "[Choose]", {
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
        vim.cmd.e(file_path)
      elseif item.id == 2 then
        Input(get_nui_options "[Filename]", {
          prompt = "> ",
          on_submit = function(value)
            if #value > 0 then
              vim.cmd.e(("%s%s%s"):format(prefix, value, suffix))
            end
          end,
        }):mount()
      end
    end,
  }):mount()
end

local function get_plugin_string()
  local ts_utils = require "nvim-treesitter.ts_utils"
  local current_node = ts_utils.get_node_at_cursor(0)

  if current_node == nil then
    return
  end

  while current_node:type() ~= "function_call" do
    current_node = current_node:parent()
  end

  local node_string = vim.treesitter.get_node_text(current_node, 0)

  if string.sub(node_string, 1, 3) ~= "use" and string.sub(node_string, 1, 9) ~= "local_use" then
    return
  end

  local query_string = [[
    (
     (function_call
       name: (identifier)
       arguments: [
         (arguments (string) @argument)
         (arguments
           (table_constructor
             (field
               !name
               value: (string) @argument)))
       ])
    )
  ]]

  local root = vim.treesitter.get_string_parser(node_string, "lua", {}):parse()[1]:root()
  local _, node = vim.treesitter.parse_query("lua", query_string):iter_captures(root, 0, 0, -1)()
  local argument = vim.treesitter.get_node_text(node, node_string)

  return argument:gsub('"', "")
end

---open plugin under cursor in browser
---works inside:
---```lua
---use "author/plugin"
---use { "author/plugin", run = "do stuff" }
---use {
---  "author/plugin",
---  config = function()
---    P "Hello World!"
---  end,
---}
---```
function M.in_browser()
  os.execute(("xdg-open https://github.com/%s"):format(get_plugin_string()))
end

---open plugin under cursor in file
---opens menu if file does not already exist
---works inside:
---```lua
---use "author/plugin"
---use { "author/plugin", run = "do stuff" }
---use {
---  "author/plugin",
---  config = function()
---    P "Hello World!"
---  end,
---}
---```
function M.in_file()
  local file_path = ("%s%s%s"):format(prefix, trim_plugin_name(get_plugin_string()), suffix)

  if vim.fn.filereadable(file_path) == 1 then
    vim.cmd.e(file_path)
  else
    open_menu(file_path)
  end
end

return M
