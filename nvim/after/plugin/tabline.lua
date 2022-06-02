local function get_current_index(buffers)
  for i, entry in ipairs(buffers) do
    if entry.current then
      return i
    end
  end
end

local function shorten_path(filepath)
  local ft = vim.split(filepath, "/")
  local rv = {}

  for i = 1, #ft - 1 do
    table.insert(rv, string.sub(ft[i], 1, 1))
  end

  table.insert(rv, ft[#ft])

  return table.concat(rv, "/")
end

local function get_buffer_string(buffer, shorten)
  shorten = shorten or false
  return (buffer.current and "%#TabLineSel#" or "%#TabLine#")
    .. "["
    .. buffer.bufnum
    .. ":"
    .. (shorten and buffer.shorten_filename or buffer.filename)
    .. (buffer.modified and " +" or "")
    .. "]"
end

local function get_buffers()
  local bufnums = vim.api.nvim_list_bufs()
  local current_buf = vim.api.nvim_get_current_buf()

  local buffers = {}
  for _, bufnum in ipairs(bufnums) do
    if vim.fn.buflisted(bufnum) == 1 then
      local filepath = vim.fn.expand("#" .. bufnum)

      if string.find(filepath, "^term://") == nil then
        local filename = filepath
        local shorten_filename = shorten_path(filepath)
        local modified = vim.fn.getbufinfo(bufnum)[1].changed == 1
        local strlen = 3 + string.len(bufnum) + string.len(filename)
        local shorten_strlen = 3 + string.len(bufnum) + string.len(shorten_filename)
        if modified then
          strlen = strlen + 2
          shorten_strlen = shorten_strlen + 2
        end

        local opts = {
          bufnum = bufnum,
          current = current_buf == bufnum,
          filename = filename,
          shorten_filename = shorten_filename,
          modified = modified,
          strlen = strlen,
          shorten_strlen = shorten_strlen,
        }
        table.insert(buffers, opts)
      end
    end
  end

  return buffers
end

local TablineString = ""
local TablineStringLength = 0
local MaxLength = 0

local function add_buffer_on_left(buffer, shorten)
  if TablineStringLength + (shorten and buffer.shorten_strlen or buffer.strlen) < MaxLength then
    TablineString = get_buffer_string(buffer, shorten) .. "%#TabLineFill# " .. TablineString
    TablineStringLength = TablineStringLength + (shorten and buffer.shorten_strlen or buffer.strlen)
  else
    -- TODO: handle "<<<"
  end
end

local function add_buffer_on_right(buffer, shorten)
  if TablineStringLength + (shorten and buffer.shorten_strlen or buffer.strlen) < MaxLength then
    TablineString = TablineString .. "%#TabLineFill# " .. get_buffer_string(buffer, shorten)
    TablineStringLength = TablineStringLength + (shorten and buffer.shorten_strlen or buffer.strlen)
  else
    -- TODO: handle ">>>"
  end
end

function RenderTabline()
  TablineString = ""
  TablineStringLength = 0
  MaxLength = vim.api.nvim_win_get_width(0)
  local shorten = vim.g.tabline_shorten_filepath or false

  local buffers = get_buffers()
  local current_index = get_current_index(buffers)
  if current_index == nil then
    current_index = math.ceil(#buffers / 2)
  end

  if #buffers > 0 then
    local left = vim.list_slice(buffers, 1, current_index - 1)
    local middle = buffers[current_index]
    local right = vim.list_slice(buffers, current_index + 1, #buffers)

    local i = math.min(#left, #right)

    TablineString = get_buffer_string(middle)
    TablineStringLength = middle.strlen
    for j = 1, i do
      add_buffer_on_left(left[#left - j + 1], shorten)
      add_buffer_on_right(right[j], shorten)
    end

    if #left > #right then
      for j = #left - i, 1, -1 do
        add_buffer_on_left(left[j], shorten)
      end
    elseif #left < #right then
      for j = i + 1, #right do
        add_buffer_on_right(right[j], shorten)
      end
    end

    return TablineString .. "%#TabLineFill#"
  end

  return ""
end

function TablineToggleShortenFilePath()
  vim.g.tabline_shorten_filepath = not vim.g.tabline_shorten_filepath
  vim.cmd [[
    set tabline=%!v:lua.RenderTabline()
  ]]
end

vim.keymap.set("n", "<LEADER>tt", "<CMD>lua TablineToggleShortenFilePath()<CR>")

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
