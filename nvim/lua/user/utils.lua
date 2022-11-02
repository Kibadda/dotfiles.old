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

---```lua
---local options = {
---  mode = "n",
---  prefix = "<Leader>",
---  which_key_option = "value"
---  {
---    f = { "<Cmd>Telescope find_files<CR>", "Find files" }
---  },
---}
---```
---@param options table
function M.register_keymaps(options)
  local keymaps = table.remove(options, 1)
  if options.mode == nil then
    error "RegisterKeymap: mode is not set"
  end
  if options.prefix == nil then
    error "RegisterKeymap: prefix is not set"
  end
  if options.mode == "" then
    for lhs, rhs in pairs(keymaps) do
      vim.keymap.set("", lhs, rhs[1], {
        desc = rhs[2],
      })
    end
  else
    require("which-key").register(keymaps, options)
  end
end

---register abbreviations
---@param abbreviations table
function M.register_abbreviations(abbreviations)
  for k, v in pairs(abbreviations) do
    vim.cmd.cabbrev(("%s %s"):format(k, v))
  end
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

return M
