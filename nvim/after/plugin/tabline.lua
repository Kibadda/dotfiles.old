local function get_buffers()
  local bufnums = vim.api.nvim_list_bufs()

  local current_buf = vim.api.nvim_get_current_buf()
  local buffers = {}
  for _, bufnum in ipairs(bufnums) do
    if vim.fn.buflisted(bufnum) == 1 then
      local opts = {
        bufnum = bufnum,
        current = current_buf == bufnum,
        filename = "placeholder",
        modified = true,
      }
      table.insert(buffers, opts)
    end
  end

  return buffers
end

local function render_tabline()
  local tabline_string = ""

  for _, buffer in ipairs(get_buffers()) do
    local tmp = {
      "[",
      buffer.bufnum,
      ":",
      buffer.filename,
    }

    if buffer.modified then
      table.insert(tmp, " +")
    end

    table.insert(tmp, "]")

    tabline_string = tabline_string .. table.concat(tmp)
  end

  return tabline_string
end

vim.opt.showtabline = 2
vim.opt.tabline = render_tabline()
