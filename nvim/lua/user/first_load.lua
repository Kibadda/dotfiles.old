if not plugins_ok "packer" then
  local directory = string.format("%s/site/pack/packer/start/", vim.fn.stdpath "data")

  vim.fn.mkdir(directory, "p")

  local github_url = "https://github.com/wbthomason/packer.nvim"

  vim.fn.system(string.format("git clone %s %s/packer.nvim", github_url, directory))

  vim.ui.input {
    prompt = "You need to restart now (press anything to continue)",
    on_confirm = function()
      vim.cmd.qa()
    end,
  }

  return true
end

return false
