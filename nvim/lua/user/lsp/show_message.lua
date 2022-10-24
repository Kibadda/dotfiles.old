local protocol = require "vim.lsp.protocol"

_LspMessageBuffer = _LspMessageBuffer or vim.api.nvim_create_buf(false, true)

local bufnr = _LspMessageBuffer
local border = { "┌", "─", "┐", "│", "┘", "─", "└", "│" }

local function create_window(messages)
  local lines = #messages

  local width = 0
  for _, message in ipairs(messages) do
    width = math.max(width, #message + 1)
  end

  local ui_width = vim.api.nvim_list_uis()[1].width

  local win_height = math.min(50, lines)
  local win_width = math.min(150, width) + 5

  return vim.api.nvim_open_win(bufnr, false, {
    relative = "editor",
    style = "minimal",
    height = win_height,
    width = win_width,
    row = 1,
    col = ui_width - win_width - 2,
    border = border,
  })
end

return function(_, result, ctx)
  local client = vim.lsp.get_client_by_id(ctx.client_id)

  local client_name = client and client.name or string.format("id=%d", ctx.client_id)

  local messages = {}

  if not client then
    error "error"
  end

  if result.type == protocol.MessageType.Error then
    error "error"
  else
    local type = protocol.MessageType[result.type]
    table.insert(messages, string.format("LSP %s %s", client_name, type))
    for _, text in ipairs(vim.split(result.message, "\n")) do
      table.insert(messages, ("  %s  "):format(text))
    end
  end

  vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, messages)

  local win_id = create_window(messages)

  vim.api.nvim_create_autocmd("CursorMoved", {
    pattern = "*",
    once = true,
    callback = function()
      vim.api.nvim_win_close(win_id, true)
    end,
  })
end
