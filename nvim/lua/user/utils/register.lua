local M = {}

---```lua
---local options = {
---  mode = "n",
---  prefix = "<Leader>",
---  which_key_option = "value"
---  {
---    f = { "<Cmd>Telescope find_files<CR>", "Find files" }
---  },
---}
---```
---@param options table
function M.keymaps(options)
  if not plugins_ok "which-key" then
    return
  end

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
  else
    require("which-key").register(keymaps, options)
  end
end

---register abbreviations
---@param abbreviations table
function M.abbreviations(abbreviations)
  for k, v in pairs(abbreviations) do
    vim.cmd.cabbrev(("%s %s"):format(k, v))
  end
end

return M
