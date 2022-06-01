local function search_table(key, value, table)
  for _, entry in ipairs(table) do
    if entry[key] == value then
      return entry
    end
  end

  return nil
end

local function get_current_index(buffers)
  for i, entry in ipairs(buffers) do
    if entry.current then
      return i
    end
  end
end

local function get_buffer_string(buffer)
  return (buffer.current and "%#TabLineSel#" or "%#TabLine#")
    .. "["
    .. buffer.bufnum
    .. ":"
    .. buffer.filename
    .. (buffer.modified and " +" or "")
    .. "]"
end

local function convert_buffers_to_string(buffers)
  local strings = {}

  for _, buffer in ipairs(buffers) do
    table.insert(strings, get_buffer_string(buffer))
  end

  return strings
end

local function get_buffers()
  local bufnums = vim.api.nvim_list_bufs()

  local current_buf = vim.api.nvim_get_current_buf()
  local buffers = {}
  for _, bufnum in ipairs(bufnums) do
    if vim.fn.buflisted(bufnum) == 1 then
      local uri = vim.split(vim.uri_from_bufnr(bufnum), "/")

      if string.find(uri[1], "term") == nil then
        local filename = uri[#uri]
        local modified = vim.fn.getbufinfo(bufnum)[1].changed == 1
        local strlen = 3 + string.len(bufnum) + string.len(filename)
        if modified then
          strlen = strlen + 2
        end

        local opts = {
          bufnum = bufnum,
          current = current_buf == bufnum,
          filename = filename,
          modified = modified,
          strlen = strlen,
        }
        table.insert(buffers, opts)
      end
    end
  end

  return buffers
end

function RenderTabline()
  local buffers = get_buffers()
  local max_len = vim.api.nvim_win_get_width(0)
  local current_index = get_current_index(buffers)
  if current_index == nil then
    current_index = math.ceil(#buffers / 2)
  end

  local left = vim.list_slice(buffers, 1, current_index - 1)
  local middle = buffers[current_index]
  local right = vim.list_slice(buffers, current_index + 1, #buffers)

  local i = math.min(#left, #right)

  local maxlen = vim.api.nvim_win_get_width(0)
  local strlen = middle.strlen
  local str = get_buffer_string(middle)
  for j = 1, i do
    if strlen + left[#left - j + 1].strlen <= maxlen then
      str = get_buffer_string(left[#left - j + 1]) .. str
      strlen = strlen + left[#left - j + 1].strlen
    else
      -- TODO: handle "<<<"
    end

    if strlen + right[j].strlen <= maxlen then
      str = str .. get_buffer_string(right[j])
      strlen = strlen + right[j].strlen
    else
      -- TODO: handle ">>>"
    end
  end

  if #left < #right then
    for j = i + 1, #right do
      if strlen + right[j].strlen <= maxlen then
        str = str .. get_buffer_string(right[j])
        strlen = strlen + right[j].strlen
      else
        -- TODO: handle ">>>"
      end
    end
  else
    for j = #left - i, 1, -1 do
      if strlen + left[j].strlen <= maxlen then
        str = get_buffer_string(left[j]) .. str
        strlen = strlen + left[j].strlen
      else
        -- TODO: handle "<<<"
      end
    end
  end

  return str .. "%#TabLineFill#"

  -- local strings_table = {}
  --
  -- for _, buffer in ipairs(get_buffers()) do
  --   table.insert(strings_table, get_buffer_string(buffer))
  -- end
  --
  -- local tabline_string = table.concat(strings_table, "%#TabLineFill# ") .. "%#TabLineFill#"
  --
  -- return tabline_string
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
