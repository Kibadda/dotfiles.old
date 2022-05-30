local ok, plenary_reload = pcall(require, "plenary.reload")
local reloader
if not ok then
  reloader = require
else
  reloader = plenary_reload.reload_module
end

P = function(value)
  print(vim.inspect(value))
  return value
end

RELOAD = function(...)
  return reloader(...)
end

R = function(name)
  RELOAD(name)
  return require(name)
end
