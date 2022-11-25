local M = {}

function M.detach_from_tmux()
  os.execute "tmux detach"
end

function M.save_and_source()
  vim.cmd.w()

  if vim.bo.filetype == "lua" then
    vim.cmd.luafile "%"
  elseif vim.bo.filetype == "vim" then
    vim.cmd.source "%"
  end
end

function M.open_in_github()
  local Job = require "plenary.job"
  local job1 = Job:new {
    command = "git",
    args = {
      "remote",
    },
    cwd = vim.fn.getcwd(),
  }
  job1:sync()
  local remote = job1:result()[1]
  local job2 = Job:new {
    command = "git",
    args = {
      "config",
      "--get",
      ("remote.%s.url"):format(remote),
    },
    cwd = vim.fn.getcwd(),
  }
  job2:sync()
  local remote_url = job2:result()[1]
  remote_url = string.gsub(remote_url, "%.git", "")
  remote_url = string.gsub(remote_url, ":", "/")
  remote_url = string.gsub(remote_url, "git@", "https://")
  os.execute(("xdg-open %s"):format(remote_url))
end

---for wrapped lines: gj/gk, for large jumps: add to jump list
---@param direction string
function M.jump_direction(direction)
  local count = vim.v.count

  if count == 0 then
    vim.cmd.normal { ("g%s"):format(direction), bang = true }
    return
  end

  if count > 5 then
    vim.cmd.normal { "m'", bang = true }
  end

  vim.cmd.normal { ("%d%s"):format(count, direction), bang = true }
end

---set options depending if cwd is cortex
---@param value_if_work any
---@param default any
function M.set_cwd_options(value_if_work, default)
  local ts = default
  if string.find(vim.fn.getcwd(), "^/media/") then
    ts = value_if_work
  end

  require("user.utils.options").set {
    tabstop = ts,
    shiftwidth = ts,
    formatoptions = require("user.utils.globals").get("", "formatoptions"),
  }
end

---get all open todos from notes directory
---@return table, table
function M.get_open_todos()
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

  local main_todos
  local remaining_todos = {}

  for name, todos in pairs(captures) do
    if name == "index" then
      main_todos = {
        type = function()
          return vim.list_slice(todos, 1, 10)
        end,
        header = vim.fn["startify#pad"] { "Todos" },
        indices = { " ", " ", " ", " ", " ", " ", " ", " ", " ", " " },
      }
    else
      table.insert(remaining_todos, {
        type = function()
          return vim.list_slice(todos, 1, 10)
        end,
        header = vim.fn["startify#pad"] { name },
        indices = { " ", " ", " ", " ", " ", " ", " ", " ", " ", " " },
      })
    end
  end

  return main_todos, remaining_todos
end

return M
