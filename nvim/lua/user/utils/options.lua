local M = {}

function M.set(options)
  for key, value in pairs(options) do
    vim.opt[key] = value
  end
end

function M.set_buffer(options)
  for key, value in pairs(options) do
    vim.bo[key] = value
  end
end

function M.set_window(options)
  for key, value in pairs(options) do
    vim.wo[key] = value
  end
end

return M
