local M = {
  truncation_limit_s_terminal = 110,
}

-- is buffer horizontally truncated
M.is_htruncated = function (width)
  local current_width = vim.api.nvim_win_get_width(0)
  return current_width < width
end

-- is buffer vertical truncated
M.is_vtruncated = function (height)
  local current_height = vim.api.nvim_win_get_height(0)
  return current_height < height
end

return M
