local Job = require "plenary.job"

local function open_in_github()
  local git_root = Job:new({
    command = "git",
    args = {
      "rev-parse",
      "--show-toplevel",
    },
    cwd = vim.fn.getcwd(),
  }):sync()[1]

  if git_root == nil then
    return
  end

  local remotes = Job
    :new({
      command = "git",
      args = { "remote" },
      cwd = vim.fn.getcwd(),
    })
    :sync()

  local remote_to_open
  if #remotes > 1 then
    vim.ui.select(remotes, { prompt = "remote> " }, function(remote)
      remote_to_open = remote
    end)
  else
    remote_to_open = remotes[1]
  end

  remote_to_open = remote_to_open or "origin"

  local url = Job:new({
    command = "git",
    args = {
      "config",
      "remote." .. remote_to_open .. ".url",
    },
    cwd = vim.fn.getcwd(),
  }):sync()[1]

  if url == nil then
    return
  end

  url = url:gsub("git:", "https://")
  url = url:gsub("git@", "https://")
  url = url:gsub("com:", "com/")
  url = url:gsub("de:", "de/")

  Job
    :new({
      command = "xdg-open",
      args = { url },
    })
    :sync()
end

vim.keymap.set("n", "<Leader>og", open_in_github, { desc = "Open in Github" })
vim.api.nvim_create_user_command("OpenInGithub", open_in_github, { nargs = 0, desc = "Open in Github" })
