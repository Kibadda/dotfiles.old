--- set global variables for given plugin
-- @param plugin string
-- @param options table
function SetGlobal(plugin, options)
  local prefix = ""
  if plugin ~= "" then
    prefix = plugin .. "_"
  end
  for name, value in pairs(options) do
    vim.g[prefix .. name] = value
  end
end

--- get global variables for given plugin
-- @param plugin string
-- @param name string
function GetGlobal(plugin, name)
  return vim.g[plugin .. "_" .. name]
end

--- set global vim options
-- @param options table
function SetOptions(options)
  for key, value in pairs(options) do
    vim.opt[key] = value
  end
end

--- set buffer local vim options
-- @param options table
function SetOptionsLocal(options)
  for key, value in pairs(options) do
    vim.opt_local[key] = value
  end
end
