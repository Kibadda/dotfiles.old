local function get_buffers()
  local bufnums = vim.api.nvim_list_bufs()

  local current_buf = vim.api.nvim_get_current_buf()
  local buffers = {}
  for _, bufnum in ipairs(bufnums) do
    if vim.fn.buflisted(bufnum) == 1 then
      local uri = vim.split(vim.uri_from_bufnr(bufnum), "/")
      local opts = {
        bufnum = bufnum,
        current = current_buf == bufnum,
        filename = uri[#uri],
        modified = vim.fn.getbufinfo(bufnum)[1].changed == 1,
      }
      table.insert(buffers, opts)
    end
  end

  return buffers
end

function RenderTabline()
  local tabline_string = ""

  for _, buffer in ipairs(get_buffers()) do
    local buffer_string = ""
    buffer_string = buffer_string .. "%" .. buffer.bufnum .. "T"
    if buffer.current then
      buffer_string = buffer_string .. "%#TabLineSel#"
    else
      buffer_string = buffer_string .. "%#TabLine#"
    end
    buffer_string = buffer_string .. "[" .. buffer.bufnum .. ":" .. buffer.filename
    if buffer.modified then
      buffer_string = buffer_string .. " +"
    end
    buffer_string = buffer_string .. "]"

    tabline_string = tabline_string .. buffer_string
  end

  return tabline_string .. "%#TabLineFill#"
end

vim.opt.showtabline = 2
vim.cmd [[
  set tabline=%!v:lua.RenderTabline()
]]
