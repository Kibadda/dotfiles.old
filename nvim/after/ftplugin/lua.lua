local fmt = string.format

local function split(str, delim)
  delim = delim or "%s"
  return string.gmatch(str, fmt("[^%s]+", delim))
end

local function dir_separator()
  if package.config then
    return string.match(package.config, "^[^\n]")
  else
    return "/"
  end
end

local function include_paths(fname, ext)
  ext = ext or "lua"
  local sep = dir_separator()
  local paths = string.gsub(package.path, "%?", fname)
  for path in split(paths, "%;") do
    if vim.fn.filereadable(path) == 1 then
      return path
    end
  end
end

local function include_rtpaths(fname, ext)
  ext = ext or {}
  local sep = dir_separator()
  local rtpaths = vim.api.nvim_list_runtime_paths()
  local modfile, initfile = fmt("%s.%s", fname, ext), fmt("init.%s", ext)
  for _, path in ipairs(rtpaths) do
    local path1 = table.concat({ path, ext, modfile }, sep)
    if vim.fn.filereadable(path1) == 1 then
      return path1
    end

    local path2 = table.concat({ path, ext, fname, initfile }, sep)
    if vim.fn.filereadable(path2) == 1 then
      return path2
    end
  end
end

function find_required_path(module)
  local sep = string.match(package.config, "^[^\n]")
  local fname = vim.fn.substitute(module, "\\.", sep, "g")
  local f

  f = include_paths(fname, "lua")
  if f then
    return f
  end
  f = include_rtpaths(fname, "lua")
  if f then
    return f
  end
end

vim.opt_local.include = [=[\v<((do|load)file|require)\s*\(?['"]\zs[^'"]+\ze['"]]=]
vim.opt_local.includeexpr = "v:lua.find_required_path(v:fname)"

vim.opt_local.textwidth = 120
vim.opt_local.shiftwidth = 2
vim.opt_local.formatoptions = vim.opt_local.formatoptions - "o"
