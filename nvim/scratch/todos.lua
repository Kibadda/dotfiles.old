local query_string = [[
  (todo_item1
    state: (todo_item_undone)
    content: (paragraph (paragraph_segment) @todo)
  )
]]

local directory = vim.fn.expand "$HOME/notes"
local file = string.format("%s/index.norg", directory)
local file_string = table.concat(vim.fn.readfile(file), "\n")

local captures = {}

local root = vim.treesitter.get_string_parser(file_string, "norg", {}):parse()[1]:root()
local query = vim.treesitter.parse_query("norg", query_string)

for _, node in query:iter_captures(root) do
  table.insert(captures, vim.treesitter.get_node_text(node, file_string))
end

vim.pretty_print(captures)
