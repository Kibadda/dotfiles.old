---set global variables for given plugin
---@param plugin string
---@param options table
function SetGlobal(plugin, options)
  local prefix = ""
  if plugin ~= "" then
    prefix = plugin .. "_"
  end
  for name, value in pairs(options) do
    vim.g[prefix .. name] = value
  end
end

---get global variables for given plugin
---@param plugin string
---@param name string
---@return any
function GetGlobal(plugin, name)
  return vim.g[plugin .. "_" .. name]
end

---set global vim options
---@param options table
function SetOptions(options)
  for key, value in pairs(options) do
    vim.opt[key] = value
  end
end

---set buffer local vim options
---@param options table
function SetOptionsLocal(options)
  for key, value in pairs(options) do
    vim.opt_local[key] = value
  end
end

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

  if not check then
    vim.defer_fn(function()
      vim.notify(table.concat(not_installed, "\n"), "info", { title = "Packages not installed" })
    end, 1000)
  end

  return check
end
