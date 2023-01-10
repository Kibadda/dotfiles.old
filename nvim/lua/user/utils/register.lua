local M = {}

--- ```lua
--- local options = {
---   "mode" = keymaps,
--- }
--- ```
--- `mode` can be a string or a table with additional options
--- e.g.:
--- ```lua
--- local options = {
---   [{ mode = "n", buffer = 15 }] = {
---     ["<Leader>f"] = { function() print "pressed leader+f" end, "Printing stuff" },
---   },
---   i = {
---     -- ...
---   }
--- }
--- ```
---@param options table
function M.keymaps(options)
  for opts, keymaps in pairs(options) do
    if type(opts) ~= "table" then
      opts = { mode = opts }
    end
    if not pcall(require, "which-key") then
      print "why is this not loaded"
    else
      require("which-key").register(keymaps, opts)
    end
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
