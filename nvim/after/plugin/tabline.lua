local function get_buffers()
  local bufnums = vim.api.nvim_list_bufs()

  local current_buf = vim.api.nvim_get_current_buf()
  local buffers = {}
  for _, bufnum in ipairs(bufnums) do
    if vim.fn.buflisted(bufnum) == 1 then
      local uri = vim.split(vim.uri_from_bufnr(bufnum), "/")
      if string.find(uri[1], "term") == nil then
        local opts = {
          bufnum = bufnum,
          current = current_buf == bufnum,
          filename = uri[#uri],
          modified = vim.fn.getbufinfo(bufnum)[1].changed == 1,
        }
        table.insert(buffers, opts)
      end
    end
  end

  return buffers
end

function RenderTabline()
  local tabline_string = ""

  for _, buffer in ipairs(get_buffers()) do
    local buffer_string = ""
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

    tabline_string = tabline_string .. buffer_string .. "%#TabLineFill# "
  end

  tabline_string = tabline_string .. "%#TabLineFill#"

  if string.len(tabline_string) > vim.api.nvim_win_get_width(0) then
    -- TODO: figure out what to do with tabline_string
  end

  return tabline_string
end

function NextBuffer(force)
  force = force or false
  if force or vim.bo.filetype ~= "term" then
    vim.cmd [[:bnext]]
    if vim.bo.filetype == "term" then
      NextBuffer(true)
    end
  end
end

function PrevBuffer(force)
  force = force or false
  if force or vim.bo.filetype ~= "term" then
    vim.cmd [[:bprevious]]
    if vim.bo.filetype == "term" then
      PrevBuffer(true)
    end
  end
end

function DelBuffer()
  if vim.bo.filetype ~= "term" then
    vim.cmd [[:bdelete]]
    if vim.bo.filetype == "term" then
      NextBuffer(true)
    end
  end
end

vim.cmd [[hi TabLineSel guibg=#3a3a3a guifg=#99cc99 ctermbg=065 ctermfg=007]]
vim.cmd [[hi TabLineFill guibg=#262626 guifg=#c0c0c0 ctermbg=239 ctermfg=237]]
vim.cmd [[hi TabLine guibg=#262626 guifg=#c0c0c0 ctermbg=252 ctermfg=239]]

vim.opt.showtabline = 2
vim.cmd [[
  set tabline=%!v:lua.RenderTabline()
]]
