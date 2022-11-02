---set value depending if cwd is cortex
---@param value_if_work any
---@param default any
function SetValue(value_if_work, default)
  local dir = vim.fn.getcwd()

  if string.find(dir, "^/media/beta/") then
    return value_if_work
  end

  return default
end

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

  -- if not check then
  --   vim.defer_fn(function()
  --     vim.notify(table.concat(not_installed, "\n"), "info", { title = "Packages not installed" })
  --   end, 1000)
  -- end

  return check
end
