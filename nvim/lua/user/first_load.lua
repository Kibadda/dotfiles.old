if not PluginsOk "packer" then
  local directory = string.format("%s/site/pack/packer/start/", vim.fn.stdpath "data")

  vim.fn.mkdir(directory, "p")

  local github_url = "https://github.com/wbthomason/packer.nvim"

  vim.fn.system(string.format("git clone %s %s/packer.nvim", github_url, directory))

  vim.fn.input "You need to restart now (press anything to continue)"
  vim.cmd.qa()

  return true
end

return false
