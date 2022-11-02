local M = {}

---set global variables for given plugin
---@param plugin_name string
---@param options table
function M.set(plugin_name, options)
  local prefix = ""
  if plugin_name ~= "" then
    prefix = ("%s_"):format(plugin_name)
  end
  for option_name, option_value in pairs(options) do
    vim.g[("%s%s"):format(prefix, option_name)] = option_value
  end
end

---get global variable for given plugin
---@param plugin_name string
---@param option_name string
---@return any
function M.get(plugin_name, option_name)
  return vim.g[("%s_%s"):format(plugin_name, option_name)]
end

return M
