---pretty print given value
---
---@param value any
---@return any
function P(value)
  print(vim.inspect(value))
  return value
end

---register keymaps
---
---local options = {
---  mode = "n",
---  prefix = "<Leader>",
---  which_key_option = "value"
---  {
---    f = { "<Cmd>Telescope find_files<CR>", "Find files" }
---  },
---}
---
---@param options table
function RegisterKeymaps(options)
  local keymaps = table.remove(options, 1)
  if options.mode == nil then
    error "RegisterKeymap: mode is not set"
  end
  if options.prefix == nil then
    error "RegisterKeymap: prefix is not set"
  end
  require("which-key").register(keymaps, options)
end

---for wrapped lines: gj/gk, for large jumps: add to jump list
---
---@param direction string
function JumpDirection(direction)
  local count = vim.v.count

  if count == 0 then
    vim.cmd.normal { "g" .. direction, bang = true }
    return
  end

  if count > 5 then
    vim.cmd.normal { "m'", bang = true }
  end

  vim.cmd.normal { count .. direction, bang = true }
end

---open plugin under cursor in browser
---
---@param in_file boolean wether to open plugin in file or in browser. default: false
---
---works with:
---use "author/plugin"
---use { "author/plugin", run = "do stuff" }
---use {
---  "author/plugin",
---  config = function()
---    P "Hello World!"
---  end,
---}
function OpenPlugin(in_browser)
  local ts_utils = require "nvim-treesitter.ts_utils"
  local current_node = ts_utils.get_node_at_cursor(0)

  if current_node == nil then
    return
  end

  while current_node:type() ~= "function_call" do
    current_node = current_node:parent()
  end

  local node_string = vim.treesitter.get_node_text(current_node, 0)

  if string.sub(node_string, 1, 3) ~= "use" then
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
  argument = argument:gsub('"', "")

  if in_browser then
    local url = "https://github.com/" .. argument
    os.execute("xdg-open " .. url)
  else
    local split = vim.split(argument, "/")
    local file_name = split[#split]
    -- file_name = string.gsub("nvim-", "")
    -- file_name = file_name:gsub(".nvim", "")
    -- file_name = file_name:gsub("vim-", "")
    -- file_name = file_name:gsub(".vim", "")

    file_name = "nvim/after/plugin/" .. file_name .. ".lua"

    if vim.fn.filereadable(file_name) == 1 then
      vim.cmd.e(file_name)
    end
  end
end
