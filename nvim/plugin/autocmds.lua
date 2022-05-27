local utils = require "lib.utils"
local core = require "lib.core"

------------------------------------
-- Misc
------------------------------------

local MiscGroup = vim.api.nvim_create_augroup("Misc", { clear = true })

vim.api.nvim_create_autocmd("BufWritePre", {
  group = MiscGroup,
  pattern = "*",
  callback = utils.strip_trailing_whitespaces,
})

------------------------------------
-- Terminal
------------------------------------

local TerminalGroup = vim.api.nvim_create_augroup("Terminal", { clear = true })

vim.api.nvim_create_autocmd("TermOpen", {
  group = TerminalGroup,
  pattern = "*",
  callback = function ()
    vim.opt_local.filetype = "term"
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.opt_local.signcolumn = "no"
    vim.opt_local.spell = false
    vim.cmd [[startinsert]]
  end
})

vim.api.nvim_create_autocmd("TermClose", {
  group = TerminalGroup,
  pattern = "*",
  command = "bdelete!",
})

------------------------------------
-- Config
------------------------------------

local ConfigGroup = vim.api.nvim_create_augroup("Config", { clear = true })

-- vim.api.nvim_create_autocmd("BufWritePost", {
--   group = ConfigGroup,
--   pattern = {
--     core.get_homedir() .. "/.dotfiles/nvim/init.lua",
--     core.get_homedir() .. "/.dotfiles/nvim/lua/lib/*.lua",
--     core.get_homedir() .. "/.dotfiles/nvim/lua/user/*.lua",
--     core.get_homedir() .. "/.dotfiles/nvim/lua/user/plugins/*/*.lua",
--   },
--   command = "source <afile>",
-- })

vim.api.nvim_create_autocmd("BufEnter", {
  group = ConfigGroup,
  pattern = {
    core.get_homedir() .. "/.dotfiles/kitty/*.conf",
    core.get_homedir() .. "/.dotfiles/i3/config"
  },
  command = "setlocal filetype=bash",
})

------------------------------------
-- Lsp
------------------------------------

local LanguageServerGroup = vim.api.nvim_create_augroup("LanguageServer", { clear = true })

-- vim.api.nvim_create_autocmd("BufRead", {
--   group = LanguageServerGroup,
--   pattern = "*",
--   callback = function ()
--     require("lint").try_lint()
--   end,
-- })
--
-- vim.api.nvim_create_autocmd("BufWritePost", {
--   group = LanguageServerGroup,
--   pattern = "*",
--   callback = function ()
--     require("lint").try_lint()
--   end,
-- })

------------------------------------

-- vim.defer_fn(function ()
--   if utils.get_git_root() ~= 0 then
--     vim.api.nvim_create_user_command("OpenInGithub", function (_)
--       local remotes = utils.get_git_remotes()
--
--       if #remotes > 1 then
--         vim.ui.select(remotes, { prompt = "remote> " }, function (remote)
--           utils.open_repo_on_github(remote)
--         end)
--       else
--         utils.open_repo_on_github(remotes[1])
--       end
--     end, {
--       bang = true,
--       nargs = 0,
--       desc = "Open chosen remote on Github, in the Browser"
--     })
--   end
-- end, 0)
