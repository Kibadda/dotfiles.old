local M = {}

M.symbol = {
  provider = function()
    return require("nvim-navic").get_location()
  end,
}

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
