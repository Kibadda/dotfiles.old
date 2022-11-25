local M = {}

local config = {
  sessions = "$HOME/.local/share/nvim/session",
  notes = "$HOME/notes",
  max_projects = 6,
  max_todos_per_project = 9,
  norg_project_header = "Current Projects",
  norg_main_file = "index",
  main_section = {
    name = "Main Section",
    sessions = {},
  },
}
local session_files = {}

local function check_file(file_name)
  local file_path = vim.fn.expand(("%s/%s.norg"):format(config.notes, file_name))

  if vim.fn.filereadable(file_path) == 0 then
    return false, ""
  end

  return true, file_path
end

local function get_undone_todos(file_name, amount)
  local ok, file_path = check_file(file_name)

  if not ok then
    return {}
  end

  local query_string = [[
    (todo_item1
      state: (todo_item_undone)
      content: (paragraph (paragraph_segment) @todo)
    )
  ]]

  local captures = {}

  local file_string = table.concat(vim.fn.readfile(file_path), "\n")

  local root = vim.treesitter.get_string_parser(file_string, "norg", {}):parse()[1]:root()
  local query = vim.treesitter.parse_query("norg", query_string)

  for _, node in query:iter_captures(root) do
    table.insert(captures, {
      line = vim.treesitter.get_node_text(node, file_string),
      cmd = "",
    })
  end

  return vim.list_slice(captures, 1, amount)
end

local function get_projects(file_name, amount)
  local ok, index = check_file(file_name)

  if not ok then
    return {}
  end

  local query_string = string.format(
    [[
      (heading2
        title: (paragraph_segment) @project
        content: (generic_list
          (unordered_list1
            content: (paragraph
              (paragraph_segment
                (link
                  (link_location
                    file: (link_file_text) @file_name)
                  (link_description
                    text: (paragraph_segment) @name)))))))
      (#match? @project "%s")
    ]],
    config.norg_project_header
  )

  local file_string = table.concat(vim.fn.readfile(index), "\n")

  local root = vim.treesitter.get_string_parser(file_string, "norg", {}):parse()[1]:root()
  local query = vim.treesitter.parse_query("norg", query_string)

  local captures = {}

  for pattern, match in query:iter_matches(root) do
    if pattern == 1 then
      local capture = {}

      for id, node in pairs(match) do
        local name = query.captures[id]
        local text = vim.treesitter.get_node_text(node, file_string)
        if name ~= "project" then
          capture[name] = text
        end
      end

      table.insert(captures, capture)
    end
  end

  return vim.list_slice(captures, 1, amount)
end

local function load_session_files()
  if vim.fn.isdirectory(vim.fn.expand(config.sessions)) == 0 then
    return
  end

  local files = vim.fs.find(function(file)
    return string.match(file, "^__") == nil
  end, {
    path = config.sessions,
    type = "file",
    limit = math.huge,
  })

  for _, session_file in ipairs(files) do
    local split = vim.split(session_file, "/")
    local file_name = split[#split]
    session_files[file_name] = {
      path = session_file,
      used = false,
    }
  end
end

local function build_section(project)
  local sections = {}
  local indices = {}

  if project.command then
    table.insert(sections, project.command)
    table.insert(indices, 0)
  end

  if type(project.session) ~= "table" then
    project.session = { project.session }
  end

  for _, session_name in ipairs(project.session) do
    if session_files[session_name] then
      table.insert(sections, {
        line = session_name,
        cmd = ("source %s"):format(session_files[session_name].path),
      })
      table.insert(indices, project.index)
      project.index = project.index + 1
      session_files[session_name].used = true
    end
  end

  for _, todo in ipairs(get_undone_todos(project.todos, config.max_todos_per_project)) do
    table.insert(sections, todo)
    table.insert(indices, " ")
  end

  return {
    header = vim.fn["startify#pad"] { project.name },
    type = function()
      return sections
    end,
    indices = indices,
  }
end

local function general()
  return build_section {
    name = config.main_section.name,
    session = config.main_section.sessions,
    command = {
      line = "Create new Project",
      cmd = ("e %s/%s.norg"):format(config.notes, config.norg_main_file),
    },
    todos = config.norg_main_file,
    index = 1,
  }
end

local function current_projects()
  local projects = get_projects(config.norg_main_file, config.max_projects)

  local sections = {}

  local index = 30
  for _, project in ipairs(projects) do
    table.insert(
      sections,
      build_section {
        name = project.name,
        session = project.file_name,
        -- command = {
        --   line = "Delete this Session",
        --   cmd = ("!rm %s/%s"):format(config.sessions, project.file_name),
        -- },
        todos = project.file_name,
        index = index,
      }
    )
    index = index + 10
  end

  return sections
end

local function remaining_sessions()
  local sessions = {}

  for name, session in pairs(session_files) do
    if not session.used then
      table.insert(sessions, name)
    end
  end

  table.sort(sessions)

  return build_section {
    name = "Sessions",
    session = sessions,
    todos = {},
    index = 90,
  }
end

function M.lists(user_config)
  config = vim.tbl_deep_extend("force", config, user_config or {})

  load_session_files()

  local sections = {}

  table.insert(sections, general())

  for _, project in ipairs(current_projects()) do
    table.insert(sections, project)
  end

  table.insert(sections, remaining_sessions())

  return sections
end

-- TODO: option: custom indices

-- TODO: option: not only vim-startify
-- TODO: option: not only norg

return M
