---pretty print given value
---@param value any
---@return any
function P(value)
  print(vim.inspect(value))
  return value
end

---register keymaps
---local options = {
---  mode = "n",
---  prefix = "<Leader>",
---  which_key_option = "value"
---  {
---    f = { "<Cmd>Telescope find_files<CR>", "Find files" }
---  },
---}
---@param options table
function RegisterKeymaps(options)
  local keymaps = table.remove(options, 1)
  if options.mode == nil then
    error "RegisterKeymap: mode is not set"
  end
  if options.prefix == nil then
    error "RegisterKeymap: prefix is not set"
  end
  if options.mode == "" then
    for lhs, rhs in pairs(keymaps) do
      vim.keymap.set("", lhs, rhs[1], {
        desc = rhs[2],
      })
    end
  elseif type(options.mode) == "table" then
    for _, mode in ipairs(options.mode) do
      local opt = vim.deepcopy(options)
      opt.mode = mode
      require("which-key").register(keymaps, opt)
    end
  else
    require("which-key").register(keymaps, options)
  end
end

---for wrapped lines: gj/gk, for large jumps: add to jump list
---@param direction string
function JumpDirection(direction)
  local count = vim.v.count

  if count == 0 then
    vim.cmd.normal { "g" .. direction, bang = true }
    return
  end

  if count > 5 then
    vim.cmd.normal { "m'", bang = true }
  end

  vim.cmd.normal { count .. direction, bang = true }
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

---apply formatoptions
---@param options any
---@return any
function GetFormatOptions(options)
  return options.formatoptions
    - "a" -- do not auto format
    - "t" -- do not autowrap
    + "c" -- but do it for comments
    + "q" -- comment formatting
    - "o" -- do not insert comment leader when hitting o
    + "r" -- but to it for Enter
    + "n" -- format lists
    + "j" -- remove comment leader for J
    - "2" -- use first line for indent
end

---get env variable
---@param name string
function Env(name)
  return os.getenv(name)
end

---open current project in github
function OpenInGitub()
  local Job = require "plenary.job"
  local job1 = Job:new {
    command = "git",
    args = {
      "remote",
    },
    cwd = vim.fn.getcwd(),
  }
  job1:sync()
  local remote = job1:result()[1]
  local job2 = Job:new {
    command = "git",
    args = {
      "config",
      "--get",
      "remote." .. remote .. ".url",
    },
    cwd = vim.fn.getcwd(),
  }
  job2:sync()
  local remote_url = job2:result()[1]
  remote_url = string.gsub(remote_url, "%.git", "")
  remote_url = string.gsub(remote_url, ":", "/")
  remote_url = string.gsub(remote_url, "git@", "https://")
  os.execute("xdg-open " .. remote_url)
end

---open plugin under cursor in browser
---works with:
---use "author/plugin"
---use { "author/plugin", run = "do stuff" }
---use {
---  "author/plugin",
---  config = function()
---    P "Hello World!"
---  end,
---}
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

  if string.sub(node_string, 1, 3) ~= "use" then
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
    local url = "https://github.com/" .. argument
    os.execute("xdg-open " .. url)
  else
    local split = vim.split(argument, "/")
    local file_name = split[#split]
    file_name = string.gsub(file_name, "nvim%-", "")
    file_name = string.gsub(file_name, "%.nvim", "")
    file_name = string.gsub(file_name, "vim%-", "")
    file_name = string.gsub(file_name, "%.vim", "")
    file_name = string.gsub(file_name, "%.lua", "")
    file_name = string.lower(file_name)

    local prefix = "nvim/after/plugin/"
    local suffix = ".lua"

    local file_path = prefix .. file_name .. suffix

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
            style = "double",
            text = {
              top = title,
              top_align = "center",
            },
          },
          win_options = {
            winhighlight = "Normal:Normal,FloarBorder:Normal",
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
                  vim.cmd.e(prefix .. value .. suffix)
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