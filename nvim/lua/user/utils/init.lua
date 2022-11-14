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

---set value depending if cwd is cortex
---@param value_if_work any
---@param default any
function M.set_value(value_if_work, default)
  local dir = vim.fn.getcwd()

  if string.find(dir, "^/media/") then
    return value_if_work
  end

  return default
end

function M.set_cwd_options(value_if_work, default)
  local ts = M.set_value(value_if_work, default)

  require("user.utils.options").set {
    tabstop = ts,
    shiftwidth = ts,
    formatoptions = require("user.utils.globals").get("", "formatoptions"),
  }
end

return M
