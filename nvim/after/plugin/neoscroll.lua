if not PluginsOk "neoscroll" then
  return
end

require("neoscroll").setup {
  mappings = {
    "<C-u>",
    "<C-d>",
    "<C-b>",
    "<C-f>",
    "<C-y>",
    "<C-e>",
    "zt",
    "zz",
    "zb",
  },
  -- pre_hook = function()
  --   vim.wo.cursorline = false
  -- end,
  -- post_hook = function()
  --   vim.wo.cursorline = true
  -- end,
}

RegisterKeymaps {
  mode = "n",
  prefix = "",
  {
    ["<C-u>"] = { "Scroll cursor up half page" },
    ["<C-d>"] = { "Scroll cursor down half page" },
    ["<C-b>"] = { "Scroll cursor up full page" },
    ["<C-f>"] = { "Scroll cursor down full page" },
    ["<C-y>"] = { "Scroll page down" },
    ["<C-e>"] = { "Scroll page up" },
  },
}
