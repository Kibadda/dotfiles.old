local ok, plenary_reload = pcall(require, "plenary.reload")
local reloader
if not ok then
  reloader = require
else
  reloader = plenary_reload.reload_module
end

function P(value)
  print(vim.inspect(value))
  return value
end

function RELOAD(...)
  return reloader(...)
end

function R(name)
  RELOAD(name)
  return require(name)
end
