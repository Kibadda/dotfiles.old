vim.api.nvim_create_user_command("Lazygit", function()
  vim.cmd.term "lazygit"
end, {
  bang = false,
  nargs = 0,
  desc = "Open lazygit",
})

vim.api.nvim_create_user_command("ToggleAutoFormat", function()
  if GetGlobal("Lsp", "auto_format") == 1 then
    SetGlobal("Lsp", {
      auto_format = 0,
    })
    vim.notify("Turned off", "success", { title = "Auto Format" })
  else
    SetGlobal("Lsp", {
      auto_format = 1,
    })
    vim.notify("Turned on", "success", { title = "Auto Format" })
  end
end, {
  bang = false,
  nargs = 0,
  desc = "toggle auto format option",
})

vim.api.nvim_create_user_command("DetachTmux", function()
  os.execute "tmux detach"
end, {
  bang = false,
  nargs = 0,
  desc = "Detach from tmux",
})

vim.api.nvim_create_user_command("SaveAndSource", function()
  vim.cmd.w()

  if vim.bo.filetype == "lua" then
    vim.cmd.luafile "%"
  elseif vim.bo.filetype == "vim" then
    vim.cmd.source "%"
  end
end, {
  bang = false,
  nargs = 0,
  desc = "Save and source current file",
})

vim.api.nvim_create_user_command("OpenInGithub", function()
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
end, {
  bang = false,
  nargs = 0,
  desc = "Open current project on github",
})
