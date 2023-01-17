local M = {}

M.modified = {
  provider = "%m",
}

M.filepath = {
  provider = function()
    return vim.fn.fnamemodify(vim.fn.expand "%", ":.")
  end,
  update = { "BufEnter" },
}

M.lines = {
  provider = ":%L",
}

return M
