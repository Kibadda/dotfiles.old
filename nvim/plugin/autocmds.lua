vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("HighlightYank", { clear = true }),
  pattern = "*",
  callback = function()
    vim.highlight.on_yank {
      higroup = "Search",
      timeout = 200,
    }
  end,
})

vim.api.nvim_create_autocmd("BufWritePost", {
  group = vim.api.nvim_create_augroup("SourcePluginFile", { clear = true }),
  pattern = "plugins.lua",
  callback = function()
    vim.cmd.source "<afile>"
  end,
})

vim.api.nvim_create_autocmd("TermClose", {
  group = vim.api.nvim_create_augroup("TermGroup", { clear = true }),
  pattern = "*",
  callback = function()
    vim.cmd.bd { bang = true }
  end,
})

vim.api.nvim_create_autocmd("BufEnter", {
  group = vim.api.nvim_create_augroup("PluginsGitOpen", { clear = true }),
  pattern = "plugins.lua",
  callback = function()
    RegisterKeymaps {
      mode = "n",
      prefix = "",
      buffer = 0,
      {
        gX = {
          function()
            OpenPlugin(true)
          end,
          "Open plugin in Browser",
        },
        gF = {
          function()
            OpenPlugin(false)
          end,
          "Open plugin file",
        },
      },
    }
  end,
})
