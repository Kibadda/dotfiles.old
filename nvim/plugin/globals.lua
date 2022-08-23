function P(value)
  print(vim.inspect(value))
  return value
end

function RegisterKeymaps(prefix, keymaps, options)
  options = options or {}
  options.prefix = prefix
  require("which-key").register(keymaps, options)
end
