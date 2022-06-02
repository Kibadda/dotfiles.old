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
