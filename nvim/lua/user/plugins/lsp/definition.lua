local M = {}

local win_id = nil

vim.api.nvim_create_autocmd("WinClosed", {
  group = vim.api.nvim_create_augroup("UnsetWinIdOnDefinitionWinClosed", { clear = true }),
  callback = function(args)
    if tonumber(args.file) == win_id then
      win_id = nil
    end
  end,
})

function M.open()
  if not win_id then
    vim.cmd.vsplit()
  else
    local cur_buf = vim.api.nvim_get_current_buf()
    local cursor = vim.api.nvim_win_get_cursor(0)
    vim.api.nvim_set_current_win(win_id)
    vim.api.nvim_win_set_buf(win_id, cur_buf)
    vim.api.nvim_win_set_cursor(win_id, cursor)
  end

  vim.lsp.buf.definition()
  win_id = vim.api.nvim_get_current_win()
end

return M
