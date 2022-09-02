---pretty print given value
---@param value any
---@return any
function P(value)
  print(vim.inspect(value))
  return value
end

---register keymaps
---local options = {
---  mode = "n",
---  prefix = "<Leader>",
---  which_key_option = "value"
---  {
---    f = { "<Cmd>Telescope find_files<CR>", "Find files" }
---  },
---}
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
function OpenPlugin()
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
       name: (identifier) @function_name
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

  local query = vim.treesitter.parse_query("lua", query_string)
  local root = vim.treesitter.get_string_parser(node_string, "lua", {}):parse()[1]:root()

  for _, match in query:iter_matches(root, 0, 0, -1) do
    local function_name, argument
    for id, node in pairs(match) do
      if query.captures[id] == "function_name" then
        function_name = vim.treesitter.get_node_text(node, node_string)
      end
      if query.captures[id] == "argument" then
        argument = vim.treesitter.get_node_text(node, node_string)
      end
      if function_name and argument then
        local url = "https://github.com/" .. argument
        os.execute("xdg-open " .. url)
        return
      end
    end
  end
end
