if not pcall(require, "telescope") then
  return
end

local sorters = require "telescope.sorters"

TelescopeMapArgs = TelescopeMapArgs or {}

local map_tele = function(key, f, options, buffer)
  local map_key = vim.api.nvim_replace_termcodes(key .. f, true, true, true)

  TelescopeMapArgs[map_key] = options or {}

  local mode = "n"
  local rhs = string.format("<CMD>lua R('kibadda.telescope')['%s'](TelescopeMapArgs['%s'])<CR>", f, map_key)

  local map_options = {
    noremap = true,
    silent = true,
  }

  if not buffer then
    vim.api.nvim_set_keymap(mode, key, rhs, map_options)
  else
    vim.api.nvim_buf_set_keymap(0, mode, key, rhs, map_options)
  end
end

vim.api.nvim_set_keymap("c", "<C-r><C-r>", "<Plug>(TelescopeFuzzyCommandSearch)", { noremap = false, nowait = true })

-- Dotfiles
map_tele("<Leader>en", "edit_neovim")
map_tele("<Leader>ez", "edit_zsh")

-- Search
-- TODO: I would like to completely remove _mock from my search results here when I'm in SG/SG
map_tele("<Leader>gw", "grep_string", {
  short_path = true,
  word_match = "-w",
  only_sort_text = true,
  layout_strategy = "vertical",
  sorter = sorters.get_fzy_sorter(),
})
map_tele("<Leader>f/", "grep_last_search", {
  layout_strategy = "vertical",
})

-- Files
map_tele("<Leader>ft", "git_files")
-- map_tele("<Leader>fg", "live_grep")
map_tele("<Leader>fg", "multi_rg")
map_tele("<Leader>fo", "oldfiles")
map_tele("<Leader>fd", "fd")
map_tele("<Leader>fs", "fs")
map_tele("<Leader>pp", "project_search")
map_tele("<Leader>fe", "file_browser")
map_tele("<Leader>fz", "search_only_certain_files")

-- Git
map_tele("<Leader>gs", "git_status")
map_tele("<Leader>gc", "git_commits")

-- Nvim
map_tele("<Leader>fb", "buffers")
map_tele("<Leader>fi", "search_all_files")
map_tele("<Leader>ff", "curbuf")
map_tele("<Leader>fh", "help_tags")
map_tele("<Leader>bo", "vim_options")
map_tele("<Leader>gp", "grep_prompt")
map_tele("<Leader>wt", "treesitter")

-- Telescope Meta
map_tele("<Leader>fB", "builtin")

return map_tele
