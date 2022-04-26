local M = {}

M.keymap = function(mode, lhs, rhs, opts)
  vim.api.nvim_set_keymap(
    mode,
    lhs,
    rhs,
    vim.tbl_extend('keep', opts or {}, { noremap = true, silent = true })
  )
end

M.buf_keymap = function(bufnr, mode, lhs, rhs, opts)
  vim.api.nvim_buf_set_keymap(
    bufnr,
    mode,
    lhs,
    rhs,
    vim.tbl_extend('keep', opts or {}, { noremap = true, silent = true })
  )
end

M.print = function (v)
  print(vim.inspect(v))
  return v
end

M.plenary_reload = function (name)
  if pcall(require, 'plenary') then
    local reloadModule = require('plenary.reload').reload_module
    reloadModule(name)
    return require(name)
  end
end

M.get_module_name = function (s)
  local module_name;

  module_name = string.gsub(s, "%.lua", '')
  module_name = string.gsub(module_name, "%/", '.')
  module_name = string.gsub(module_name, "%.init", "")

  return module_name
end


M.reload = function ()

  local prompt_title = '~ neovim modules ~'
  local path = '~/.dotfiles/nvim/lua'

  local opts = {
    prompt_title = prompt_title,
    cwd = path,
    attach_mappings = function (_, map)
      map('i', '<C-e>', function (_)
        local entry = require('telescope.actions.state').get_selected_entry()
        local name = M.get_module_name(entry.value)

        M.plenary_reload(name)
        M.print(name .. ' RELOADED!!!')
      end)

      return true
    end
  }

  require('telescope.builtin').find_files(opts)
end

return M
