-- for k, v in vim.fs.dir "~/.cache/laravel-docs" do
--   vim.pretty_print { k, v }
-- end

local norg_files = vim.fs.find(function(file)
  return string.match(file, ".norg$") ~= nil
end, {
  path = "$HOME/notes",
  type = "file",
  limit = math.huge,
})

local captures = {}

local function file_to_name(file)
  local split = vim.split(file, "/")
  local file_name = split[#split]
  return vim.split(file_name, "%.")[1]
end

for _, file in ipairs(norg_files) do
  local query_string = [[
    (todo_item1
      state: (todo_item_undone)
      content: (paragraph (paragraph_segment) @todo)
    )
  ]]

  local name = file_to_name(file)

  captures[name] = {}

  local file_string = table.concat(vim.fn.readfile(vim.fn.expand(file)), "\n")

  local root = vim.treesitter.get_string_parser(file_string, "norg", {}):parse()[1]:root()
  local query = vim.treesitter.parse_query("norg", query_string)

  for _, node in query:iter_captures(root) do
    table.insert(captures[name], {
      line = vim.treesitter.get_node_text(node, file_string),
      cmd = "",
    })
  end
end

local toReturn = {}

for name, todos in pairs(captures) do
  table.insert(toReturn, {
    type = function()
      return todos
    end,
    header = vim.fn["startify#pad"] { name },
    indices = { " ", " ", " ", " ", " ", " ", " ", " ", " ", " " },
  })
end

vim.pretty_print(toReturn)
