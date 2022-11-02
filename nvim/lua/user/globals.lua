---for wrapped lines: gj/gk, for large jumps: add to jump list
---@param direction string
function JumpDirection(direction)
  local count = vim.v.count

  if count == 0 then
    vim.cmd.normal { ("g%s"):format(direction), bang = true }
    return
  end

  if count > 5 then
    vim.cmd.normal { "m'", bang = true }
  end

  vim.cmd.normal { ("%d%s"):format(count, direction), bang = true }
end

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

---get formatoptions
---@return string
function GetFormatOptions()
  return "nljqrc"
end

---get env variable
---@param name string
function Env(name)
  return os.getenv(name)
end

---open plugin under cursor in browser
---works with:
---```lua
---use "author/plugin"
---use { "author/plugin", run = "do stuff" }
---use {
---  "author/plugin",
---  config = function()
---    P "Hello World!"
---  end,
---}
---```
---@param open_in_browser boolean
function OpenPlugin(open_in_browser)
  if open_in_browser == nil then
    error "[OpenPlugin]: open_in_browser must be set"
    return
  end

  local ts_utils = require "nvim-treesitter.ts_utils"
  local current_node = ts_utils.get_node_at_cursor(0)

  if current_node == nil then
    return
  end

  while current_node:type() ~= "function_call" do
    current_node = current_node:parent()
  end

  local node_string = vim.treesitter.get_node_text(current_node, 0)

  if string.sub(node_string, 1, 3) ~= "use" and string.sub(node_string, 1, 9) ~= "local_use" then
    return
  end

  local query_string = [[
    (
     (function_call
       name: (identifier)
       arguments: [
         (arguments (string) @argument)
         (arguments
           (table_constructor
             (field
               !name
               value: (string) @argument)))
       ])
    )
  ]]

  local root = vim.treesitter.get_string_parser(node_string, "lua", {}):parse()[1]:root()
  local _, node = vim.treesitter.parse_query("lua", query_string):iter_captures(root, 0, 0, -1)()
  local argument = vim.treesitter.get_node_text(node, node_string)
  argument = argument:gsub('"', "")

  if open_in_browser then
    os.execute(("xdg-open https://github.com/%s"):format(argument))
  else
    local split = vim.split(argument, "/", { plain = true })
    local file_name = split[#split]
    file_name = string.gsub(file_name, "nvim%-", "")
    file_name = string.gsub(file_name, "%.nvim", "")
    file_name = string.gsub(file_name, "vim%-", "")
    file_name = string.gsub(file_name, "%.vim", "")
    file_name = string.gsub(file_name, "%.lua", "")
    file_name = string.lower(file_name)

    local prefix = "nvim/after/plugin/"
    local suffix = ".lua"

    local file_path = ("%s%s%s"):format(prefix, file_name, suffix)

    if vim.fn.filereadable(file_path) == 1 then
      vim.cmd.e(file_path)
    else
      local Menu = require "nui.menu"
      local Input = require "nui.input"

      local function set_title(title)
        return {
          position = "50%",
          size = {
            width = 25,
            height = 3,
          },
          border = {
            style = "single",
            text = {
              top = title,
              top_align = "center",
            },
          },
          win_options = {
            winhighlight = "Normal:Normal,FloatBorder:Normal",
          },
        }
      end

      Menu(set_title "[Choose]", {
        lines = {
          Menu.item("Create File", { id = 1 }),
          Menu.item("Create File (other name)", { id = 2 }),
          Menu.item("Nothing", { id = 3 }),
        },
        max_width = 20,
        keymap = {
          focus_next = { "j", "<Tab>" },
          focus_prev = { "k", "<S-Tab>" },
          close = { "<Esc>" },
          submit = { "<CR>", "<Space>" },
        },
        on_submit = function(item)
          if item.id == 1 then
            vim.cmd.e(file_path)
          elseif item.id == 2 then
            Input(set_title "[Filename]", {
              prompt = "> ",
              on_submit = function(value)
                if #value > 0 then
                  vim.cmd.e(("%s%s%s"):format(prefix, value, suffix))
                end
              end,
            }):mount()
          end
        end,
      }):mount()
    end
  end
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
