-- from: https://github.com/ViRu-ThE-ViRuS/configs/blob/master/nvim/lua/lib/core.lua

local core = require "lib.core"
local M = {}

-- strip filename from full path
function M.strip_fname(path)
  return vim.fn.fnamemodify(path, ":t:r")
end

-- strip trailing whitespaces in file
function M.strip_trailing_whitespaces()
  local cursor = vim.api.nvim_win_get_cursor(0)
  vim.api.nvim_command "%s/\\s\\+$//e"
  vim.api.nvim_win_set_cursor(0, cursor)
end

-- get vim cwd
function M.get_cwd()
  return vim.fn.getcwd()
end

-- get git repo root dir (or nil)
function M.get_git_root()
  local git_cmd = "git -C " .. M.get_cwd() .. " rev-parse --show-toplevel"
  local root, rc = core.lua_systemlist(git_cmd)

  if rc == 0 then
    return root[1]
  end

  return nil
end

-- get git remote names
function M.get_git_remotes()
  local table, rc = core.lua_systemlist "git remote -v | cut -f 1 | uniq"
  if rc ~= 0 then
    return {}
  end

  return table
end

-- open repository on github
function M.open_repo_on_github(remote)
  if M.get_git_root() == nil then
    vim.notify("not in a git repository", "error", { title = "could not open on github" })
  end

  remote = remote or "origin"

  local url, rc = core.lua_system("git config remote." .. remote .. ".url")
  if rc ~= 0 then
    vim.notify(
      string.format("found invalid remote url: [%s] -> %s", remote, url),
      "error",
      { title = "could not open on github" }
    )
  end

  url = url:gsub("git:", "https://")
  url = url:gsub("git@", "https://")
  url = url:gsub("com:", "com/")
  url = url:gsub("de:", "de/")
  core.lua_system("xdg-open " .. url)

  vim.notify(string.format("[%s] -> %s", remote, url), "info", { title = "opening remote in browser" })
end

-- spellings: toggle spellings globally
function M.toggle_spellings()
  if vim.api.nvim_get_option_value("spell", { scope = "global" }) then
    vim.opt.spell = false
    vim.notify("spellings deactivated", "info", { render = "minimal" })
  else
    vim.opt.spell = true
    vim.notify("spellings activated", "info", { render = "minimal" })
  end
end

-- laststatus: toggle between global and local statusline
function M.toggle_global_statusline(force_local)
  if vim.api.nvim_get_option_value("laststatus", { scope = "global" }) == 3 or force_local then
    vim.opt.laststatus = 2
    vim.notify("global statusline deactivated", "info", { render = "minimal" })
  else
    vim.opt.laststatus = 3
    vim.notify("global statusline activated", "info", { render = "minimal" })
  end
end

return M
