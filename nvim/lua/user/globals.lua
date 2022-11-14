---check if given plugins are installed
---@param plugins string|table
---@return boolean
function PluginsOk(plugins)
  if type(plugins) == "string" then
    plugins = { plugins }
  end

  if type(plugins) ~= "table" then
    return false
  end

  local check = true
  local not_installed = {}
  for _, plugin in pairs(plugins) do
    local plugin_ok = pcall(require, plugin)
    if not plugin_ok then
      check = false
      table.insert(not_installed, plugin)
    end
  end

  return check
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
