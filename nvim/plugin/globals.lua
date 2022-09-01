--- pretty print given value
-- @param value any
-- @return any
function P(value)
  print(vim.inspect(value))
  return value
end

--- register keymaps
-- @param options table
function RegisterKeymaps(options)
  local keymaps = table.remove(options, 1)
  if options.mode == nil then
    error "RegisterKeymap: mode is not set"
  end
  if options.prefix == nil then
    error "RegisterKeymap: prefix is not set"
  end
  require("which-key").register(keymaps, options)
end

--- for wrapped lines: gj/gk, for large jumps: add to jump list
-- @param direction strin
function JumpDirection(direction)
  local count = vim.v.count

  if count == 0 then
    vim.cmd.normal { "g" .. direction, bang = true }
    return
  end

  if count > 5 then
    vim.cmd.normal { "m'", bang = true }
  end

  vim.cmd.normal { count .. direction, bang = true }
end
