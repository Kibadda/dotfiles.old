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
    file_name = string.gsub(file_name, "nvim%-", "")
    file_name = string.gsub(file_name, "%.nvim", "")
    file_name = string.gsub(file_name, "vim%-", "")
    file_name = string.gsub(file_name, "%.vim", "")

    local prefix = "nvim/after/plugin/"
    local suffix = ".lua"

    local file_path = prefix .. file_name .. suffix

    if vim.fn.filereadable(file_path) == 1 then
      vim.cmd.e(file_path)
    else
      local create = "Create File"
      local create_new_name = "Create File with different name"
      local add_skeleton = function(module_name)
        vim.api.nvim_buf_set_lines(0, 0, -1, false, {
          'if not PluginsOk "' .. module_name .. '" then',
          "  return",
          "end",
          "",
        })
        vim.api.nvim_win_set_cursor(0, { 4, 0 })
      end
      vim.ui.select({
        create_new_name,
        create,
        "Do Nothing",
      }, {
        prompt = "File missing",
      }, function(result)
        if result == create then
          vim.cmd.e(file_path)
          add_skeleton(file_name)
        elseif result == create_new_name then
          vim.ui.input({
            prompt = "New name: ",
          }, function(new_file_name)
            vim.cmd.e(prefix .. new_file_name .. suffix)
            add_skeleton(file_name)
          end)
        end
      end)
    end
  end
end
