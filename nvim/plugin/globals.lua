--- pretty print given value
-- @param value any
-- @return any
function P(value)
  print(vim.inspect(value))
  return value
end

--- register keymaps
-- @param mode string    | which mode to use
-- @param prefix string  | which prefix to use
-- @param keymaps table  | table with all keymaps (see which-key github)
-- @param options ?table | additional options (see which-key github)
function RegisterKeymaps(mode, prefix, keymaps, options)
  options = options or {}
  options.prefix = prefix
  options.mode = mode
  require("which-key").register(keymaps, options)
end
