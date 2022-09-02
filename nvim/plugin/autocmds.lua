vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("HighlightYank", { clear = true }),
  pattern = "*",
  command = "silent! lua vim.highlight.on_yank { higroup='Search', timeout = 200 }",
})

vim.api.nvim_create_autocmd("BufWritePre", {
  group = vim.api.nvim_create_augroup("RemoveTrailingWhitespace", { clear = true }),
  pattern = "*",
  callback = function()
    local cursor = vim.api.nvim_win_get_cursor(0)
    vim.api.nvim_command "%s/\\s\\+$//e"
    vim.api.nvim_win_set_cursor(0, cursor)
  end,
})

vim.api.nvim_create_autocmd("BufWritePost", {
  group = vim.api.nvim_create_augroup("SourcePluginFile", { clear = true }),
  pattern = "plugins.lua",
  command = "source <afile>",
})

local TermGroup = vim.api.nvim_create_augroup("TermGroup", { clear = true })

vim.api.nvim_create_autocmd("TermOpen", {
  group = TermGroup,
  pattern = "*",
  callback = function()
    SetOptionsLocal {
      filetype = "term",
    }
    vim.cmd.startinsert()
  end,
})

vim.api.nvim_create_autocmd("BufEnter", {
  group = TermGroup,
  pattern = "term://*",
  command = "startinsert",
})

vim.api.nvim_create_autocmd("TermClose", {
  group = TermGroup,
  pattern = "*",
  command = "bd!",
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
