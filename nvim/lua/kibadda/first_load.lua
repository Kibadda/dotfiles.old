local download_packer = function()
  if vim.fn.input "Download Packer? (y for yes)" ~= "y" then
    return
  end

  local directory = string.format("%s/site/pack/packer/start/", vim.fn.stdpath "data")

  vim.fn.mkdir(directory, "p")

  local out = vim.fn.system(
    string.format("git clone %s %s", "https://github.com/wbthomason/packer.nvim", directory .. "/packer.nvim")
  )

  print(out)
  print "Downloading packer.nvim"
end

local download_lsps = function()
  if vim.fn.input "Download Packer? (y for yes)" ~= "y" then
    return
  end

  if vim.fn.executable "npm" ~= 1 then
    return
  end

  print(
    vim.fn.system "npm i -g intelephense vscode-langservers-extracted typescript typescript-language-server vim-language-server"
  )
  print "Downloaded lsps"
end

return function()
  if not pcall(require, "packer") then
    download_packer()

    download_lsps()

    print "(You'll need to restart now)"
    vim.cmd [[qa]]
    return true
  end

  return false
end
