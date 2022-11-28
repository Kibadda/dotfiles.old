local M = {}

function M.open_terminal(opts)
  opts = vim.tbl_extend("keep", opts or {}, {
    position = "right",
    size = 60,
  })

  local cmd = ""
  if opts.position == "top" or opts.position == "left" then
    cmd = cmd .. "topleft "
  end
  if opts.size ~= nil then
    cmd = cmd .. opts.size
  end
  if opts.position == "left" or opts.position == "right" then
    cmd = cmd .. "v"
  end
  cmd = cmd .. "split"

  vim.cmd(cmd)
  local winid = vim.api.nvim_get_current_win()
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_set_current_win(winid)
  vim.api.nvim_win_set_buf(winid, buf)
  vim.keymap.set("t", "<C-h>", "<C-\\><C-n><C-w><C-h>", { buffer = buf })
  vim.keymap.set("t", "<C-j>", "<C-\\><C-n><C-w><C-j>", { buffer = buf })
  vim.keymap.set("t", "<C-k>", "<C-\\><C-n><C-w><C-k>", { buffer = buf })
  vim.keymap.set("t", "<C-l>", "<C-\\><C-n><C-w><C-l>", { buffer = buf })
  vim.fn.termopen(os.getenv "SHELL")
end

return M
