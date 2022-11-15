---check if given plugins are installed
---@param plugins string|table
---@return boolean
function _G.plugins_ok(plugins)
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

  if require("user.utils.globals").get("", "notify_about_missing_plugins") and check == false then
    vim.notify(table.concat(not_installed, "\n"), vim.log.levels.INFO, { title = "Missing Plugins" })
  end

  return check
end
