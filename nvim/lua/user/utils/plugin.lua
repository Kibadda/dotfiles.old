local M = {}

function M.open()
  local query_string = [[
      [
        (variable_declaration
          (assignment_statement
            (variable_list
              name: (identifier) @module (#eq? @module "M"))
            (expression_list
              value: (table_constructor
                [
                  (field
                    !name
                    value: (string) @plugin)
                  (field
                    name: (identifier) @dependencies (#eq? @dependencies "dependencies")
                    value: (table_constructor
                      [
                        (field
                          !name
                          value: (string) @plugin)
                        (field
                          !name
                          value: (table_constructor
                            (field
                              !name
                              value: (string) @plugin)))
                      ]))
                ]))))
        (return_statement
          (expression_list
            (table_constructor
              [
                (field
                  !name
                  value: (string) @plugin)
                (field
                  !name
                  value: (table_constructor
                    (field
                      !name
                      value: (string) @plugin)))
              ])))
      ]
    ]]

  local root = vim.treesitter.get_parser(0, "lua", {}):parse()[1]:root()
  local query = vim.treesitter.query.parse_query("lua", query_string)

  local plugins = {}
  for _, match in query:iter_matches(root, 0, 0, -1) do
    for id, node in pairs(match) do
      if query.captures[id] == "plugin" then
        local text = vim.treesitter.query.get_node_text(node, 0)
        plugins[#plugins + 1] = text:gsub('"', "")
      end
    end
  end

  if #plugins == 0 then
    return
  end

  local function open(plugin)
    os.execute(("xdg-open https://github.com/%s"):format(plugin))
  end

  if #plugins == 1 then
    open(plugins[1])
  else
    require "telescope"
    vim.ui.select(plugins, {
      prompt = "Select plugin to open",
    }, function(choice)
      if choice then
        open(choice)
      end
    end)
  end
end

function M.new()
  local dir = vim.fn.stdpath "config" .. "/lua/user/plugins"

  local files = {}
  for name, type in vim.fs.dir(dir) do
    if type == "dir" then
      name = name .. "/init.lua"
    end

    table.insert(files, name)
  end

  table.insert(files, 1, "New File")

  require "telescope"
  vim.ui.select(files, {}, function(choice, idx)
    if not choice then
      return
    end

    if idx == 1 then
      vim.ui.input({
        prompt = "Name: ",
      }, function(input)
        if input then
          vim.cmd(("e %s/%s.lua"):format(dir, input))
        end
      end)
    else
      vim.cmd(("e %s/%s"):format(dir, choice))
    end
  end)
end

return M
