local file_string = table.concat(vim.fn.readfile "/home/michael/.cache/laravel-docs/collections.md", "\n")

local query_string = [[
  [
    (
      (section
        (paragraph
          (inline) @link) .)
      .
      (section
        (atx_heading
          (_) @type
          heading_content: (inline) @text))
    )
    (
      (section
        (section
          (paragraph
            (inline) @link) .) .)
      .
      (section
        (atx_heading
          (_) @type
          heading_content: (inline) @text))
    )
    (
      (paragraph
        (inline) @link)
      .
      (section
        (atx_heading
          (_) @type
          heading_content: (inline) @text))
    )
  ]
]]

local result = {}

local root = vim.treesitter.get_string_parser(file_string, "markdown", {}):parse()[1]:root()
local query = vim.treesitter.parse_query("markdown", query_string)

for _, match in query:iter_matches(root) do
  local entry = {}
  for id, node in pairs(match) do
    entry[query.captures[id]] = vim.treesitter.get_node_text(node, file_string)
    if query.captures[id] == "text" then
      entry.row = node:start()
    end
  end
  table.insert(result, entry)
end

vim.pretty_print(result)
