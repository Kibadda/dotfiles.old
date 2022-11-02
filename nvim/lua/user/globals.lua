---get env variable
---@param name string
function Env(name)
  return os.getenv(name)
end

---set global variables for given plugin
---@param plugin string
---@param options table
function SetGlobal(plugin, options)
  local prefix = ""
  if plugin ~= "" then
    prefix = ("%s_"):format(plugin)
  end
  for name, value in pairs(options) do
    vim.g[("%s%s"):format(prefix, name)] = value
  end
end

---get global variables for given plugin
---@param plugin string
---@param name string
---@return any
function GetGlobal(plugin, name)
  return vim.g[("%s_%s"):format(plugin, name)]
end

---set global vim options
---@param options table
function SetOptions(options)
  for key, value in pairs(options) do
    vim.o[key] = value
  end
end

---set buffer local vim options
---@param options table
function SetBufferOptions(options)
  for key, value in pairs(options) do
    vim.bo[key] = value
  end
end

---set window local vim options
---@param options table
function SetWindowOptions(options)
  for key, value in pairs(options) do
    vim.wo[key] = value
  end
end
